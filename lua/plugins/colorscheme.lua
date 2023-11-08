return {
	{
		"Mofiqul/dracula.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
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
			},
		},
	},
}
