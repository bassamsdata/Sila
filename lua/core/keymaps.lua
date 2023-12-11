-- Side Note: I used (and still use) LazyVim for a long time so my mind is used to its keybindings
local map = vim.keymap.set
-- to be able to put most ;) keymaps here and keep lazy loading for some plugins
local M = {}

-- LOVE: I love these mappings. **They are fun**
-- === This is the love section. I really larened alot from those keymaps
map("x", "/", "<Esc>/\\%V") --search within visual selection - this is magic
-- Replace all instances of highlighted words
map("v", "<leader>r", '"hy:%s/<C-r>h//g<left><left>', { desc = "Replace all instances" })
-- open grep directly and then open quickfix with the results
map("n", "<localleader>g", "<cmd>lua require('core.Util').grepandopen()<cr>", { desc = "Grep and open quickfix" })
-- motions -- I really didn't know about such amazing keymaps `:h omap-info`
-- entire buffer (https://vi.stackexchange.com/a/2321)
-- like you can do `daa` to delete entire buffer, `yaa` to yank entire buffer
map("o", "aa", ":<c-u>normal! mzggVG<cr>`z")
-- love section === === === === === === === === === === === === === === === ===

-- Misc === === === === === === === === === === === === === === === === === ===
map("n", "x", '"_x') -- delete single character without copying into register
map({ "n", "i", "!", "v" }, "§", "<esc>")
map("n", "§§", "<cmd>cclose<cr>") -- close quickfix with §§

-- HACK: this is to insert the fukking hashtag sign in neovim in conjunction
-- with this keymap in wezterm { key = "1", mods = "OPT", action = act.SendKey({ key = "1", mods = "ALT" }) }
map("i", "<A-1>", "#")

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" }) -- Open the package manager lazy

-- Keeping the cursor centered when cycling search results
map("n", "n", "nzzzv", { desc = "Next result" })
map("n", "N", "Nzzzv", { desc = "Previous result" })

-- page shift
map("n", "<C-Up>", "<C-y>k", { desc = "Shift page up one line" })
map("n", "<C-Down>", "<C-e>j", { desc = "Shift page down one line" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize +2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize -2<cr>", { desc = "Increase window width" })

-- Buffers
map("n", "<localleader>x", "<cmd>bd<cr>", { desc = "Close buffer" })
map("n", "<localleader>X", "<cmd>bd!<cr>", { desc = "Force Close buffer" })
map("n", "L", "<cmd>bn<cr>") -- switch to next buffer
map("n", "H", "<cmd>bp<cr>") -- switch to previous buffer

-- Make U opposite to u.
map("n", "U", "<C-r>", { desc = "Redo" })

-- TODO: check if this is correct before apply
-- Execute macro over a visual region.
-- map('x', '@', function()
--     return ':norm @' .. vim.fn.getcharstr() .. '<cr>'
-- end, { expr = true })

-- Word navigation in non-normal modes.
map({ "i", "c" }, "<C-h>", "<C-Left>", { desc = "Move word(s) backwards" })
map({ "i", "c" }, "<C-l>", "<C-Right>", { desc = "Move word(s) forwards" })

-- Move Lines
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- preserve cursor position on visual yank
map("x", "y", "ygv<ESC>")
-- move cursor to the start of the line on format
map("n", "==", "==_")
map("x", "=", "=gv_")
-- go to end after a join
map("n", "J", "J_")
-- TODO: replace it with treesj plugin
-- split (opposite of J)
map("n", "S", "T hr<CR>k$")

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- === === === === === === === === === === === === === === === === === ===
-- === === Mini Modules
-- === === === === === === === === === === === === === === === === === ===
map("n", "<leader>ff", "<cmd>Pick files<cr>", { desc = "[F]ind [F]iles" })
map("n", "<leader><space>", "<cmd>Pick files<cr>", { desc = "[F]ind [F]iles" })
map("n", "<leader>fg", "<cmd>Pick grep_live<cr>", { desc = "[F]ind [G]rep_live" })
map("n", "<leader>fo", "<cmd>Pick oldfiles<cr>", { desc = "[F]ind [O]ld files" })
map("n", "<leader>fr", "<cmd>Pick resume<cr>", { desc = "[F]ind [R]esume" })
map("n", "<leader>fh", "<cmd>Pick help<cr>", { desc = "[F]ind [H]elp" })
map("n", "<leader>fk", "<cmd>Pick keymaps<cr>", { desc = "[F]ind [K]eymaps" })
map("n", "<leader>b", "<cmd>Pick buffers<cr>", { desc = "[F]ind [B]uffers" })
map("n", "<leader>fk", "<cmd>Pick keymaps<cr>", { desc = "[F]ind [K]eymaps" })
map("n", "<leader>fh", "<cmd>Pick hl_groups<cr>", { desc = "[F]ind [H]ighlights" })

-- I got this from reddit - wow, look how simple it is
M.mini_files_key = {
	{
		"<leader>e",
		function()
			-- added this just to open the mini.files at the current file location
			local bufname = vim.api.nvim_buf_get_name(0)
			local _ = require("mini.files").close() or require("mini.files").open(bufname, false)
		end,
		{ desc = "File explorer" },
	},
}

-- credit to @MariaSolOs
-- Use dressing for spelling suggestions.
map("n", "z=", function()
	vim.ui.select(
		vim.fn.spellsuggest(vim.fn.expand("<cword>")),
		{},
		vim.schedule_wrap(function(selected)
			if selected then
				vim.cmd("normal! ciw" .. selected)
			end
		end)
	)
end, { desc = "Spelling suggestions" })

-- clean registers
local function clear_registers()
	local registers = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"'
	for register in registers:gmatch(".") do
		vim.fn.setreg(register, {})
	end
end
map("n", "<leader>rg", clear_registers, { desc = "Clear registers" })

return M
