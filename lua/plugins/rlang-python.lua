return {
	{ "jamespeapen/Nvim-R", branch = "master", ft = { "r", "rmd", "quarto" } },
	{
		"jalvesaq/cmp-nvim-r",
		ft = { "r", "rmd", "quarto" },
		config = function()
			require("cmp_nvim_r").setup({})
		end,
	},
	{ "quarto-dev/quarto-nvim", ft = "quarto", opts = {} },
	{ "jmbuhr/otter.nvim", ft = "quarto", opts = {} },
}
