require("notify").setup({
	background_colour = "#000000",
})

local M = {}

M.colors = {
	dark0_hard = "#1d2021",
	dark0 = "#282828",
	dark0_soft = "#32302f",
	dark1 = "#3c3836",
	dark2 = "#504945",
	dark3 = "#665c54",
	dark4 = "#7c6f64",
	light0_hard = "#f9f5d7",
	light0 = "#fbf1c7",
	light0_soft = "#f2e5bc",
	light1 = "#ebdbb2",
	light2 = "#d5c4a1",
	light3 = "#bdae93",
	light4 = "#a89984",
	bright_red = "#ea6962",
	bright_green = "#a9b665",
	bright_yellow = "#d8a657",
	bright_blue = "#458588",
	bright_purple = "#d3869b",
	bright_aqua = "#8ec07c",
	bright_orange = "#e78a4e",
	neutral_red = "#ea6962",
	neutral_green = "#a9b665",
	neutral_yellow = "#d8a657",
	neutral_blue = "#83a598",
	neutral_purple = "#b16286",
	neutral_aqua = "#689d6a",
	neutral_orange = "#e78a4e",
	faded_red = "#ea6962",
	faded_green = "#a9b665",
	faded_yellow = "#d8a657",
	faded_blue = "#076678",
	faded_purple = "#8f3f71",
	faded_aqua = "#89b482",
	faded_orange = "#e78a4e",
	gray = "#928374",
}

return {
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			undercurl = true,
			underline = true,
			bold = false,
			italic = false,
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "soft", -- can be "hard", "soft" or empty string
			palette_overrides = M.colors,
			overrides = {
				-- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md#highlights
				-- https://github.com/ellisonleao/gruvbox.nvim/blob/main/lua/gruvbox/groups.lua
				String = { fg = M.colors.neutral_yellow, italic = false },
				Constant = { fg = M.colors.neutral_orange },
				htmlArg = { fg = M.colors.neutral_green },
				Comment = { italic = true },
				["@type"] = { fg = M.colors.neutral_blue },
				["@type.builtin"] = { fg = M.colors.neutral_blue },
				["@variable"] = { fg = M.colors.light2 },
				["@keyword"] = { fg = M.colors.neutral_orange },
				["@keyword.function"] = { fg = M.colors.neutral_red },
				["@tag.attribute"] = { fg = M.colors.neutral_green },
				["@include"] = { fg = M.colors.bright_purple },
				["@property"] = { fg = M.colors.light2 },
				["@constant"] = { fg = M.colors.light2 },
				["@parameter"] = { fg = M.colors.light2 },
				["@punctuation.delimiter"] = { fg = M.colors.light2 },
			},
			dim_inactive = false,
			transparent_mode = true,
		},
	},

	-- Configure LazyVim to load gruvbox
	-- {
	-- 	"LazyVim/LazyVim",
	-- 	opts = {
	-- 		colorscheme = "gruvbox",
	-- 	},
	-- },
}
