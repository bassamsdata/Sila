return {
	{ "lunarvim/bigfile.nvim", opts = {} },
	{
		"mg979/vim-visual-multi",
		branch = "master",
		-- TODO: change the default keys and description for clues
		keys = {
			{ "<C-Down>" },
			{ "<C-n>" },
			{ "<C-Up>" },
		},
		-- config = function()
		-- 	require("visual-multi").setup({})
		-- end,
	},

	{
		"epwalsh/pomo.nvim",
		dev = true,
		version = "*", -- Recommended, use latest release instead of latest commit
		lazy = true,
		cmd = { "TimerStart", "TimerRepeat" },
		opts = {
			notifiers = {
				-- The "Default" timer uses 'nvim-notify' to continuously display the timer
				{
					name = "Default",
					opts = {
						sticky = false, -- set to false if you don't want to see the timer the whole time
						title_icon = "󱎫",
						text_icon = "󰄉",
					},
				},
				{ name = "System" },
			},
		},
	},

	{ -- TODO: try to replicate it but simply
		"kawre/neotab.nvim",
		event = "InsertEnter",
		opts = {},
	},

	{
		"Bekaboo/deadcolumn.nvim",
		-- dev = true,
		event = { "InsertEnter" },
		config = function()
			vim.opt.colorcolumn = "80"
			local opts = {
				modes = { "n", "i" },
				blending = {
					threshold = 0.75,
				},
				warning = {
					alpha = 0.1,
				},
			}
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "help",
				callback = function()
					vim.opt_local.colorcolumn = ""
				end,
			})
			require("deadcolumn").setup(opts)
		end,
	},

	{
		"b0o/incline.nvim",
		event = "BufReadPost",
		opts = {},
	},

	{
		"folke/zen-mode.nvim",
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "ZenMode" } },
		opts = {
			window = {
				width = 0.70,
				options = {
					number = false,
					relativenumber = false,
					list = false,
					scrolloff = 99,
				},
			},
			plugins = {
				twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
				gitsigns = { enabled = false },
				wezterm = {
					enabled = false,
					font = "+4", -- (10% increase per step)
				},
				options = {
					enabled = true,
					ruler = false, -- disables the ruler text in the cmd line area
					showcmd = false, -- disables the command in the last line of the screen
					laststatus = 0,
				},
			},
			on_open = function()
				vim.cmd("IBLDisable")
			end,
			on_close = function()
				vim.cmd("IBLEnable")
			end,
		},
	},
}
