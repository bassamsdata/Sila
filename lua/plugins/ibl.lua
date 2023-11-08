-- whitespace and indentation guides.
return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		-- for setting shiftwidth and tabstop automatically.
		-- dependencies = "tpope/vim-sleuth",
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = {
				show_start = false,
				show_end = true,
				-- enabled = true,
			},
			exclude = {
				filetypes = {
					"help",
					"starter",
					"lazy",
					"mason",
					"notify",
				},
			},
		},
	},
}
