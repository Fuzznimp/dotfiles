-- Install lazy.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Fixes Notify opacity issues.
vim.o.termguicolors = true

require('lazy').setup({
  {
    'echasnovski/mini.nvim',
    version = false,
  },

  'lewis6991/gitsigns.nvim',

  { -- LSP Support.
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      -- LSP status updates.
      'j-hui/fidget.nvim',
    },
  },

  { -- Autocompletion.
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
  },

  { -- Debug Adapter Protocol.
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'mxsdev/nvim-dap-vscode-js', -- JavaScript/TypeScript debugging
    },
  },

  { -- File navigation.
    "nvim-telescope/telescope.nvim",
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  { -- Syntax highlighting.
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/playground',
      'HiPhish/rainbow-delimiters.nvim',
    },
    build = ':TSUpdate',
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },

  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      require("notify").setup({
        background_colour = "#000000",
        timeout = 3000,
        max_height = function()
          return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
          return math.floor(vim.o.columns * 0.75)
        end,
      })
      vim.notify = require("notify")
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      dashboard = { enabled = true },
      lazygit = {
        -- automatically configure lazygit to use the current colorscheme
        -- and integrate edit with the current neovim instance
        configure = true,
        -- extra configuration for lazygit that will be merged with the default
        -- snacks does NOT have a full yaml parser, so if you need `"test"` to appear with the quotes
        -- you need to double quote it: `"\"test\""`
        config = {
          os = { editPreset = "nvim-remote" },
          gui = {
            -- set to an empty string "" to disable icons
            nerdFontsVersion = "3",
          },
        },
        theme_path = vim.fs.normalize(vim.fn.stdpath("cache") .. "/lazygit-theme.yml"),
        -- Theme for lazygit
        theme = {
          [241]                      = { fg = "Special" },
          activeBorderColor          = { fg = "MatchParen", bold = true },
          cherryPickedCommitBgColor  = { fg = "Identifier" },
          cherryPickedCommitFgColor  = { fg = "Function" },
          defaultFgColor             = { fg = "Normal" },
          inactiveBorderColor        = { fg = "FloatBorder" },
          optionsTextColor           = { fg = "Function" },
          searchingActiveBorderColor = { fg = "MatchParen", bold = true },
          selectedLineBgColor        = { bg = "Visual" }, -- set to `default` to have no background colour
          unstagedChangesColor       = { fg = "DiagnosticError" },
        },
        win = {
          style = "lazygit",
        },
      },
    },
  },

  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
  },
})
