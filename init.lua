-- this protected require function borrowed from venom https://github.com/RaafatTurki/venom/
-- local util = require("utils")
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

-- if vim.loader then
vim.loader.enable()
-- end
require("core.options").initial()
require("core.autcommands")
require("core.lazy")
require("core.keymaps")
pcall(require, "core.statusline")
-- require("plugin.intro").setup()
if vim.g.vscode ~= nil then
	require("core.vscode")
end
