local mapkey = require("utils.key-mapper").mapkey

-- Directory Navigation
mapkey("<leader>m", "NvimTreeFocus", "n")
mapkey("<leader>e", "NvimTreeToggle", "n")

-- Pane and Window Navigation
mapkey("<C-h>", "<C-w>h", "n")            -- Navigate Left
mapkey("<C-j>", "<C-w>j", "n")            -- Navigate Down
mapkey("<C-k>", "<C-w>k", "n")            -- Navigate Up
mapkey("<C-l>", "<C-w>l", "n")            -- Navigate Right
mapkey("<C-h>", "wincmd h", "t")          -- Navigate Left
mapkey("<C-j>", "wincmd j", "t")          -- Navigate Down
mapkey("<C-k>", "wincmd k", "t")          -- Navigate Up
mapkey("<C-l>", "wincmd l", "t")          -- Navigate Right
mapkey("<C-h>", "TmuxNavigateLeft", "n")  -- Navigate Left
mapkey("<C-j>", "TmuxNavigateDown", "n")  -- Navigate Down
mapkey("<C-k>", "TmuxNavigateUp", "n")    -- Navigate Up
mapkey("<C-l>", "TmuxNavigateRight", "n") -- Navigate Right

-- Window Management
mapkey("<leader>sv", "vsplit", "n")          -- Split Vertically
mapkey("<leader>sh", "split", "n")           -- Split Horizontally
mapkey("<leader>sm", "MaximizerToggle", "n") -- Toggle Minimise

-- Indenting
-- FIXME: This is not working.
mapkey("<", "v", "<gv") -- Shift Indentation to Left
mapkey(">", "v", ">gv") -- Shift Indentation to Right

-- Comments
vim.api.nvim_set_keymap("n", "<leader>/", "gtc", { noremap = false })
vim.api.nvim_set_keymap("v", "<leader>/", "goc", { noremap = false })
