require("snacks")

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

-- TODO: replace with vim.diagnostic.jump()
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- TODO: replace with vim.diagnostic.jump()
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Toggle Trouble Diagnostics' })
-- vim.keymap.set('n', '<leader>', function() require('trouble').open() end, { desc = 'Open Trouble' })

-- vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Find Files' })
-- vim.keymap.set('n', '<leader>bb', require('telescope.builtin').buffers, { desc = 'Find Buffers' })
vim.keymap.set('n', '<leader>ff', function()
  Snacks.picker.files({
    preview = nil,
    layout = {
      preset = "dropdown",
      hidden = { "preview" },
      layout = {
        height = 0.5,
      },
    },
  })
end, { desc = 'Find Files' })

vim.keymap.set('n', '<leader>bb', function()
  Snacks.picker.buffers({
    win = {
      input = {
        keys = {
          ["dd"] = { "bufdelete", mode = { "n" } },
        },
      },
    },
  })
end, { desc = 'Find Buffers' })
-- vim.keymap.set('n', '<leader>hh', require('telescope.builtin').help_tags, {})

vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end, { desc = 'Open Lazygit' })

vim.keymap.set('n', '<leader>p', function() Snacks.explorer() end, { desc = 'Open file explorer' })

-- vim.keymap.set('n', '<leader>zz', function() Snacks.zen.zoom() end, { desc = 'Zoom' })
-- vim.keymap.set('n', '<leader>nh', function() Snacks.notifier.show_history() end, { desc = 'Open notification history' })

vim.keymap.set('n', '<leader>tt', '<cmd>Grapple toggle<cr>', { desc = 'Open Grapple' })
vim.keymap.set('n', '<leader>te', '<cmd>Grapple toggle_tags<cr>', { desc = 'Toggle File for Grapple' })

vim.keymap.set('n', '<leader>1', '<cmd>Grapple select index=1<cr>', { desc = 'Grapple select tag #1' })
vim.keymap.set('n', '<leader>2', '<cmd>Grapple select index=2<cr>', { desc = 'Grapple select tag #2' })
vim.keymap.set('n', '<leader>3', '<cmd>Grapple select index=3<cr>', { desc = 'Grapple select tag #3' })
vim.keymap.set('n', '<leader>4', '<cmd>Grapple select index=4<cr>', { desc = 'Grapple select tag #4' })
vim.keymap.set('n', '<leader>5', '<cmd>Grapple select index=5<cr>', { desc = 'Grapple select tag #5' })
vim.keymap.set('n', '<leader>6', '<cmd>Grapple select index=6<cr>', { desc = 'Grapple select tag #6' })
vim.keymap.set('n', '<leader>7', '<cmd>Grapple select index=7<cr>', { desc = 'Grapple select tag #7' })
vim.keymap.set('n', '<leader>8', '<cmd>Grapple select index=8<cr>', { desc = 'Grapple select tag #8' })
vim.keymap.set('n', '<leader>9', '<cmd>Grapple select index=9<cr>', { desc = 'Grapple select tag #9' })

vim.keymap.set('n', '<leader>tp', '<cmd>Grapple cycle_tags prev<cr>', { desc = 'Go to previous Grapple tag' })
vim.keymap.set('n', '<leader>tn', '<cmd>Grapple cycle_tags next<cr>', { desc = 'Go to next Grapple tag' })

local actions = {
  format = {
    name = "Format Code",
    run = function()
      vim.lsp.buf.format()
    end
  },

  help = {
    name = "Open Help",
    run = function()
      -- require('telescope.builtin').help_tags()
      Snacks.picker.help()
    end
  },

  notification_history = {
    name = "Open Notification history",
    run = function()
      Snacks.notifier.show_history()
    end
  },

  zoom = {
    name = "Toggle Zen-Zoom",
    run = function()
      Snacks.zen.zoom()
    end
  },

  bufdel = {
    name = "Delete current buffer",
    run = function()
      Snacks.bufdelete()
    end
  },
}

local function show_actions()
  local items = vim.tbl_keys(actions)

  vim.ui.select(items, {
    prompt = 'Select an action:',
    format_item = function(item)
      return actions[item].name
    end,
  }, function(choice)
    if choice ~= nil then
      actions[choice].run()
    end
  end)
end

vim.keymap.set('n', '<leader>pp', show_actions)
