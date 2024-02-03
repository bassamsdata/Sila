-- Modifeied verstion using lua instead of json. credit to macro-nvim, https://github.com/Bekaboo/nvim/blob/master/plugin/colorswitch.lua
-- TODO: why not trying to use a table inside this instead of a separate file

-- stylua: ignore start
local colors_file =
vim.fs.joinpath( vim.fn.stdpath("config") --[[@as string]], "lua/color_scheme.lua")
-- stylua: ignore end

local M = {}

function M.handle_file(action, path, str)
	local file = io.open(path, action == "read" and "r" or "w")
	if not file then
		return action == "read" and nil or false
	end
	if action == "read" then
		local content = file:read("*a")
		file:close()
		return content or ""
	else
		file:write("return {\n")
		for key, value in pairs(str) do
			file:write(key .. ' = "' .. value .. '",\n')
		end
		file:write("}\n")
		file:close()
		return true
	end
end

-- FIX: enhance this process since we are requiring the file twice - maybe pcall would help
-- local file = io.open("color_scheme.lua", "r")
-- if file == nil then
-- 	file = io.open("color_scheme.lua", "w")
-- 	file:write('return {colors_name = "nano", bg = vim.go.bg}\n')
-- 	file:close()
-- else
-- 	file:close()
-- end

local saved = require("color_scheme")
-- if not ok then
-- 	local file = io.open("color_scheme.lua", "w")
-- 	file:write('return {"colors_name = "nano", bg = vim.go.bg"}\n')
-- 	file:close()
-- end
saved.colors_name = saved.colors_name or "nano"

if saved.bg and saved.bg ~= vim.go.bg then
	vim.go.bg = saved.bg
end

if saved.colors_name and saved.colors_name ~= vim.g.colors_name then
	vim.cmd.colorscheme({
		args = { saved.colors_name },
		mods = { emsg_silent = true },
	})
end

vim.api.nvim_create_autocmd("Colorscheme", {
	group = vim.api.nvim_create_augroup("ColorSwitch", {}),
	desc = "Spawn setbg/setcolors on colorscheme change.",
	callback = function()
		local data = require("color_scheme")
		if data.colors_name ~= vim.g.colors_name or data.bg ~= vim.go.bg then
			data.colors_name = vim.g.colors_name
			data.bg = vim.go.bg
			if not M.handle_file("write", colors_file, data) then
				return
			end
		end
	end,
})

return M
