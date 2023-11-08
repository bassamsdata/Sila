return {
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		opts = {},
		keys = {
			{
				"<leader>xa",
				function()
					local util = require("core.Util")
					vim.g.minipairs_disable = not vim.g.minipairs_disable
					if vim.g.minipairs_disable then
						util.custom_notify("Disabled auto pairs", "Info")
					else
						util.custom_notify("Enabled auto pairs", "Info")
					end
				end,
				desc = "Toggle auto pairs",
			},
		},
	},
	{
		"echasnovski/mini.surround",
		keys = { "gs" },
		opts = {
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
			},
		},
	},
}
