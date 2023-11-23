local virtual_corn = nil

return {
	"RaafatTurki/corn.nvim",
	-- lazy = true,
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
				if virtual_corn == nil then
					virtual_corn = vim.diagnostic.config().virtual_text
				else
					vim.diagnostic.config({ virtual_text = virtual_corn })
					virtual_corn = not virtual_corn
				end
			end,
		})
	end,
}
