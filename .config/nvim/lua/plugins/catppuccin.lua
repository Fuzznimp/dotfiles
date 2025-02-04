local chart = {
  bg = "#202020",
  bg1 = "#303030",
  bg2 = "#4e4e4e",
  bg3 = "#626262",
  bg4 = "#888888",
  bg5 = "#a8a8a8",
  fg = "#d5c4a1",
  blue = "#7DAEA3",
  green = "#a9b665",
  orange = "#e78a4e",
  pink = "#d3869b",
  red = "#ea6962",
  yellow = "#d8a657",
}

require("catppuccin").setup({
  flavour = "mocha",
  background = {
    light = "latte",
    dark = "mocha",
  },
  transparent_background = true,
  show_end_of_buffer = false,
  term_colors = false,
  dim_inactive = {
    enabled = false,
    shade = "dark",
    percentage = 0.15,
  },
  color_overrides = {
    mocha = {
      base = chart.bg,
      mantle = chart.bg1,
      crust = chart.bg2,

      text = chart.fg,
      subtext1 = chart.bg5,
      subtext0 = chart.bg4,
      overlay2 = chart.bg4,
      overlay1 = chart.bg3,
      overlay0 = chart.bg2,
      surface2 = chart.bg2,
      surface1 = chart.bg1,
      surface0 = chart.bg,

      blue = chart.blue,
      green = chart.green,
      red = chart.red,
      yellow = chart.yellow,
      peach = chart.orange,
      mauve = chart.pink,
      pink = chart.pink,
      flamingo = chart.red,
      rosewater = chart.red,
      lavender = chart.blue,
      sapphire = chart.blue,
      teal = chart.blue,
      sky = chart.blue,
      maroon = chart.red,
    },
  },
  integrations = {
    cmp = true,
    gitsigns = true,
    mason = true,
    mini = true,
    telescope = true,
    treesitter = true,
    notify = false,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
  },
})

-- Set colorscheme after options
vim.cmd.colorscheme "catppuccin"
