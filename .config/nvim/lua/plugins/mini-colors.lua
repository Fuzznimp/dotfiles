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
  purple = "#d3869b",
  red = "#ea6962",
  yellow = "#d8a657",
  none = "NONE",
}

return {
  {
    'echasnovski/mini.colors',
    version = false,
    config = function()
      local MiniColors = require('mini.colors')

      -- Define color palette
      local palette = {
        -- Base colors
        bg = chart.bg,
        bg_dark = chart.bg1,
        fg = chart.fg,

        -- Semantic colors
        error = chart.red,
        warning = chart.yellow,
        info = chart.blue,
        hint = chart.green,

        -- Syntax colors
        string = chart.yellow,
        keyword = chart.orange,
        func = chart.green,
        variable = chart.fg,
        type = chart.blue,
        constant = chart.purple,
        comment = chart.bg3,

        -- Git colors
        git_add = chart.green,
        git_change = chart.blue,
        git_delete = chart.red,

        -- Rainbow parentheses
        rainbow = {
          chart.purple,
          chart.green,
          chart.orange,
          chart.blue,
        }
      }

      -- Create a custom colorscheme
      local custom_colorscheme = MiniColors.setup_default_style({
        palette = palette,
        styles = {
          comment = 'italic',
          keyword = 'bold',
          type = 'italic',
        },
        transparent_background = true,
        diagnostic_virtual_text = {
          error = 'italic',
          warning = 'italic',
          info = 'italic',
          hint = 'italic',
        }
      })

      -- Optional: Apply the colorscheme
      vim.cmd('colorscheme mini-colors')
    end
  }
}
