return {
	{
		"2kabhishek/nerdy.nvim",
		dependencies = { "echasnovski/mini.pick" },
		cmd = "Nerdy",
	},

	{
		"chrisgrieser/nvim-origami",
		event = "BufReadPost", -- later or on keypress would prevent saving folds
		opts = true, -- needed even when using default config
	},

	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},

	{ "LudoPinelli/comment-box.nvim", cmd = "CBllline", opts = {} },
}
