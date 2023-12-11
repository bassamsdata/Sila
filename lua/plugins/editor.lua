return {
	{
		"mg979/vim-visual-multi",
		branch = "master",
		-- TODO: change the default keys and description for clues
		keys = {
			{ "<C-Down>" },
			{ "<C-n>" },
			{ "<C-Up>" },
		},
		opts = {},
		config = function()
			if pcall(require, "vim-visual-multi") then
				require("mini.clue").set_mapping_desc("VMmaps", "\\\\A", "Select All")
				-- require("mini.clue").set_mapping_desc("V-M", "\\\\A", "Select All")
				require("mini.clue").set_mapping_desc("VM_maps", "\\\\", "Add Cursor At Pos")
			end
		end,
	},
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},
}
