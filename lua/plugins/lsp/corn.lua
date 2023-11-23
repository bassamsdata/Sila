return {
	"RaafatTurki/corn.nvim",
	event = "LspAttach",
	config = function()
		-- disable virtual text diags
		vim.diagnostic.config({ virtual_text = false })

		require("corn").setup({
			-- auto_cmds = false,
			sort_method = "column",
			-- scope = 'file',
			icons = {
				error = " ",
				warn = " ",
				hint = "󰠠 ",
				info = " ",
			},
			on_toggle = function(is_hidden)
				-- toggle virtual_text diags back on when corn is off and vise versa
				vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
			end,
		})
	end,
}
