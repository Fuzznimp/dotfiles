local overrides = require "custom.plugins.overrides"

return {
  ["goolord/alpha-nvim"] = { disable = false },
  ["folke/which-key.nvim"] = { disable = false },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = overrides.treesitter,
  },
  ["williamboman/mason.nvim"] = {
    override_options = overrides.mason,
  },
  ["kyazdani42/nvim-tree.lua"] = {
    override_options = overrides.nvimtree,
  },
  ["max397574/better-escape.nvim"] = {
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },
  ["nvim-telescope/telescope.nvim"] = {
    override_options = overrides.telescope,
  },
  ["nvim-treesitter/playground"] = {
    cmd = "TSCaptureUnderCursor",
    config = function()
      require("nvim-treesitter.configs").setup()
    end,
  },
  ["glepnir/lspsaga.nvim"] = {
    config = function()
      require "custom.plugins.lspsaga"
    end,
  },
  ["jose-elias-alvarez/typescript.nvim"] = {},
  ["NvChad/ui"] = {
    override_options = {
      statusline = {
        separator_style = "arrow",
      },
    },
  },
  ["p00f/nvim-ts-rainbow"] = {
    config = function()
      require "nvim-treesitter.configs"
    end,
  },
  ["windwp/nvim-ts-autotag"] = {
    ft = { "html", "javascriptreact", "jsx", "tsx", "typescriptreact" },
    after = "nvim-treesitter",
    config = function()
      local present, autotag = pcall(require, "nvim-ts-autotag")

      if present then
        autotag.setup()
      end
    end,
  },
}
