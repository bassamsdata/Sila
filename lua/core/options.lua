-- set leader key to space
vim.g.mapleader = " "
-- Set <\> as the local leader key - it gives me a whole new set of letters.
vim.g.maplocalleader = "\\" -- we need to escabe \ with another \

-- TODO: change this to set becaue it's more intuitve
local opt = vim.opt -- for concisenes

if vim.env.VSCODE then
	vim.g.vscode = true
end

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
opt.laststatus = 3

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
opt.inccommand = "split" -- split window for substitute - nice to have

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
opt.splitkeep = "screen"

-- TESTING: consider dash - as one word
-- TODO: turns out, is not good. we'll try chrisgrieser/nvim-spider
-- opt.iskeyword:append("_")
-- opt.formatoptions = "jcroqlnt" -- tcqj

-- completion
vim.opt.wildignore:append({ ".DS_Store" })

-- this drove me crzy - it controll how vertical movement behave when tab is used
opt.list = true

opt.foldcolumn = "1"
opt.foldmethod = "indent"
-- opt.viewoptions = "cursor, folds"
vim.opt.foldtext = "v:lua.require'core.Util'.foldtext()"

vim.opt.listchars:append({
	trail = " ",
})

if vim.fn.has("nvim-0.9.0") == 1 then
	vim.opt.statuscolumn = [[%!v:lua.require'core.Util'.statuscolumn()]]
end

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
