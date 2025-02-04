require("mini.files").setup({
  windows = {
    preview = true,
    width_preview = 100,
  },
})

-- Close mini.files before using Telescope.
vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopeFindPre",
  callback = function()
    local ok, mini_files = pcall(require, "mini.files")
    if ok then
      mini_files.close()
    end
  end
})

-- Keymaps
vim.keymap.set("n", "<leader>t", function()
  require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
end, { desc = "Open mini.files (directory of current file)" })

-- Open mini.files at current working directory
vim.keymap.set("n", "<leader>T", function()
  require("mini.files").open(vim.loop.cwd(), true)
end, { desc = "Open mini.files (cwd)" })
