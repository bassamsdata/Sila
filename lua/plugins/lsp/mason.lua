return {
	"williamboman/mason.nvim",
	cmd = "Mason",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		-- TODO: Check this plugin
		-- "WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		-- local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				border = "rounded",
				width = 0.7,
				height = 0.8,
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})
		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"pyright",
				"r_language_server",
				"lua_ls",
				"html",
				"cssls",
				"marksman",
				"taplo",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})
	end,
}
