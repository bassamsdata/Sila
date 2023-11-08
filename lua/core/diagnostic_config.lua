-- Define diagnostic signs
-- local signs = { Error = "❌", Warning = "⚠️", Hint = "💡", Information = "ℹ️" }
-- for type, icon in pairs(signs) do
-- 	local hl = "DiagnosticSign" .. type
-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end

-- Configure diagnostic display
vim.diagnostic.config({
	virtual_text = {
		prefix = "■", -- Prefix for virtual text
		source = "always", -- Show source of diagnostic in virtual text
		spacing = 2, -- Spacing between virtual text lines
		severity_limit = "Warning", -- Don't show virtual text for hints
	},
	signs = true, -- Show signs in the sign column
	underline = true, -- Underline diagnostic text
	update_in_insert = false, -- Don't update diagnostics in insert mode
	severity_sort = true, -- Sort diagnostics by severity
	float = {
		border = "rounded", -- Rounded border for floating window
		source = "always", -- Show source of diagnostic in floating window
	},
})
