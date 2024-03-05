return {
	{
		"2kabhishek/nerdy.nvim",
		dependencies = { "echasnovski/mini.pick" },
		cmd = "Nerdy",
	},
	-- substitute that preserve case (and easier using {}),
	-- making one abbreviations in one command,
	-- making camelCase or snake_case, just use crc to camelCase, [crc] to snake_case, [cr-] for dash-case
	-- and so on, dot.case, uppercase, lowercase, MixedCase
	{ "tpope/vim-abolish", event = "BufReadPost" },

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
