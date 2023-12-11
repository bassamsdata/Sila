return {
	{
		"marko-cerovac/material.nvim",
		lazy = true,
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("Material-deep-ocean")
		end,
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
				TreesitterContext = { bg = nil },
				TreesitterContextLineNumber = { bg = nil },
				TreesitterContextBottom = { underline = true, sp = "#343434" },
			},
			contrast = {
				cursor_line = true,
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
				colored_cursor = true, -- Disable the colored cursore,
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
