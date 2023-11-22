return {
	{
		"bassamsdata/material.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			styles = { -- Give comments style such as bold, italic, underline etc.
				comments = { italic = true },
				-- strings = { bold = true },
				keywords = { italic = true },
				functions = { bold = true },
				variables = {},
				operators = {},
				types = {},
			},
			custom_highlights = {
				CursorLine = { bg = "#101c24" },
				-- NormalFloat = { bg = nil }, --#transparency
				-- conditional = { italic = true },
				MiniMapSymbolView = { fg = "#323a54" },
				UserStatusMode_NORMAL = { bg = "#509c9d" },
				StatusLine = { guibg = NONE },
				-- Statement = { fg = "#84ffff", italic = true },
				-- TreesitterContextBottom = { underline = true, sp = colors.lilac },
			},
			contrast = {
				cursor_line = false,
			},
			plugins = {
				"gitsigns",
				"nvim-cmp",
				"mini",
				"nvim-web-devicons",
				"indent-blankline",
			},
			disable = {
				-->other settings
				background = true,
			},
		},
	},
	{
		"Mofiqul/dracula.nvim",
		lazy = true,
		-- priority = 1000, -- make sure to load this before all the other start plugins
		opts = {
			colors = {
				bg = "#07080f",
				fg = "#C0B9DD",
			},
			transparent_bg = true,
			italic_comment = true,
			overrides = {
				CursorLine = { bg = "#101c24" },
				NormalFloat = { bg = nil }, --#transparency
				["@conditional"] = { italic = true },
				MiniMapSymbolView = { fg = "#323a54" },
				UserStatusMode_NORMAL = { bg = "#6272a4" },
				StatusLine = { guibg = NONE },
			},
		},
	},
}
