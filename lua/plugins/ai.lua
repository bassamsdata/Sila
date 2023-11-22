return {
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		cmd = "Codeium",
		build = ":Codeium Auth",
		opts = {},
	},
}
