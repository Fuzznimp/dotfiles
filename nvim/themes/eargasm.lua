local M = {}

M.base_30 = {
  white = "#ebdbb2",
  darker_black = "#222222",
  black = "#282828", --  nvim bg
  black2 = "#2e2e2e",
  one_bg = "#323232",
  one_bg2 = "#3b3b3b",
  one_bg3 = "#434343",
  grey = "#505050",
  grey_fg = "#5a5a5a",
  grey_fg2 = "#646464",
  light_grey = "#6c6c6c",
  red = "#ea6962",
  baby_pink = "#ce8196",
  pink = "#ff75a0",
  line = "#373737", -- for lines like vertsplit
  green = "#a9b665",
  vibrant_green = "#a9b665",
  nord_blue = "#a9b665",
  blue = "#6d8dad",
  yellow = "#d8a657",
  sun = "#eab869",
  purple = "#d3869b",
  dark_purple = "#d3869b",
  teal = "#749689",
  orange = "#e78a4e",
  cyan = "#89b482",
  statusline_bg = "#2c2c2c",
  lightbg = "#393939",
  pmenu_bg = "#89b482",
  folder_bg = "#d8a657",
}

M.base_16 = {
  base00 = "#202020",
  base01 = "#2e2e2e",
  base02 = "#323232",
  base03 = "#434343",
  base04 = "#d4be98",
  base05 = "#c0b196",
  base06 = "#d4be98",
  base07 = "#c7b89d",
  base08 = "#dfbf8e",
  base09 = "#e78a4e",
  base0A = "#7daea3",
  base0B = "#e3a84e",
  base0C = "#dfbf8e",
  base0D = "#a9b665",
  base0E = "#e78a4e",
  base0F = "#dfbf8e",
}

-- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md
M.polish_hl = {
  Include = { fg = M.base_30.baby_pink },
  Repeat = { fg = M.base_16.base0E },
  ["@keyword.return"] = { fg = M.base_30.red },
  ["@variable"] = { fg = M.base_16.base08 },
  ["@property"] = { fg = M.base_16.base0C },
  ["@exception"] = { fg = M.base_30.red },
  Boolean = { fg = M.base_30.baby_pink },
  Number = { fg = M.base_30.baby_pink },
  Parameter = { fg = M.base_16.base09 },
}

vim.opt.bg = "dark"

return M

-- https://github.com/NvChad/base46/blob/master/lua/base46/themes/gruvbox_material.lua
-- https://github.com/chriskempson/base16/blob/main/styling.md
-- base00 - Default Background
-- base01 - Lighter Background (Used for status bars, line number and folding marks)
-- base02 - Selection Background
-- base03 - Comments, Invisibles, Line Highlighting
-- base04 - Dark Foreground (Used for status bars)
-- base05 - Default Foreground, Caret, Delimiters, Operators
-- base06 - Light Foreground (Not often used)
-- base07 - Light Background (Not often used)
-- base08 - Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
-- base09 - Integers, Boolean, Constants, XML Attributes, Markup Link Url
-- base0A - Classes, Markup Bold, Search Text Background
-- base0B - Strings, Inherited Class, Markup Code, Diff Inserted
-- base0C - Support, Regular Expressions, Escape Characters, Markup Quotes
-- base0D - Functions, Methods, Attribute IDs, Headings
-- base0E - Keywords, Storage, Selector, Markup Italic, Diff Changed
-- base0F - Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
