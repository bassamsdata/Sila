return {
	{
		"bassamsdata/obsidian.nvim",
		-- dev = true,
		cmd = "ObsidianSearch",
		config = function()
			local obsidian = require("obsidian")
			obsidian.setup({
				dir = "~/Sync/MarkdownSync",
				notes_subdir = "Notes",
				daily_notes = {
					folder = "Notes/dailies",
				},
				use_advanced_uri = true,
				mappings = {},
				completion = {
					nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
					cmp_nvim_lsp = true,
				},
			})
		end,
	},
}
