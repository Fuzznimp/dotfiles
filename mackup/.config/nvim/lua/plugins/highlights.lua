return {
	-- https://github.com/xiyaowong/transparent.nvim
	{
		"xiyaowong/transparent.nvim",
		priority = 1000,
		opts = {
			groups = {
				-- table: default groups
				"Normal",
				"NormalNC",
				"Comment",
				"Constant",
				"Special",
				"Identifier",
				"Statement",
				"PreProc",
				"Type",
				"Underlined",
				"Todo",
				"String",
				"Function",
				"Conditional",
				"Repeat",
				"Operator",
				"Structure",
				"LineNr",
				"NonText",
				"SignColumn",
				"CursorLineNr",
				"EndOfBuffer",
			},
			extra_groups = {
				-- Lazy.nvim
				"LazyButton",
				"LazyButtonActive",
				"LazyComment",
				"LazyCommit",
				"LazyCommitIssue",
				"LazyCommitScope",
				"LazyCommitType",
				"LazyDimmed",
				"LazyDir",
				"LazyH1",
				"LazyH2",
				"LazyNoCond",
				"LazyNormal",
				"LazyProgressDone",
				"LazyProgressTodo	",
				"LazyProp",
				"LazyReasonCmd",
				"LazyReasonEvent",
				"LazyReasonFt",
				"LazyReasonImport",
				"LazyReasonKeys",
				"LazyReasonPlugin",
				"LazyReasonRuntime",
				"LazyReasonSource",
				"LazyReasonStart",
				"LazySpecial",
				"LazyTaskError",
				"LazyTaskOutput",
				"LazyUrl",
				"LazyValue",
				-- NeoTree
				"NeoTreeBufferNumber",
				"NeoTreeCursorLine",
				"NeoTreeDimText",
				"NeoTreeDirectoryIcon",
				"NeoTreeDirectoryName",
				"NeoTreeDotfile",
				"NeoTreeFileIcon",
				"NeoTreeFileName",
				"NeoTreeFileNameOpened",
				"NeoTreeFilterTerm",
				"NeoTreeFloatBorder",
				"NeoTreeFloatTitle",
				"NeoTreeTitleBar",
				"NeoTreeGitAdded",
				"NeoTreeGitConflict",
				"NeoTreeGitDeleted",
				"NeoTreeGitIgnored",
				"NeoTreeGitModified",
				"NeoTreeGitUnstaged",
				"NeoTreeGitUntracked",
				"NeoTreeGitStaged",
				"NeoTreeHiddenByName",
				"NeoTreeIndentMarker",
				"NeoTreeExpander",
				"NeoTreeNormal",
				"NeoTreeNormalNC",
				"NeoTreeSignColumn",
				"NeoTreeStatusLine",
				"NeoTreeStatusLineNC",
				"NeoTreeVertSplit",
				"NeoTreeWinSeparator",
				"NeoTreeEndOfBuffer",
				"NeoTreeRootName",
				"NeoTreeSymbolicLinkTarget",
				"NeoTreeTitleBar",
				"NeoTreeWindowsHidden",
			},
			exclude_groups = {}, -- table: groups you don't want to clear
		},
	},
	{
		"Djancyp/custom-theme.nvim",
		config = function()
			require("custom-theme").setup()
		end,
	},
	{
		"nvim-treesitter/playground",
		cmd = "TSCaptureUnderCursor",
		lazy = true,
	},
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
				enable = true,
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
	{
		"nvim-lualine/lualine.nvim",
		opts = function(plugin)
			local icons = require("lazyvim.config").icons

			return {
				options = {
					theme = "auto",
					globalstatus = true,
					disabled_filetypes = { statusline = { "dashboard", "lazy", "alpha" } },
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { { "branch", color = { bg = 236 } } },
					lualine_c = {
						{
							"diagnostics",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
						},
						{
							"filetype",
							icon_only = true,
							padding = {
								left = 1,
								right = 0,
							},
							color = { bg = 236 },
						},
						{
							"filename",
							path = 1,
							symbols = {
								modified = "  ",
								readonly = "",
								unnamed = "",
							},
							color = { bg = 236, fg = "#a9b665" },
						},
						-- stylua: ignore
						{
							function() return require("nvim-navic").get_location() end,
							cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
							highlight = true
						},
					},
					lualine_x = {
						-- stylua: ignore
						{
							function() return require("noice").api.status.command.get() end,
							cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
							color = { fg = "#e78a4e", bg = 236 },
						},
						-- stylua: ignore
						{
							function() return require("noice").api.status.mode.get() end,
							cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
							color = { fg = "#e78a4e", bg = 236 },
						},
						{
							require("lazy.status").updates,
							cond = require("lazy.status").has_updates,
							color = { fg = "#e78a4e", bg = 236 },
						},
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
							},
							color = { bg = 236, fg = "#e78a4e" },
						},
					},
					lualine_y = {
						{
							"progress",
							separator = " ",
							color = { fg = "#e78a4e", bg = 236 },
							padding = {
								left = 1,
								right = 0,
							},
						},
						{ "location", padding = { left = 0, right = 1 }, color = { fg = "#e78a4e", bg = 236 } },
					},
					lualine_z = {
						"hostname",
					},
				},
				extensions = { "neo-tree" },
			}
		end,
	},
}
