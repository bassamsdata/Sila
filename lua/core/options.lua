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

