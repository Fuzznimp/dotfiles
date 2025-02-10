-- starter.mini
-- Center content horizontally
local function center_content()
  local lines = {}
  local ascii = {
    "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
    "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
    "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
    "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
    "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
    "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
    "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
    " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
    " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
    "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
    "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
    "",
    "               Fuzznimp               ",
  }

  for _, line in ipairs(ascii) do
    local padding = string.rep(' ', math.floor((vim.o.columns - string.len(line)) / 2))
    table.insert(lines, padding .. line)
  end
  return table.concat(lines, '\n')
end

-- Setup mini plugins.
return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    -- Hipatterns
    require('mini.hipatterns').setup({
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    })

    -- Starter



    -- Highlight trailing whitespace
    require('mini.trailspace').setup({
      -- Only highlight in normal buffers (ones with empty 'buftype'). This is
      -- useful to not show trailing whitespace where it usually doesn't matter
      only_in_normal_buffers = true,
    })

    local starter = require('mini.starter')
    starter.setup({
      -- Whether to open starter buffer on VimEnter
      autoopen = true,

      -- Whether to evaluate action of single active item
      evaluate_single = false,

      -- Content shown in starter buffer
      content_hooks = {
        starter.gen_hook.adding_bullet(),
        starter.gen_hook.aligning('center'),
      },

      -- Set header with centered hydra ASCII art
      header = center_content(),

      -- Set footer (empty in this case)
      footer = '',

      -- Items shown after header and before footer
      items = {
        { section = 'Recent files', name = 'Open recent file',  action = 'Telescope oldfiles' },
        { section = 'Sessions',     name = 'Load last session', action = 'SessionLoad' },
      }
    })

    require('mini.indentscope').setup({
      -- Draw options
      draw = {
        -- Delay (in ms) between event and start of drawing scope indicator
        delay = 100,

        -- Animation rule for scope's first drawing. A function which, given
        -- next and total step numbers, returns wait time (in ms). See
        -- |MiniIndentscope.gen_animation| for builtin options. To disable
        -- animation, use `require('mini.indentscope').gen_animation.none()`.
        animation = require('mini.indentscope').gen_animation.none(),

        -- Whether to auto draw scope: return `true` to draw, `false` otherwise.
        -- Default draws only fully computed scope (see `options.n_lines`).
        predicate = function(scope) return not scope.body.is_incomplete end,

        -- Symbol priority. Increase to display on top of more symbols.
        priority = 2,
      },

      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Textobjects
        object_scope = 'ii',
        object_scope_with_border = 'ai',

        -- Motions (jump to respective border line; if not present - body line)
        goto_top = '[i',
        goto_bottom = ']i',
      },

      -- Options which control scope computation
      options = {
        -- Type of scope's border: which line(s) with smaller indent to
        -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
        border = 'both',

        -- Whether to use cursor column when computing reference indent.
        -- Useful to see incremental scopes with horizontal cursor movements.
        indent_at_cursor = true,

        -- Maximum number of lines above or below within which scope is computed
        n_lines = 10000,

        -- Whether to first check input line to be a border of adjacent scope.
        -- Use it if you want to place cursor on function header to get scope of
        -- its body.
        try_as_border = false,
      },

      -- Which character to use for drawing scope indicator
      symbol = '╎',
    })

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
  end,
}
