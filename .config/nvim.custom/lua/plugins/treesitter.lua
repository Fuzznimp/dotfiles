require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "bash",
    "css",
    "csv",
    "dockerfile",
    "gitignore",
    "go",
    "graphql",
    "html",
    "http",
    "javascript",
    "json",
    "json5",
    "lua",
    "markdown_inline",
    "markdown",
    "nginx",
    "python",
    "query",
    "regex",
    "rust",
    "sql",
    "tmux",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "xml",
    "yaml",
  },
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
})
