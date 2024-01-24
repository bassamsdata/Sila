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
			border_style = "rounded",
			-- TODO: make pr to enhance it via autocmd Modechanged - then delete my autocmds
			blacklisted_modes = { "i", "v", "V" },
			icons = {
				error = " ",
				warn = " ",
				hint = "󰠠 ",
				info = " ",
			},
			-- on_toggle = function(is_hidden)
			-- toggle virtual_text diags back on when corn is off and vise versa
			-- vim.diagnostic.config({
			-- 	virtual_text = not vim.diagnostic.config().virtual_text,
			-- })
			-- end,
		})
		-- local function augroup(name)
		-- 	return vim.api.nvim_create_augroup("sila_" .. name, { clear = true })
		-- end
		-- -- diagnostic_off when in insert or select mode
		-- vim.api.nvim_create_autocmd("ModeChanged", {
		-- 	group = augroup("diagnostic_off"),
		-- 	pattern = { "n:i", "v:s", "n:V", "n:" },
		-- 	desc = "Disable diagnostics in insert and select mode",
		-- 	callback = function(e)
		-- 		-- vim.diagnostic.disable(e.buf)
		-- 		require("corn").toggle("off")
		-- 	end,
		-- })
		--
		-- -- diagnostic_on when back in normal mode
		-- vim.api.nvim_create_autocmd("ModeChanged", {
		-- 	group = augroup("diagnostic_on"),
		-- 	pattern = { "i:n", "v:n", ":n" },
		-- 	desc = "Enable diagnostics when leaving insert mode",
		-- 	callback = function(e)
		-- 		vim.diagnostic.enable(e.buf)
		-- 		require("corn").toggle("on")
		-- 	end,
		-- })
	end,
}
