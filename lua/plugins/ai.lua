return {
	{
		"Exafunction/codeium.nvim",
		cond = not vim.g.vscode or not vim.b.bigfile,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		cmd = "Codeium",
		build = ":Codeium Auth",
		opts = {},
	},

	{
		"sourcegraph/sg.nvim",
		cond = not vim.g.vscode or not vim.b.bigfile,
		event = "LspAttach",
		cmd = "CodyToggle",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = { enable_cody = true },
	},

	-- {
	-- 	"codota/tabnine-nvim",
	-- 	cmd = "TabnineEnable",
	-- 	-- event = "InsertEnter",
	-- 	build = "./dl_binaries.sh",
	-- 	config = function()
	-- 		require("tabnine").setup({
	-- 			disable_auto_comment = true,
	-- 			accept_keymap = "<Tab>",
	-- 			dismiss_keymap = "<C-]>",
	-- 			debounce_ms = 800,
	-- 			suggestion_color = { gui = "#808080", cterm = 244 },
	-- 			exclude_filetypes = { "TelescopePrompt", "NvimTree" },
	-- 			log_file_path = nil, -- absolute path to Tabnine log file
	-- 		})
	-- 	end,
	-- },
}
