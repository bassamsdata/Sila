return {
	{
		"marko-cerovac/material.nvim",
		-- lazy = true,
		-- event = "VeryLazy",
		-- priority = 1000,
		init = function()
			-- vim.g.material_style = "deep ocean"
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
				-- CursorLine = { bg = "#101c24" },
				NormalMode = { fg = "#84ffff" },
				VisualMode = { fg = "#226142" },
				InsertMode = { fg = "#cb4251" },
				CommandMode = { fg = "#ffc73d" },
				PmenuThumb = { bg = "#509c9d" },
				Visual = { bg = "#313956", fg = "#cecece" },
				MiniMapSymbolView = { fg = "#323a54" },
				UserStatusMode_NORMAL = { bg = "#509c9d" },
				StatusLine = { guibg = NONE },
				-- NormalFloat = { bg = nil }, --#transparency
				-- conditional = { italic = true },
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
				"neogit",
			},
			disable = {
				-->other settings
				-- background = true,
				colored_cursor = true, -- Disable the colored cursore,
			},
		},
	},
}
