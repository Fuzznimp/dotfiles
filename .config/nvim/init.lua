-- Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("keymaps")
require("plugins.lazy")
require("options")
require("misc")
require("plugins.mini")
-- require("plugins.mini-base16")
require("plugins.catppuccin")
require("plugins.mini-files")
require("plugins.lsp")
require("plugins.gitsigns")
require("plugins.cmp")
require("plugins.treesitter")
require("plugins.telescope")
require("plugins.which-key")
