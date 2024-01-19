local hl = require("utils.hi")
local hl_set = hl.apply_highlight
-- Apply the background color from 'StatusLine' to 'StatusLineGitAdd', 'StatusLineGitChange', and 'StatusLineGitDelete'
hl_set("StatusLineGitAdd", {bg = "StatusLine"})
hl_set("StatusLineGitChange", {bg = "StatusLine"})
hl_set("StatusLineGitDelete", {bg = "StatusLine"})

-- Define a table for the 'StatusLineNormal' highlight group
local statusline_mode_color = {
	["bg"] = "white",
	["fg"] = "black",
	["bold"] = true,
}
-- Apply the 'StatusLineNormal' color to 'StatusLineNormal'
hl_set("StatusLineNormal", statusline_mode_color)
-- Change the background color for 'StatusLineInsert' and 'StatusLineVisual'
statusline_mode_color.bg = "LightGreen"
hl_set("StatusLineInsert", statusline_mode_color)
statusline_mode_color.bg = "LightMagenta"
hl_set("StatusLineVisual", statusline_mode_color)
-- Apply the foreground color from 'StatusLine' to the background color of 'StatusLineLsp'
hl_set("StatusLineLsp", {fg = "StatusLine"})

local modes_map = {
	["n"] = "NORMAL",
	["no"] = "OP-PENDING",
	["nov"] = "OP-PENDING",
	["noV"] = "OP-PENDING",
	["no\22"] = "OP-PENDING",
	["i"] = "INSERT",
	["V"] = "V-LINE",
	[""] = "V-BLOCK",
	["R"] = "REPLACE",
	["c"] = "COMMAND",
	["t"] = "TERMINAL",
	["ntT"] = "TERMINAL",
}

local function get_mode_color()
	local current_mode = vim.api.nvim_get_mode().mode
	local mode_color = "%#StatusLineNormal#"
	if current_mode == "i" then
		mode_color = "%#StatusLineInsert#"
	elseif current_mode == "V" or current_mode == "" then
		mode_color = "%#StatusLineVisual#"
	end
	return mode_color
end

local function get_mode()
	local current_mode = vim.api.nvim_get_mode().mode
	return table.concat({
		get_mode_color(),
		" ",
		modes_map[current_mode] or "",
		" ",
		"%#StatusLine#",
	})
end

local function git_signs()
	local git_info = vim.b.gitsigns_status_dict
	if not git_info or git_info.head == "" then
		return ""
	end
	local added = git_info.added
			and ("%#StatusLineGitAdd#+" .. git_info.added .. " ")
		or ""
	local changed = git_info.changed
			and ("%#StatusLineGitChange#~" .. git_info.changed .. " ")
		or ""
	local removed = git_info.removed
			and ("%#StatusLineGitDelete#-" .. git_info.removed .. " ")
		or ""
	if git_info.added == 0 then
		added = ""
	end
	if git_info.changed == 0 then
		changed = ""
	end
	if git_info.removed == 0 then
		removed = ""
	end
	return table.concat({
		"[",
		" " .. git_info.head,
		"] ",
		added,
		changed,
		removed,
	})
end

local function get_lsp_clients()
	local clients = vim.lsp.get_clients()
	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, vim.bo.filetype) ~= -1 then
			return "[" .. client.name .. "]"
		end
	end
	return ""
end

local M = {}

M.global = function()
	local has_lsp_status, lsp_status = pcall(require, "lsp-status")
	return table.concat({
		get_mode(),
		" ",
		vim.fn.fnamemodify(vim.api.nvim_eval("getcwd()"), ":~"),
		" ",
		git_signs(),
		"%#StatusLine#%{'Line: '}%l/%L, %{'Col: '}%c",
		"%=",
		has_lsp_status and lsp_status.status() or "",
		" ",
		"%#StatusLineLsp#",
		get_lsp_clients(),
		" ",
	})
end

vim.o.statusline = "%!v:lua.require'core.mystatusline'.global()"

return M
