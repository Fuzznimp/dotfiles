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
    disable = { "txt", "md", "jsx", "tsx" },
    enable = true,
    extended_mode = false,
    module_path = "rainbow.internal",
    termcolors = { "Red", "Green", "Yellow", "Blue", "Magenta", "Cyan", "White" },
  },
  auto_install = true,
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },
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
    ignore = true,
  },
  -- exclude = {},

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
