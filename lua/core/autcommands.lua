local U = require("utils")
local autocmd = vim.api.nvim_create_autocmd

-- Create automatic naming for groups
local function augroup(name)
	return vim.api.nvim_create_augroup("sila_" .. name, { clear = true })
end
autocmd("BufReadPre", {
	group = augroup("largefilesettings"),
	desc = "Set settings for large files.",
	callback = function(info)
		vim.b.midfile = false
		vim.b.bigfile = false
		local stat = vim.uv.fs_stat(info.match)
		if not stat then
			return
		end
		if stat.size > 48000 then
			vim.b.midfile = true
			autocmd("BufReadPost", {
				buffer = info.buf,
				once = true,
				callback = function()
					vim.schedule(function()
						pcall(vim.treesitter.stop, info.buf)
					end)
					return true
				end,
			})
		end
		if stat.size > 1024000 then
			vim.b.bigfile = true
			vim.opt_local.spell = false
			vim.opt_local.swapfile = false
			vim.opt_local.undofile = false
			vim.opt_local.breakindent = false
			vim.opt_local.colorcolumn = ""
			vim.opt_local.statuscolumn = ""
			vim.opt_local.signcolumn = "no"
			vim.opt_local.foldcolumn = "0"
			vim.opt_local.winbar = ""
			vim.cmd.syntax("off")
		end
	end,
})

autocmd({ "BufWinLeave", "BufWritePost" }, {
	group = augroup("save_view"),
	callback = function()
		vim.cmd([[silent! mkview]])
	end,
})

autocmd({ "BufWinEnter" }, {
	group = augroup("load_view"),
	callback = function()
		vim.cmd([[silent! loadview]])
	end,
})

-- -- write an autocommand to save the session automatically before leaving neovim
-- vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
-- 	group = augroup("save_session"),
-- 	callback = function()
-- 		vim.cmd([[mksession!]] .. vim.fn.stdpath("data") .. "/session.vim")
-- 	end,
-- })

-- Open Mini.map omn certain filetypes
local function openclose()
	local enable = { "lua", "python", "r" }
	local ft = vim.bo.filetype
	if ft == "" then
		return
	else
		for _, v in ipairs(enable) do
			if ft == v then
				require("mini.map").open()
				break
			end
		end
	end
end

autocmd("FileType", {
	group = augroup("yanking"),
	pattern = "qf",
	desc = "Yank in quickfix with no ||",
	callback = function()
		vim.keymap.set(
			"n",
			"<leader>y",
			"<cmd>normal! wy$<cr>",
			{ noremap = true, silent = true }
		)
	end,
})

vim.api.nvim_create_user_command("Mess", function()
	local scratch_buffer = vim.api.nvim_create_buf(false, true)
	vim.bo[scratch_buffer].filetype = "vim"
	local messages = vim.split(vim.fn.execute("messages", "silent"), "\n")
	vim.api.nvim_buf_set_text(scratch_buffer, 0, 0, 0, 0, messages)
	vim.cmd.sbuffer(scratch_buffer)
	vim.cmd("$")
end, {})

-- Highlight on yank
autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local function save_cursorline_colors()
	_G.cursorline_bg_orig_gui =
		vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("CursorLine")), "bg", "gui")
	_G.cursorline_bg_orig_cterm = vim.fn.synIDattr(
		vim.fn.synIDtrans(vim.fn.hlID("CursorLine")),
		"bg",
		"cterm"
	)
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
autocmd({ "RecordingEnter", "ColorScheme" }, {
	group = "macro_visual_indication",
	callback = function()
		save_cursorline_colors()
		update_cursorline_colors(vim.fn.reg_recording() ~= "")
	end,
})

autocmd("RecordingLeave", {
	group = "macro_visual_indication",
	callback = function()
		update_cursorline_colors(false)
	end,
})

-- go to last loc when opening a buffer
autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if
			vim.tbl_contains(exclude, vim.bo[buf].filetype)
			or vim.b[buf].lazyvim_last_loc
		then
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

-- vim.api.nvim_create_autocmd({ "TextChangedI", "TextChangedP" }, {
-- 	callback = trigger_completion,
-- 	pattern = "*",
-- })

-- Change the current line number depend on neovim mode
-- similar to modicator.nvim plugin

autocmd({ "ModeChanged" }, {
	group = augroup("modechange"),
	callback = function()
		-- make it work on statuscolumn custom numbering (with ranges over visual selection)
		local hl = vim.api.nvim_get_hl(0, { name = U.get_mode_hl() })
		-- local curline_hl = vim.api.nvim_get_hl(0, { name = "CursorLine" })
		vim.api.nvim_set_hl(0, "CursorLineNr", {
			fg = hl.fg,
			-- bg = curline_hl.bg
		})
	end,
})

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

-- close some filetypes with <q>
autocmd("FileType", {
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
		vim.keymap.set(
			"n",
			"q",
			"<cmd>close<cr>",
			{ buffer = event.buf, silent = true }
		)
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})
