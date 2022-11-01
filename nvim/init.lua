local autocmd = vim.api.nvim_create_autocmd
local opt = vim.opt

opt.nu = true
opt.relativenumber = true

opt.smartindent = true

opt.cursorline = true

vim.opt.updatetime = 50

opt.clipboard:append "unnamedplus"

opt.splitright = true
opt.splitbelow = true

autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})
