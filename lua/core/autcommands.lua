-- Create automatic naming for groups
local function augroup(name)
	return vim.api.nvim_create_augroup("sila_" .. name, { clear = true })
end

local U = require("core.Util")

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})
local function save_cursorline_colors()
	_G.cursorline_bg_orig_gui = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("CursorLine")), "bg", "gui")
	_G.cursorline_bg_orig_cterm = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("CursorLine")), "bg", "cterm")
	if _G.cursorline_bg_orig_cterm == "" then
		_G.cursorline_bg_orig_cterm = "NONE"
	end
	if _G.cursorline_bg_orig_gui == "" then
		_G.cursorline_bg_orig_gui = "NONE"
	end
end

local function update_cursorline_colors(is_recording)
	local gui = vim.o.background == "dark" and "#223322" or "#aaffaa"
	local cterm = vim.o.background == "dark" and "2" or "10"
	if not is_recording then
		gui = _G.cursorline_bg_orig_gui
		cterm = _G.cursorline_bg_orig_cterm
	end
	vim.cmd(string.format("hi CursorLine guibg=%s ctermbg=%s", gui, cterm))
end

vim.api.nvim_create_augroup("macro_visual_indication", {})
vim.api.nvim_create_autocmd({ "RecordingEnter", "ColorScheme" }, {
	group = "macro_visual_indication",
	callback = function()
		save_cursorline_colors()
		update_cursorline_colors(vim.fn.reg_recording() ~= "")
	end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
	group = "macro_visual_indication",
	callback = function()
		update_cursorline_colors(false)
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
			vim.api.nvim_command("normal! zz")
		end
	end,
})

-- Change the current line number depend on neovim mode
-- similar to modicator.nvim plugin
-- vim.api.nvim_create_autocmd({ "ModeChanged" }, {
--   group = augroup("modechange"),
-- 	callback = function()
-- 		-- make it work on statuscolumn custom numbering (with ranges over visual selection)
-- 		local hl = vim.api.nvim_get_hl(0, { name = U.get_mode_hl() or "Normal" })
-- 		local curline_hl = vim.api.nvim_get_hl(0, { name = "CursorLine" })
-- 		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = hl.fg, bg = curline_hl.bg })
-- 	end,
-- })

-- TODO: move tihs function to helpers
-- =====** HELP_GREP function **==========================================

-- -- Load the 'mini.pick' module
-- local MiniPick = require("mini.pick")
--
-- -- Define a function to search the help documentation and open the results in the quickfix list picker
-- local function help_grep(args)
-- 	-- Construct the pattern from the arguments
-- 	local pattern = table.concat(args.fargs, " ")
--
-- 	-- Search the help documentation
-- 	vim.api.nvim_command("helpgrep " .. pattern)
--
-- 	-- Open the results in the quickfix list picker
-- 	MiniPick.start({ source = MiniPick.registry.quickfix() })
-- end
--
-- -- Define a new command
-- vim.api.nvim_create_user_command("HelpGrep", help_grep, { nargs = "*", complete = "shellcmd" })
--========================================================================
--
--
-- =========================================================================
-- Mini Modules
-- =========================================================================
-- open on buffer enter
local mini_starter = "/Users/bassam/Starter"
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		if vim.api.nvim_buf_get_name(0) ~= mini_starter then
			require("mini.map").open()
		end
	end,
})
-- refresh on window resize
vim.api.nvim_create_autocmd("VimResized", {
	callback = function()
		if vim.api.nvim_buf_get_name(0) ~= mini_starter then
			require("mini.map").refresh()
		end
	end,
})
--
--
-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"checkhealth",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})
