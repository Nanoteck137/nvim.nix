require("snacks").setup({
  lazygit = {},
  -- scroll = {};
  explorer = {
  },

  indent = {},
  statuscolumn = {},
  zen = {},
  dashboard = {
    sections = {
      { section = "header" },
      { section = "keys",  gap = 1, padding = 1 },
    },
  },

  notifier = {},
})

-- TODO(patrik): I want a bufdelete for every buffer except the current open windows
vim.api.nvim_create_user_command("BufDelete", function()
  Snacks.bufdelete()
end, { desc = "Delete the current buffer" })

vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end, { desc = "Open Lazygit" })

vim.keymap.set('n', '<leader>e', function() Snacks.explorer() end, { desc = "Open file explorer" })

vim.keymap.set('n', '<leader>zz', function() Snacks.zen.zoom() end, { desc = "Zoom" })
vim.keymap.set('n', '<leader>nh', function() Snacks.notifier.show_history() end, { desc = "Open notification history" })

-- vim.keymap.set('n', '<leader>ze', function() Snacks.zen() end, { desc = "Zen Mode" })
--

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
  ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
    if not client or type(value) ~= "table" then
      return
    end
    local p = progress[client.id]

    for i = 1, #p + 1 do
      if i == #p + 1 or p[i].token == ev.data.params.token then
        p[i] = {
          token = ev.data.params.token,
          msg = ("[%3d%%] %s%s"):format(
            value.kind == "end" and 100 or value.percentage or 100,
            value.title or "",
            value.message and (" **%s**"):format(value.message) or ""
          ),
          done = value.kind == "end",
        }
        break
      end
    end

    local msg = {} ---@type string[]
    progress[client.id] = vim.tbl_filter(function(v)
      return table.insert(msg, v.msg) or not v.done
    end, p)

    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    vim.notify(table.concat(msg, "\n"), "info", {
      id = "lsp_progress",
      title = client.name,
      opts = function(notif)
        notif.icon = #progress[client.id] == 0 and " "
          or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
      end,
    })
  end,
})
