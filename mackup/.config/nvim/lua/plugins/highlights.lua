return {
	{
		"nvim-treesitter/playground",
		cmd = "TSCaptureUnderCursor",
		lazy = true,
	},
	{ "p00f/nvim-ts-rainbow", lazy = false, },
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		opts = {
			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"yaml",
				"html",
				"css",
				"markdown",
				"graphql",
				"bash",
				"lua",
				"vim",
				"dockerfile",
			},
			rainbow = {
				enable = false,
				-- FIXME: Colors are not the one chosen
				colors = {
					"#8b4513",
					"#228b22",
					"#cc7722",
				},
				extended_mode = false,
			},
			playground = {
				enable = true,
				disable = {},
				updatetime = 25,     -- Debounced time for highlighting nodes in the playground from source code
				persist_queries = false, -- Whether the query persists across vim sessions
				keybindings = {
					toggle_query_editor = "o",
					toggle_hl_groups = "i",
					toggle_injected_languages = "t",
					toggle_anonymous_nodes = "a",
					toggle_language_display = "I",
					focus_language = "f",
					unfocus_language = "F",
					update = "R",
					goto_node = "<cr>",
					show_help = "?",
				},
			},
		},
	},
	{
		"NvChad/nvim-colorizer.lua",
		lazy = false,
		opts = {
			user_default_options = {
				RGB = true,      -- #RGB hex codes
				RRGGBB = true,   -- #RRGGBB hex codes
				names = false,   -- "Name" codes like Blue or blue
				RRGGBBAA = false, -- #RRGGBBAA hex codes
				AARRGGBB = false, -- 0xAARRGGBB hex codes
				rgb_fn = true,   -- CSS rgb() and rgba() functions
				hsl_fn = true,   -- CSS hsl() and hsla() functions
				css = true,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				-- Available modes for `mode`: foreground, background,  virtualtext
				mode = "background", -- Set the display mode.
				-- Available methods are false / true / "normal" / "lsp" / "both"
				-- True is same as normal
				tailwind = true,
			},
		},
	},
}

-- {
-- 	"nvim-lualine/lualine.nvim",
-- 	opts = {
-- 		theme = require("colorscheme-lualine").theme(),
-- 	}
-- },
