if not vim.b.midfile or vim.b.bigfile then
	vim.treesitter.start(0, "markdown")
	vim.bo.syntax = "on"
end
