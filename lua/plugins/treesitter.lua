return {
	"nvim-treesitter/nvim-treesitter",
	version = false, -- last release is way too old
	cmd = { "TSInstall", "TSBufEnable", "TSUpdate", "TSBufDisable", "TSModuleInfo" },
	build = ":TSUpdate",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	keys = {
		{ "<C-cr>", desc = "Increment selection" },
		{ "<bs>", desc = "Decrement selection", mode = "x" },
	},

	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-context",
			-- Match the context lines to the source code.
			-- multiline_threshold = 1,
			enabled = true,
			opts = { mode = "cursor", max_lines = 3 },
			keys = {
				{
					"[c",
					function()
						-- IDK why but it doesn't work without vim.schedule - hint from Maria config
						vim.schedule(function()
							require("treesitter-context").go_to_context()
						end)
					end,
					desc = "Jump to upper context",
					-- expr = true,
				},
			},
		},
	},
	config = function()
		vim.defer_fn(function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				indent = { enable = true },
				ensure_installed = {
					"c",
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
					"r",
					"query",
					"sql",
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
			})
		end, 500)
	end,
	-- -- ensure that each language in the ensure_installed table is unique.
	-- ---@diagnostic disable-next-line: undefined-doc-name
	-- ---@param opts TSConfig
	-- config = function(_, opts)
	--   if type(opts.ensure_installed) == "table" then
	--     ---@type table<string, boolean>
	--     local added = {}
	--     ---@diagnostic disable-next-line: inject-field
	--     opts.ensure_installed = vim.tbl_filter(function(lang)
	--       if added[lang] then
	--         return false
	--       end
	--       added[lang] = true
	--       return true
	--     end, opts.ensure_installed)
	--   end
	--   require("nvim-treesitter.configs").setup(opts)
	-- end,
}
