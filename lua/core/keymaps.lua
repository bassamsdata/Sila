-- SideNote: I used (and still use) LazyVim for a long time so my mind is used to its keybindings
local map = vim.keymap.set
-- to be able to put most ;) keymaps here and keep lazy loading for some plugins
local M = {}
-- open grep directly and then open quickfix with the results

-- LOVE: search within visual selection - this is magic
vim.keymap.set("x", "/", "<Esc>/\\%V")

map("n", "<localleader>g", "<cmd>lua require('core.Util').grepandopen()<cr>")
map("n", "§§", "<cmd>cclose<cr>")

-- delete single character without copying into register
map("n", "x", '"_x')
map({ "n", "i", "x", "!", "v" }, "§", "<esc>")

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

map("n", "<localleader>e", "<cmd>Explore<cr>")

map("n", "<localleader>x", "<cmd>bd<cr>")
map("n", "L", "<cmd>bn<cr>")

-- ================================================================
-- Mini Modules
map("n", "<leader>f", "<cmd>Pick files<cr>")
map("n", "<leader>g", "<cmd>Pick grep_live<cr>")
map("n", "<leader>b", "<cmd>Pick buffers<cr>")

M.mini_files_key = {
	{
		"<leader>e",
		function()
			local bufname = vim.api.nvim_buf_get_name(0)
			local path = vim.fn.fnamemodify(bufname, ":p")
			if vim.fn.filereadable(path) == 1 then
				MiniFiles.open(bufname, false)
			else
				MiniFiles.close()
			end
		end,
		{ desc = "File explorer" },
	},
}

return M
