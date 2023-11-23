-- TODO
-- return {
--   "rktjmp/lush.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd("colorscheme lush")
--   end
-- }

return {
  "morhetz/gruvbox",
  lazy = false,
  priority = 999,
  config = function()
    vim.cmd("colorscheme gruvbox")
  end,
}
