local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "typescript",
    "c",
    "json",
    "javascript",
    "tsx",
    "yaml",
    "markdown",
    "graphql",
    "bash",
    "dockerfile",
  },
  rainbow = {
    colors = { "#8b4513", "#228b22", "#cc7722" },
    disable = { "txt", "md" },
    enable = true,
    extended_mode = true,
    module_path = "rainbow.internal",
    termcolors = { "Red", "Green", "Yellow", "Blue", "Magenta", "Cyan", "White" },
  },
  auto_install = true,
}

M.mason = {
  ensure_installed = {
    "lua-language-server",
    "stylua",
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "json-lsp",
    "tailwindcss-language-server",
    "prettierd",
		"stylua",
		"eslint_d",
  },
  auto_install = true,
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
