local M = {}
local opt = vim.opt -- for concisenes

M.initial = function()
  -- stylua: ignore start
	vim.g.mapleader            =  " " -- set leader key to space
	-- Set <\> as the local leader key - it gives me a whole new set of letters.
	vim.g.maplocalleader       =  "\\" -- we need to escabe \ with another \
	-- Appearance
	opt.termguicolors          =  true
	-- opt.background             =  "dark" -- already set in colorrswitch
	opt.signcolumn             =  "yes"
	-- line numbers
	opt.relativenumber         =  true
	opt.number                 =  true
	opt.mouse                  =  "a"-- Enable mouse mode.
	-- tabs & indentation
	opt.tabstop                =  2
	opt.shiftwidth             =  2
	opt.expandtab              =  true
	-- opt.autoindent          =  true
	opt.shiftround             =  true -- Round indent
	opt.statuscolumn           =  [[%!v:lua.require'utils'.statuscolumn()]]
	opt.undofile               =  true-- Save undo history.
	opt.undolevels             =  10000
	-- Cursor settings
	opt.cursorline             =  true
  if not vim.g.neovide then
	opt.guicursor              =  "a:block-Cursor/lCursor,v:block,i:ver25-TermCursor"
  end
	-- view and session options
  opt.virtualedit            =  "block"
	opt.viewoptions            =  "cursor,folds"
	opt.sessionoptions         =  "buffers,curdir,folds,help,tabpages,winsize"
	opt.clipboard:append("unnamedplus")
	opt.list                   =  true
	vim.opt.listchars:append({
		trail                    =  "·",
		-- tab                   =  "   ",
    -- leadmultispace           =  "│ ",
    -- multispace            =  "│ ",
    tab                      =  "│ ",
    -- space                 =  '⋅'
	})
	-- opt.splitkeep           =  "screen"
	opt.laststatus             =  3
	opt.pumheight              =  10 -- Maximum number of entries in a popup
	opt.scrolloff              =  8
	opt.sidescrolloff          =  8
	opt.sidescroll             =  8 -- keep in the center of the screen horizantly
	opt.inccommand             =  "split" -- split window for substitute - nice to have
	--spli windows
	opt.splitright             =  true
	opt.splitbelow             =  true
	-- search settings
	opt.ignorecase             =  true
	opt.smartcase              =  true
	if vim.env.VSCODE then
		vim.g.vscode             =  true
	end
	-- Use ripgrep for grepping.
	opt.grepprg                =  "rg --vimgrep"
	opt.grepformat             =  "%f:%l:%c:%m"
	-- Confirm to save changes before exiting modified buffer
	opt.confirm                =  true
	--line wrapping
	opt.wrap                   =  false
	-- yank to Capital case register with reserving lines
	opt.cpoptions:append(">")
	-- completion
	vim.opt.wildignore:append({ ".DS_Store" })
	opt.conceallevel           =  2 -- Hide * markup for bold and italic
	opt.foldcolumn             =  "1"
	-- opt.foldlevel              =  99
	-- UI characters.
	opt.fillchars:append({
		foldopen                 =  "",
		foldclose                =  "",
		-- fold                  =  "⸱",
		fold                     =  " ",
		foldsep                  =  " ",
		diff                     =  "╱",
		eob                      =  " ",
	})
	-- opt.foldtext            =  "v:lua.require'utils'.foldtext()"
	if vim.fn.has("nvim-0.10") == 1 then
    opt.smoothscroll         =  true
    -- vim.opt.foldmethod       =  "expr"
    -- vim.wo.foldtext          =  'v:lua.vim.treesitter.foldtext()'
    -- vim.wo.foldexpr          =  'v:lua.vim.treesitter.foldexpr()'

		-- vim.opt.foldexpr         =  "v:lua.require'lazyvim.util'.ui.foldexpr()"
	else
		vim.opt.foldmethod       =  "indent"
	end
	-- stylua: ignore end
end

-- backsapace
-- opt.backspace = "indent,eol,start"

-- opt.formatoptions = "jcroqlnt" -- tcqj
-- this drove me crzy - it controll how vertical movement behave when tab is used

if not vim.g.vscode then
	opt.showmode = false
end

--
-- Disable health checks for these providers.
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

if vim.g.neovide then
	vim.g.neovide_transparency = 1
	vim.g.neovide_input_macos_alt_is_meta = true
	vim.g.neovide_cursor_animation_length = 0.2
	vim.g.neovide_cursor_trail_size = 0.2
	vim.g.neovide_cursor_antialiasing = false
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<D-v>", "<ESC>pli") -- Paste insert mode
end

--
return M
