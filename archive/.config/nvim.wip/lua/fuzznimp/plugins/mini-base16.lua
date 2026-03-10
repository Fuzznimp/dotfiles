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

require("mini.base16").setup({
  palette = {
    base00 = chart.bg,     -- Default background
    base01 = chart.bg1,    -- Lighter background (status bars)
    base02 = chart.bg2,    -- Selection background
    base03 = chart.bg3,    -- Comments, invisibles
    base04 = chart.bg4,    -- Dark foreground (status bars)
    base05 = chart.fg,     -- Default foreground
    base06 = chart.bg5,    -- Light foreground
    base07 = chart.fg,     -- Light background
    base08 = chart.fg,     -- Variables
    base09 = chart.fg,     -- Constants
    base0A = chart.fg,     -- Classes
    base0B = chart.orange, -- Strings
    base0C = chart.fg,     -- Support, regular expressions
    base0D = chart.fg,     -- Functions, methods
    base0E = chart.orange, -- Keywords
    base0F = chart.red,    -- Deprecated
  },
  use_cterm = true,
  plugins = {
    default = true,
    mini = true,
    telescope = true,
    treesitter = true,
    native_lsp = true,
  },
})

-- Set transparent background
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    -- Normal text
    vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
    -- Line numbers
    vim.cmd("highlight LineNr guibg=NONE ctermbg=NONE")
    -- Sign column (gutter)
    vim.cmd("highlight SignColumn guibg=NONE ctermbg=NONE")
    -- Fold column
    vim.cmd("highlight FoldColumn guibg=NONE ctermbg=NONE")
  end,
})
