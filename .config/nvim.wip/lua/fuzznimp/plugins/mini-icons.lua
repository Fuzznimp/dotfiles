require('mini.icons').setup({
  -- Whether to disable cache (not recommended)
  disable_cache = false,

  -- Custom aliases for icons to be used in `require('mini.icons').get()`
  aliases = {},

  -- Default preset
  preset = 'default',

  -- Custom icons in "default" preset. See `:h mini.icons-default-preset`
  custom = {
    -- Custom icons for filetype
    FileType = {
      default = '',
      git = '',
      lua = '',
      python = '',
      typescript = '',
      javascript = '',
      html = '',
      css = '',
      scss = '',
      json = '',
      yaml = '',
      toml = '',
      markdown = '',
      rust = '',
      go = '',
      dockerfile = '',
      sh = '',
    },
  },
})
