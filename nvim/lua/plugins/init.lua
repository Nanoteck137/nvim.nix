require("plugins.treesitter")
require("plugins.tokyonight")
require("plugins.telescope")
require("plugins.snacks")
require("plugins.cmp")

require("lualine").setup()

require("which-key").setup({})

require('Comment').setup()

require("todo-comments").setup({
  highlight = {
    before = "",          -- "fg" or "bg" or empty
    keyword = "bg",       -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
    after = "fg",         -- "fg" or "bg" or empty
    pattern = [[.*<(KEYWORDS)(\([^\)]*\))?:]],
    comments_only = true, -- uses treesitter to match keywords in comments only
    max_line_len = 400,   -- ignore lines longer than this
    exclude = {},         -- list of file types to exclude highlighting
  },
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    pattern = [[\b(KEYWORDS)(\([^\)]*\))?:]],
  },
})

require("oil").setup({})

-- require('neo-tree').setup({})
-- vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>')

require("grapple").setup({})

require("trouble").setup({})


