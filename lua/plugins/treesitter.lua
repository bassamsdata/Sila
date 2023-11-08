return {
	"nvim-treesitter/nvim-treesitter",
	version = false, -- last release is way too old
	build = ":TSUpdate",
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
	keys = {
		{ "<C-cr>", desc = "Increment selection" },
		{ "<bs>", desc = "Decrement selection", mode = "x" },
	},
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
		ensure_installed = {
			"bash",
			"diff",
			"html",
			"json",
			"lua",
			"luadoc",
			"luap",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"regex",
			"toml",
			"vim",
			"vimdoc",
			"yaml",
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-cr>",
				node_incremental = "<C-cr>",
				scope_incremental = false,
				node_decremental = "<bs>",
			},
		},
		-- textobjects = {
		-- 	move = {
		-- 		enable = true,
		-- 		goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
		-- 		goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
		-- 		goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
		-- 		goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
		-- 	},
		-- },
	},
	-- ensure that each language in the ensure_installed table is unique.
	---@diagnostic disable-next-line: undefined-doc-name
	---@param opts TSConfig
	config = function(_, opts)
		if type(opts.ensure_installed) == "table" then
			---@type table<string, boolean>
			local added = {}
			---@diagnostic disable-next-line: inject-field
			opts.ensure_installed = vim.tbl_filter(function(lang)
				if added[lang] then
					return false
				end
				added[lang] = true
				return true
			end, opts.ensure_installed)
		end
		require("nvim-treesitter.configs").setup(opts)
	end,
}
