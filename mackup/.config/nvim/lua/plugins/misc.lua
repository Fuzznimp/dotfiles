return {
  {
    "ThePrimeagen/refactoring.nvim",
    lazy = true,
    keys = {
      {
        "<leader>r",
        function()
          require("refactoring").select_refactor()
        end,
        mode = "v",
        noremap = true,
        silent = true,
        expr = false,
      },
    },
    opts = {},
  },
  { "ThePrimeagen/vim-be-good", lazy = true },
}
