-- Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


if vim.g.vscode then
  require("core.keymaps")
  require("core.options")
  require("core.misc")
else
  require("core.keymaps")
  require("core.options")
  require("core.misc")
  require("plugins.colorscheme")
  require("plugins.mini")
  require("plugins.mini-starter")
  require("plugins.mini-icons")
  require("plugins.mini-files")
  require("plugins.telescope")
  require("plugins.which-key")
  require("plugins.lsp")
  require("plugins.gitsigns")
  require("plugins.cmp")
  require("plugins.treesitter")
  require("plugins.mini-hipatterns")
  require("plugins.mini-indentscope")
  require("plugins.mini-trailspace")
  require("plugins.noice")
  require("plugins.web-devicons")
  -- require("plugins.snacks-lazygit")
  require("plugins.treesitter-playground")
  require("plugins.rainbow-delimiters")
end
