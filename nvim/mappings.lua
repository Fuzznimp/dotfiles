local M = {}

M.general = {
  n = {
    [";"] = { ":", "command mode", opts = { nowait = true } },
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
    ["<C-n>"] = { "<cmd> NvimTreeFocus <CR>", "focus nvimtree" },
    ["<leader>rs"] = { ":LspRestart<CR>", "mapping to restart lsp if necessary" },
    -- Window management.
    ["<leader>sv"] = { "<C-w>v", "split window vertically" },
    ["<leader>sh"] = { "<C-w>s", "split window horizontally" },
    ["<leader>se"] = { "<C-w>=", "make split windows equal width & height" },
    ["<leader>sx"] = { ":close<CR>", "close current split window" },
    -- Tab management.
    ["<leader>to"] = { ":tabnew<CR>", "open new tab" },
    ["<leader>tx"] = { ":tabclose<CR>", "close current tab" },
    ["<leader>tn"] = { ":tabn<CR>", "go to next tab" },
    ["<leader>tp"] = { "<cmd> set nu! <CR>", "go to previous tab" },
  },
  i = {
    ["jk"] = { "<ESC>", "escape vim" },
  },
}

return M
