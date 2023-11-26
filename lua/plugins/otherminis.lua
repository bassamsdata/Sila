return {
	-- TODO: change the highlight color of the view map 'MiniMapSymbolView'
	-- and add mini map to the help pages as well :)
	{
		"echasnovski/mini.map",
		event = "VeryLazy",
		config = function()
			local map = require("mini.map")
			local gen_integr = map.gen_integration
			if map then
				map.setup({
					-- it's gonna show them only if widht > 1
					integrations = { gen_integr.builtin_search(), gen_integr.diagnostic(), gen_integr.gitsigns() },
					-- Window options
					window = {
						-- Whether to show count of multiple integration highlights
						show_integration_count = false,
						-- Total width
						width = 2,
						-- Value of 'winblend' option
						winblend = 0,
						-- Z-index
						zindex = 100,
					},
				})
				-- for _, key in ipairs({ "n", "N", "*" }) do
				-- 	vim.keymap.set(
				-- 		"n",
				-- 		key,
				-- 		key .. "zv<Cmd>lua MiniMap.refresh({}, { lines = false, scrollbar = false })<CR>"
				-- 	)
				-- end

				vim.api.nvim_set_hl(0, "MiniMapSymbolCount", { fg = "#f38ba9" })
			end
		end,
	},
	{
		"echasnovski/mini.hipatterns",
		event = "BufReadPre",
		opts = {
			highlighters = {
				todo = {
					-- TODO: hello
					pattern = "TODO",
					group = "MiniHipatternsTodo",
					extmark_opts = { sign_text = "" },
				},
				-- LOVE: make many mor󰐑
				love = {
					pattern = "LOVE",
					group = "gitSignsDeletePreview",
					extmark_opts = { sign_text = "!!", sign_hl_group = "DevIconGraphQL" },
				},
				-- highlight the text after LOVE with different highlightv
				love_love = {
					pattern = "LOVE: ()%S+.*()",
					group = "@text.todo.checked",
				},
			},
		},
	},
}
