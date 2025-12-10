vim.api.nvim_create_user_command("Help", function()
  require("telescope.builtin").help_tags()
end, { desc = "Open help search" })

-- TODO(patrik): I want a bufdelete for every buffer except the current open windows
vim.api.nvim_create_user_command("BufDelete", function()
  Snacks.bufdelete()
end, { desc = "Delete the current buffer" })

