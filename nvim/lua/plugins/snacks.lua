require("snacks").setup({
  lazygit = {
    win = {
      height = 0.9,
    },
  },
  -- scroll = {};
  explorer = {},
  indent = {},
  statuscolumn = {},
  zen = {},
  input = {},
  notifier = {},

  picker = {
    ui_select = true,
  },

  -- dashboard = {
  --   sections = {
  --     { section = "header" },
  --     { section = "keys",  gap = 1, padding = 1 },
  --   },
  -- },

  terminal = {
    win = {
      height = 0.25,
      keys = {
        term_normal = {
          '<Esc><Esc>',
          '<C-\\><C-n>',
          mode = "t",
          expr = true,
          desc = "Double escape to normal mode",
        },
      },
    },
  },
})
