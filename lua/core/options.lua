-- set leader key to space
vim.g.mapleader = " "
-- Set <\> as the local leader key - it gives me a whole new set of letters.
vim.g.maplocalleader = '\\' -- we need to escabe \ with another \

local opt = vim.opt -- for concisenes

-- line numbers
opt.relativenumber = true
opt.number = true

-- Enable mouse mode.
vim.o.mouse = 'a'

-- Save undo history.
vim.o.undofile = true
opt.undolevels = 10000

-- Confirm to save changes before exiting modified buffer
opt.confirm = true 

-- Use ripgrep for grepping.
vim.o.grepprg = 'rg --vimgrep'
vim.o.grepformat = '%f:%l:%c:%m'

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

--line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- Cursor settings
opt.cursorline = true
opt.guicursor = "a:hor25,v:block,i:ver25"

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backsapace
opt.backspace = "indent,eol,start"

-- clipoboard
opt.clipboard:append("unnamedplus")

--spli windows
opt.splitright = true
opt.splitbelow = true

-- TESTING: consider dash - as one word
opt.iskeyword:append("-")

-- UI characters.
opt.fillchars = {
    eob = ' ',
  }

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
end
