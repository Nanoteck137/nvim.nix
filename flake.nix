{
  description = "My Neovim config using nix flakes";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [];
        pkgs = import nixpkgs {
          inherit system overlays;
        };

        lib = pkgs.lib;

        neovim-unwrapped = pkgs.neovim-unwrapped;

        plugins = let 
          harpoon = pkgs.vimUtils.buildVimPlugin {
            name = "harpoon";
            doCheck = false;
            src = pkgs.fetchFromGitHub {
              owner = "ThePrimeagen";
              repo = "harpoon";
              rev = "a84ab829eaf3678b586609888ef52f7779102263";
              hash = "sha256-PjB64kdmoCD7JfUB7Qz9n34hk0h2/ZZRlN8Jv2Z9HT8=";
            };
          };
        in with pkgs; [
          vimPlugins.nvim-web-devicons
          vimPlugins.tokyonight-nvim

          vimPlugins.plenary-nvim
          vimPlugins.nui-nvim
          vimPlugins.snacks-nvim

          vimPlugins.nvim-treesitter.withAllGrammars
          vimPlugins.telescope-fzf-native-nvim
          vimPlugins.telescope-nvim

          vimPlugins.blink-cmp
          vimPlugins.friendly-snippets

          vimPlugins.nvim-lspconfig
          vimPlugins.lazydev-nvim

          vimPlugins.lualine-nvim
          vimPlugins.which-key-nvim

          vimPlugins.comment-nvim
          vimPlugins.todo-comments-nvim
          vimPlugins.trouble-nvim

          vimPlugins.oil-nvim

          vimPlugins.grapple-nvim
        ];

        externalPackages = with pkgs; [
          ripgrep
          fd
          lazygit
        ];
        ignoreConfigRegexes = [];
        extraLuaPackages = p: [];

        defaultPlugin = {
          plugin = null; 
          config = null; 
          optional = false;
          runtime = {};
        };


        normalizedPlugins = map (x:
          defaultPlugin
          // (
            if x ? plugin
            then x
            else {plugin = x;}
          ))
        plugins;

        neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
          withPython3 = true;
          viAlias = true;
          vimAlias = true;
          plugins = normalizedPlugins;
        };

        nvimRtpSrc = let
          src = ./nvim;
        in
          lib.cleanSourceWith {
            inherit src;
            name = "nvim-rtp-src";
            filter = path: tyoe: let
              srcPrefix = toString src + "/";
              relPath = lib.removePrefix srcPrefix (toString path);
            in
              lib.all (regex: builtins.match regex relPath == null) ignoreConfigRegexes;
          };

        nvimRtp = pkgs.stdenv.mkDerivation {
          name = "nvim-rtp";
          src = nvimRtpSrc;

          buildPhase = ''
            mkdir -p $out/nvim
            mkdir -p $out/lua
          '';

          installPhase = ''
            if [ -d "lua" ]; then
                cp -r lua $out/lua
            fi

            if [ -d "after" ]; then
                cp -r after $out/after
            fi

            if [ ! -z "$(ls -A)" ]; then
                cp -r -- * $out/nvim
            fi
          '';
        };

        initLua =
          ''
            -- prepend lua directory
            vim.opt.rtp:prepend('${nvimRtp}/lua')
          ''
          + (builtins.readFile ./nvim/init.lua)
          + ''
            vim.opt.rtp:prepend('${nvimRtp}/nvim')
            vim.opt.rtp:prepend('${nvimRtp}/after')
          '';

        extraMakeWrapperArgs = builtins.concatStringsSep " " (
          (lib.optional (externalPackages != [])
            ''--prefix PATH : "${lib.makeBinPath externalPackages}"'')
        );

        luaPackages = neovim-unwrapped.lua.pkgs;
        resolvedExtraLuaPackages = extraLuaPackages luaPackages;

        # Native Lua libraries
        extraMakeWrapperLuaCArgs =
          lib.optionalString (resolvedExtraLuaPackages != [])
          ''--suffix LUA_CPATH ";" "${lib.concatMapStringsSep ";" luaPackages.getLuaCPath resolvedExtraLuaPackages}"'';

        # Lua libraries
        extraMakeWrapperLuaArgs =
          lib.optionalString (resolvedExtraLuaPackages != [])
          ''--suffix LUA_PATH ";" "${lib.concatMapStringsSep ";" luaPackages.getLuaPath resolvedExtraLuaPackages}"'';

        # wrapNeovimUnstable is the nixpkgs utility function for building a Neovim derivation.
        neovim-wrapped = pkgs.wrapNeovimUnstable neovim-unwrapped (neovimConfig
          // {
            luaRcContent = initLua;
            wrapperArgs =
              lib.escapeShellArgs neovimConfig.wrapperArgs
              + " "
              + extraMakeWrapperArgs
              + " "
              + extraMakeWrapperLuaCArgs
              + " "
              + extraMakeWrapperLuaArgs;
            wrapRc = true;
          });
      in
      {
        packages = {
          default = neovim-wrapped;
        };
      }
    );
}
