-- install lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- use a protected call so we don't error out on first use
local lazy = require("lazy")
if not lazy then
	return
end

local plugins = "plugins"
local lsp = "plugins.lsp"

-- load plugins from specifications (The leader key must be set before this)
lazy.setup({ { import = plugins }, { import = lsp } }, {
	ui = { border = "rounded" },
	install = {
		-- Do not automatically install on startup.
		missing = false,
	},
	-- I like to play with my configs alot so less clutter please.
	change_detection = { notify = false },
	performance = {
		rtp = {
			-- Stuff I don't use.
			disabled_plugins = {
				"gzip",
				"netrwPlugin",
				"rplugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
