return {
  'HiPhish/rainbow-delimiters.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    local rainbow_delimiters = require('rainbow-delimiters.setup')
    rainbow_delimiters.setup({
      strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
      },
      query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
      },
      highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterGreen',
        'RainbowDelimiterOrange',
      },
    })
  end,
}
