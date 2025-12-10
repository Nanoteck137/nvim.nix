-- vim.keymap.set('n', ' ', function () end, { silent = true })

vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- vim.keymap.set('n', '<leader>-', '<C-W>s', { desc = 'Split horizontally' });
-- vim.keymap.set('n', '<leader>|', '<C-W>v', { desc = 'Split vertically' });

-- vim.keymap.set('n', '<C-h>', '<C-w>h');
-- vim.keymap.set('n', '<C-j>', '<C-w>j');
-- vim.keymap.set('n', '<C-k>', '<C-w>k');
-- vim.keymap.set('n', '<C-l>', '<C-w>l');

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')

-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>ff', function() require("telescope.builtin").find_files() end, {})
vim.keymap.set('n', '<leader>bb', function() require("telescope.builtin").buffers() end, {})
vim.keymap.set('n', '<leader>ht', function() require("telescope.builtin").help_tags() end, {})


vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end, { desc = "Open Lazygit" })

vim.keymap.set('n', '<leader>e', function() Snacks.explorer() end, { desc = "Open file explorer" })

vim.keymap.set('n', '<leader>zz', function() Snacks.zen.zoom() end, { desc = "Zoom" })
vim.keymap.set('n', '<leader>nh', function() Snacks.notifier.show_history() end, { desc = "Open notification history" })
