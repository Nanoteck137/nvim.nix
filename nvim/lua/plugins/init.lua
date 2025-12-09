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

vim.keymap.set('n', '<leader>tt', '<cmd>Grapple toggle<cr>')
vim.keymap.set('n', '<leader>te', '<cmd>Grapple toggle_tags<cr>')

vim.keymap.set('n', '<leader>1', '<cmd>Grapple select index=1<cr>')
vim.keymap.set('n', '<leader>2', '<cmd>Grapple select index=2<cr>')
vim.keymap.set('n', '<leader>3', '<cmd>Grapple select index=3<cr>')
vim.keymap.set('n', '<leader>4', '<cmd>Grapple select index=4<cr>')
vim.keymap.set('n', '<leader>5', '<cmd>Grapple select index=5<cr>')
vim.keymap.set('n', '<leader>6', '<cmd>Grapple select index=6<cr>')
vim.keymap.set('n', '<leader>7', '<cmd>Grapple select index=7<cr>')
vim.keymap.set('n', '<leader>8', '<cmd>Grapple select index=8<cr>')
vim.keymap.set('n', '<leader>9', '<cmd>Grapple select index=9<cr>')

vim.keymap.set('n', '<leader>tn', '<cmd>Grapple cycle_tags next<cr>')
vim.keymap.set('n', '<leader>tp', '<cmd>Grapple cycle_tags prev<cr>')


-- -- NOTE(patrik): Trouble keymap
-- vim.keymap.set('n', '<leader>tt', function() require("trouble").toggle() end, { desc = "Toggle Trouble" })
-- vim.keymap.set('n', '<leader>to', function() require("trouble").open() end, { desc = "Open Trouble" })

