-- local foo = {
--   bg_dark = "#1e2030",
--   bg_float = "#1e2030",
--   bg_highlight = "#2f334d",
--   bg_popup = "#1e2030",
--   bg_search = "#3e68d7",
--   bg_sidebar = "#1e2030",
--   bg_statusline = "#1e2030",
--   bg_visual = "#3654a7",
--   black = "#1b1d2b",
--   blue = "#82aaff",
--   blue0 = "#3e68d7",
--   blue1 = "#65bcff",
--   blue2 = "#0db9d7",
--   blue5 = "#89ddff",
--   blue6 = "#b4f9f8",
--   blue7 = "#394b70",
--   border = "#1b1d2b",
--   border_highlight = "#589ed7",
--   comment = "#636da6",
--   cyan = "#86e1fc",
--   dark3 = "#545c7e",
--   dark5 = "#737aa2",
--   diff = {
--     add = "#273849",
--     change = "#252a3f",
--     delete = "#3a273a",
--     text = "#394b70",
--   },
--   error = "#c53b53",
--   fg = "#c8d3f5",
--   fg_dark = "#828bb8",
--   fg_float = "#c8d3f5",
--   fg_gutter = "#3b4261",
--   fg_sidebar = "#828bb8",
--   git = {
--     add = "#b8db87",
--     change = "#7ca1f2",
--     delete = "#e26a75",
--     ignore = "#545c7e",
--   },
--   gitSigns = {
--     add = "#627259",
--     change = "#485a86",
--     delete = "#b55a67",
--   },
--   green = "#c3e88d",
--   green1 = "#4fd6be",
--   green2 = "#41a6b5",
--   hint = "#4fd6be",
--   info = "#0db9d7",
--   magenta = "#c099ff",
--   magenta2 = "#ff007c",
--   none = "NONE",
--   orange = "#ff966c",
--   purple = "#fca7ea",
--   red = "#ff757f",
--   red1 = "#c53b53",
--   teal = "#4fd6be",
--   terminal_black = "#444a73",
-- }
local chart = {
  bg = "#202020",
  fg = "#d5c4a1",
  blue = "#7DAEA3",
  green = "#a9b665",
  orange = "#e78a4e",
  purple = "#d3869b",
  red = "#ea6962",
  yellow = "#d8a657",
}


return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(highlights, colors)
        local c = colors
        c.bg = chart.bg
        c.fg = chart.fg
        c.yellow = chart.yellow
        c.warning = chart.yellow
        c.orange = chart.orange
        c.blue = chart.blue
        c.purple = chart.purple
        c.red = chart.red
        c.error = chart.red
        c.green = chart.green

        local h = highlights
        h["@boolean"] = { fg = c.purple }
        h["@conditional.ternary.tsx"] = { fg = c.orange }
        h["@conditional.tsx"] = { fg = c.red }
        h["@constant.builtin.tsx"] = { fg = c.purple }
        h["@constant"] = { fg = chart.fg }
        h["@constructor.tsx"] = { fg = c.orange }
        h["@exception.tsx"] = { fg = c.red }
        h["@function"] = { fg = c.green }
        h["@include"] = { fg = c.fg }
        h["@keyword.operator.tsx"] = { fg = c.red }
        h["@keyword.return.tsx"] = { fg = c.red }
        h["@keyword"] = { fg = c.orange }
        h["@lsp.type.class.typescriptreact"] = { fg = c.blue }
        h["@lsp.type.enum.typescriptreact"] = { fg = c.purple }
        h["@lsp.type.enumMember.typescriptreact"] = { fg = c.blue }
        h["@lsp.type.function.typescriptreact"] = { fg = c.green }
        h["@lsp.type.parameter.typescriptreact"] = { fg = chart.fg }
        h["@lsp.type.type.typescriptreact"] = { fg = c.blue }
        h["@lsp.typemod.function.defaultLibrary.typescriptreact"] = { fg = c.green }
        h["@method.call.tsx"] = { fg = c.green }
        h["@number.tsx"] = { fg = c.purple }
        h["@operator"] = { fg = c.orange }
        h["@property"] = { fg = chart.fg }
        h["@punctuation.delimiter.tsx"] = { fg = c.fg }
        h["@string"] = { fg = c.yellow }
        h["@tag.attribute.tsx"] = { fg = c.green }
        h["@tag.delimiter.tsx"] = { fg = c.green }
        h["@type.builtin.tsx"] = { fg = c.blue }
        h["@type.builtin.tsx"] = { fg = c.blue }
        h["@type.tsx"] = { fg = c.blue }
        h["@variable"] = { fg = c.fg }
        h["@punctuation.bracket"] = { fg = c.fg }
        h["@lsp.typemod.member.declaration.typescriptreact"] = { fg = c.green }
        h["@punctuation.special.tsx"] = { fg = c.orange }
      end,
    },
  },
}
