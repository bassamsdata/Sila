-- this protected require function borrowed from venom https://github.com/RaafatTurki/venom/
-- local util = require("core.Util")
--
-- function Prequire(name)
-- 	local ok, var = pcall(require, name)
-- 	if ok then
-- 		return var
-- 	else
-- 		util.custom_notify(name .. " has an issue, please check :)", "Warn")
-- 		return nil
-- 	end
-- end
-- Initialize global object to store custom objects
_G.BS = {}

require("core.options") -- it's important so I want neovim to tell me if its broken
require("core.Util")
require("core.lazy") -- same as option.lua
-- TODO: check why this core.colorscheme takes a lot of time
-- require("core.colorscheme") -- important to require this after lazy
require("core.keymaps")
require("core.autcommands")
require("core.diagnostic_config")
require("core.mystatusline").setup()
if vim.g.vscode ~= nil then
	require("core.vscode")
end
