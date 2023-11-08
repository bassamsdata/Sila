-- set leader key to space
vim.g.mapleader = " "
-- Set <\> as the local leader key - it gives me a whole new set of letters.
vim.g.maplocalleader = "\\" -- we need to escabe \ with another \

local opt = vim.opt -- for concisenes

-- line numbers
opt.relativenumber = true
opt.number = true

-- Enable mouse mode.
opt.mouse = "a"

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
-- opt.autoindent = true
opt.shiftround = true -- Round indent

-- Save undo history.
opt.undofile = true
opt.undolevels = 10000

opt.statuscolumn = [[%!v:lua.require'core.util'.statuscolumn()]]

-- Confirm to save changes before exiting modified buffer
opt.confirm = true

-- Use ripgrep for grepping.
opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"

opt.pumheight = 10 -- Maximum number of entries in a popup

--line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- Cursor settings
opt.cursorline = true
opt.guicursor = "a:hor25,v:block,i:ver25"
opt.termguicolors = true -- True color support

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backsapace
-- opt.backspace = "indent,eol,start"

-- clipoboard
opt.clipboard:append("unnamedplus")

--spli windows
opt.splitright = true
opt.splitbelow = true

-- TESTING: consider dash - as one word
opt.iskeyword:append("_")
-- opt.formatoptions = "jcroqlnt" -- tcqj

-- this drove me crzy - it controll how vertical movement behave when tab is used
opt.list = true
-- UI characters.
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	-- fold = "⸱",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}

if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
end
