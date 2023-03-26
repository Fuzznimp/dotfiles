-- Initial colors: https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_moon.lua

-- do return {} end

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

local colors_override = {
	bg = "#222436",
	bg_dark = "#1e2030",
	bg_float = "#1e2030",
	bg_highlight = chart.bg1,
	bg_popup = chart.bg,
	bg_search = chart.bg,
	bg_sidebar = chart.bg,
	bg_statusline = chart.bg1,
	bg_visual = chart.bg,
	black = "#1b1d2b",
	blue = chart.orange,
	blue0 = chart.orange,
	blue1 = chart.orange,
	blue2 = chart.orange,
	blue5 = chart.orange,
	blue6 = chart.orange,
	blue7 = chart.orange,
	border = "#1b1d2b",
	border_highlight = chart.orange,
	comment = chart.bg3,
	cyan = chart.orange,
	dark3 = "#545c7e",
	dark5 = "#737aa2",
	diff = {
		add = "#273849",
		change = "#252a3f",
		delete = "#3a273a",
		text = "#394b70"
	},
	error = chart.red,
	fg = "#c8d3f5",
	fg_dark = "#828bb8",
	fg_float = "#c8d3f5",
	fg_gutter = "#3b4261",
	fg_sidebar = "#828bb8",
	git = {
		add = "#b8db87",
		change = "#7ca1f2",
		delete = chart.red,
		ignore = "#545c7e"
	},
	gitSigns = {
		add = "#627259",
		change = "#485a86",
		delete = chart.red
	},
	green = chart.green,
	green1 = chart.green,
	green2 = chart.green,
	hint = chart.green,
	info = chart.blue,
	magenta = chart.purple,
	magenta2 = chart.red,
	none = "NONE",
	orange = chart.orange,
	purple = chart.purple,
	red = chart.red,
	red1 = chart.red,
	teal = chart.blue,
	terminal_black = "#444a73",
	warning = chart.yellow,
	yellow = chart.yellow
}

local rainbow = {
	first = "#8b4513",
	second = "#228b22",
	third = "#cc7722",
}

return {
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		opts = {
			transparent = true,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
			on_colors = function(colors)
				for k, v in pairs(colors_override) do
					colors[k] = v
				end
			end,
			on_highlights = function(highlights, colors)
				local c = chart
				local h = highlights

				h["@boolean"] = { fg = c.purple }
				h["@conditional.ternary.tsx"] = { fg = c.orange }
				h["@conditional.tsx"] = { fg = c.red }
				h["@constant"] = { fg = chart.fg }
				h["@constant.builtin.tsx"] = { fg = c.purple }
				h["@constant.tsx"] = { fg = chart.fg }
				h["@constructor.tsx"] = { fg = c.orange }
				h["@exception.tsx"] = { fg = c.red }
				h["@function"] = { fg = c.green }
				h["@include"] = { fg = c.fg }
				h["@keyword.operator.tsx"] = { fg = c.red }
				h["@keyword.return.tsx"] = { fg = c.red }
				h["@keyword"] = { fg = c.orange }
				h["@method.call.tsx"] = { fg = c.green }
				h["@number.tsx"] = { fg = c.purple }
				h["@operator"] = { fg = c.orange }
				h["@property"] = { fg = chart.fg }
				h["@punctuation.bracket"] = { fg = c.fg }
				h["@punctuation.delimiter.tsx"] = { fg = c.fg }
				h["@punctuation.special.tsx"] = { fg = c.orange }
				h["@string"] = { fg = c.yellow }
				h["@tag.attribute.tsx"] = { fg = c.green }
				h["@tag.delimiter.tsx"] = { fg = c.green }
				h["@type.builtin.tsx"] = { fg = c.blue }
				h["@type.builtin.tsx"] = { fg = c.blue }
				h["@type.tsx"] = { fg = c.blue }
				h["@variable"] = { fg = c.fg }
				-- Gutter Lines.
				h["LineNr"] = { fg = c.bg2 }
				h["CursorLineNr"] = { fg = c.fg }
				-- lsp
				h["@lsp.type.class.typescriptreact"] = { fg = c.blue }
				h["@lsp.type.enum.typescriptreact"] = { fg = c.purple }
				h["@lsp.type.enumMember.typescriptreact"] = { fg = c.blue }
				h["@lsp.type.function.typescriptreact"] = { fg = c.green }
				h["@lsp.type.parameter.typescriptreact"] = { fg = chart.fg }
				h["@lsp.type.type.typescriptreact"] = { fg = c.blue }
				h["@lsp.typemod.function.defaultLibrary.typescriptreact"] = { fg = c.green }
				h["@lsp.typemod.member.declaration.typescriptreact"] = { fg = c.green }
				-- nvim-ts-rainbow2 (maintained fork).
				h["TSRainbowRed"] = { fg = rainbow.first }
				h["TSRainbowOrange"] = { fg = rainbow.second }
				h["TSRainbowYellow"] = { fg = rainbow.third }
				h["TSRainbowGreen"] = { fg = rainbow.first }
				h["TSRainbowBlue"] = { fg = rainbow.second }
				h["TSRainbowViolet"] = { fg = rainbow.third }
				h["TSRainbowCyan"] = { fg = rainbow.first }
				-- NeoTree
				h["NeoTreeDirectoryName"] = { fg = c.bg4 }
				h["NeoTreeFileName"] = { fg = c.fg }
				h["NeoTreeRootName"] = { fg = c.green }
				-- h["NeoTreeGitModified"] = { fg = c.blue }
				h["NeoTreeGitAdded"] = { fg = c.green }
				h["NeoTreeIndentMarker"] = { fg = c.bg2 }
				h["NeoTreeExpander"] = { fg = c.bg2 }
				h["NeoTreeGitIgnored"] = { fg = c.bg2 }
				-- Telescope
				h["TelescopeBorder"] = { fg = c.border_highlight, bg = c.none }
				h["TelescopeNormal"] = { fg = c.fg, bg = c.none }
				-- Alpha
				h["AlphaHeader"] = { fg = c.green }
				h["AlphaHeaderLabel"] = { fg = c.bg3 }
				h["AlphaButtons"] = { fg = c.bg3 }
				h["AlphaShortcut"] = { fg = c.bg3 }
				h["AlphaFooter"] = { fg = c.green, italic = true }
				-- Lualine
				h["lualine_a_insert"] = { fg = chart.purple, bg = chart.purple }
				-- navic
				h["NavicText"] = { fg = c.fg, bg = c.bg1 }
				h["NavicSeparator"] = { fg = c.bg2, bg = c.bg1 }
				h["NavicIconsFile"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsModule"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsNamespace"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsPackage"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsClass"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsMethod"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsProperty"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsField"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsConstructor"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsEnum"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsInterface"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsFunction"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsVariable"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsConstant"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsString"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsNumber"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsBoolean"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsArray"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsObject"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsKey"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsNull"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsEnumMember"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsStruct"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsEvent"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsOperator"] = { fg = c.orange, bg = c.bg1 }
				h["NavicIconsTypeParameter"] = { fg = c.orange, bg = c.bg1 }
				-- Noice - https://github.com/folke/noice.nvim#-highlight-groups
				h["NoiceCmdlinePopupBorder"] = { fg = c.bg2, bg = c.none }
				h["NoiceCmdlineIcon"] = { fg = c.green, bg = c.none }
				h["NoiceCmdlinePrompt"] = { fg = c.green, bg = c.none }
				-- which-key
				h["WhichKeyFloat"] = { fg = c.fg, bg = c.none }
				h["WhichKeyGroup"] = { fg = c.blue }
				h["WhichKeyDesc"] = { fg = c.fg }
				-- Remove bg
				-- h["Normal"] = { ctermbg = c.none, guibg = c.none }
				-- h["NormalNC"] = { bg = c.none }
				-- h["Comment"] = { bg = c.none }
				-- h["Constant"] = { bg = c.none }
				-- h["Special"] = { bg = c.none }
				-- h["Identifier"] = { bg = c.none }
				-- h["Statement"] = { bg = c.none }
				-- h["PreProc"] = { bg = c.none }
				-- h["Type"] = { bg = c.none }
				-- h["Underlined"] = { bg = c.none }
				-- h["Todo"] = { bg = c.none }
				-- h["String"] = { bg = c.none }
				-- h["Function"] = { bg = c.none }
				-- h["Conditional"] = { bg = c.none }
				-- h["Repeat"] = { bg = c.none }
				-- h["Operator"] = { bg = c.none }
				-- h["Structure"] = { bg = c.none }
				-- h["LineNr"] = { bg = c.none }
				-- h["NonText"] = { bg = c.none }
				-- h["SignColumn"] = { bg = c.none }
				-- h["CursorLineNr"] = { bg = c.none }
				-- h["EndOfBuffer"] = { bg = c.none }
				-- h["LazyButton"] = { bg = c.none }
				-- h["LazyButtonActive"] = { bg = c.none }
				-- h["LazyComment"] = { bg = c.none }
				-- -- Lazy.nvim
				-- h["LazyCommit"] = { bg = c.none }
				-- h["LazyCommitIssue"] = { bg = c.none }
				-- h["LazyCommitScope"] = { bg = c.none }
				-- h["LazyCommitType"] = { bg = c.none }
				-- h["LazyDimmed"] = { bg = c.none }
				-- h["LazyDir"] = { bg = c.none }
				-- h["LazyH1"] = { bg = c.none }
				-- h["LazyH2"] = { bg = c.none }
				-- h["LazyNoCond"] = { bg = c.none }
				-- h["LazyNormal"] = { bg = c.none }
				-- h["LazyProgressDone"] = { bg = c.none }
				-- h["LazyProgressTodo"] = { bg = c.none }
				-- h["LazyProp"] = { bg = c.none }
				-- h["LazyReasonCmd"] = { bg = c.none }
				-- h["LazyReasonEvent"] = { bg = c.none }
				-- h["LazyReasonFt"] = { bg = c.none }
				-- h["LazyReasonImport"] = { bg = c.none }
				-- h["LazyReasonKeys"] = { bg = c.none }
				-- h["LazyReasonPlugin"] = { bg = c.none }
				-- h["LazyReasonRuntime"] = { bg = c.none }
				-- h["LazyReasonSource"] = { bg = c.none }
				-- h["LazyReasonStart"] = { bg = c.none }
				-- h["LazySpecial"] = { bg = c.none }
				-- h["LazyTaskError"] = { bg = c.none }
				-- h["LazyTaskOutput"] = { bg = c.none }
				-- h["LazyUrl"] = { bg = c.none }
				-- h["LazyValue"] = { bg = c.none }
				-- -- NeoTree
				-- h["NeoTreeBufferNumber"] = { bg = c.none }
				-- h["NeoTreeCursorLine"] = { bg = c.none }
				-- h["NeoTreeDimText"] = { bg = c.none }
				-- h["NeoTreeDirectoryIcon"] = { bg = c.none }
				-- h["NeoTreeDirectoryName"] = { bg = c.none }
				-- h["NeoTreeDotfile"] = { bg = c.none }
				-- h["NeoTreeFileIcon"] = { bg = c.none }
				-- h["NeoTreeFileName"] = { bg = c.none }
				-- h["NeoTreeFileNameOpened"] = { bg = c.none }
				-- h["NeoTreeFilterTerm"] = { bg = c.none }
				-- h["NeoTreeFloatBorder"] = { bg = c.none }
				-- h["NeoTreeFloatTitle"] = { bg = c.none }
				-- h["NeoTreeTitleBar"] = { bg = c.none }
				-- h["NeoTreeGitAdded"] = { bg = c.none }
				-- h["NeoTreeGitConflict"] = { bg = c.none }
				-- h["NeoTreeGitDeleted"] = { bg = c.none }
				-- h["NeoTreeGitIgnored"] = { bg = c.none }
				-- h["NeoTreeGitModified"] = { bg = c.none }
				-- h["NeoTreeGitUnstaged"] = { bg = c.none }
				-- h["NeoTreeGitUntracked"] = { bg = c.none }
				-- h["NeoTreeGitStaged"] = { bg = c.none }
				-- h["NeoTreeHiddenByName"] = { bg = c.none }
				-- h["NeoTreeIndentMarker"] = { bg = c.none }
				-- h["NeoTreeExpander"] = { bg = c.none }
				-- h["NeoTreeNormal"] = { bg = c.none }
				-- h["NeoTreeNormalNC"] = { bg = c.none }
				-- h["NeoTreeSignColumn"] = { bg = c.none }
				-- h["NeoTreeStatusLine"] = { bg = c.none }
				-- h["NeoTreeStatusLineNC"] = { bg = c.none }
				-- h["NeoTreeVertSplit"] = { bg = c.none }
				-- h["NeoTreeWinSeparator"] = { bg = c.none }
				-- h["NeoTreeEndOfBuffer"] = { bg = c.none }
				-- h["NeoTreeRootName"] = { bg = c.none }
				-- h["NeoTreeSymbolicLinkTarget"] = { bg = c.none }
				-- h["NeoTreeTitleBar"] = { bg = c.none }
				-- h["NeoTreeWindowsHidden"] = { bg = c.none }
				-- h["LualineMode"] = { bg = c.none }
				-- h["LualineBranch"] = { bg = c.none }
				-- h["LualineFiletype"] = { bg = c.none }
				-- h["LualineFilename"] = { bg = c.none }
				-- h["LualinePath"] = { bg = c.none }
				-- h["LualineGit"] = { bg = c.none }
				-- h["LualineLineInfo"] = { bg = c.none }
				-- h["LualinePercent"] = { bg = c.none }
			end,
		},
	},
}
