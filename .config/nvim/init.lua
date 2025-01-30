-- Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("keymaps")
require('plugins.lazy')
require("options")
require("misc")
require('plugins.mini')
-- require("plugins.mini-base16")  -- Commented out
require("plugins.catppuccin") -- Added this line
require('plugins.mini-files')
require('plugins.lsp')
require('plugins.gitsigns')
require('plugins.cmp')
require('plugins.treesitter')
require('plugins.telescope')
