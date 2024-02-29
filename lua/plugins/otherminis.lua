return {
	-- TODO: change the highlight color of the view map 'MiniMapSymbolView'
	{
		"echasnovski/mini.map",
		cond = function()
			return not vim.b.large_file
		end,
		event = "FileType lua,norg,quarto",
		config = function()
			local map = require("mini.map")
			require("core.keymaps").minimap()
			local gen_integr = map.gen_integration
			if map then
				map.setup({
					integrations = {
						gen_integr.builtin_search(),
						gen_integr.diagnostic(),
						gen_integr.gitsigns(),
					},
					window = {
						show_integration_count = false,
						width = 2,
						winblend = 0,
						zindex = 75,
					},
				})
				for _, key in ipairs({ "n", "N", "*" }) do
					vim.keymap.set(
						"n",
						key,
						key
							.. "zv<Cmd>lua MiniMap.refresh({}, { lines = false, scrollbar = false })<CR>"
					)
				end

				vim.api.nvim_set_hl(0, "MiniMapSymbolCount", { fg = "#f38ba9" })
				map.open()
				vim.api.nvim_create_autocmd("VimResized", {
					callback = function()
						map.refresh()
					end,
				})
			end
		end,
	},

	{
		"echasnovski/mini.notify",
		event = "VeryLazy",
		config = function()
			local mini_notify = require("mini.notify")
			vim.notify = mini_notify.make_notify()
			-- FIX: convert the output to strings so it can appear in notify
			-- print = mini_notify.make_notify()
			-- vim.api.nvim_echo = mini_notify.make_notify()
			local cus_format = function(notif)
				local time = vim.fn.strftime("%H:%M:%S", math.floor(notif.ts_update))
				local icon = "\nNotification ❰❰"
				return string.format("%s │ %s %s", time, notif.msg, icon)
			end
			local row = function()
				local has_statusline = vim.o.laststatus > 0
				local bottom_space = vim.o.cmdheight + (has_statusline and 1 or 0)
				return vim.o.lines - bottom_space
			end
			mini_notify.setup({
				window = {
					config = function()
						return {
							col = vim.o.columns - 2,
							row = row(),
							anchor = "SE",
							title = "Notification ❰❰",
							title_pos = "right",
							---TODO: make max width 60%
							-- width = math.floor(0.6 * vim.o.columns),
							border = "solid",
						}
					end,
					max_width_share = 0.6,
				},
			})
		end,
	},

	{
		"echasnovski/mini.misc",
		opts = {},
		keys = {
			{ "<leader>mm", "<cmd>lua MiniMisc.zoom()<cr>", desc = "Zoom" },
			{
				"<leader>ur",
				"<cmd>lua MiniMisc.setup_auto_root()<cr>",
				desc = "[U]I [Root]",
			},
		},
	},

	{ "echasnovski/mini.sessions", lazy = true, opts = {} },

	{
		"echasnovski/mini.align",
		keys = {
			{ "ga", mode = { "v", "n" } },
			{ "gA", mode = { "v", "n" } },
		},
		opts = {},
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		{
			"echasnovski/mini.animate",
			event = "VeryLazy",
			opts = {},
		},
	},
	{
		"echasnovski/mini.bufremove",
		keys = {
			{
				"<localleader>x",
				function() -- credit to LazyVim for this implementation
					local bd = require("mini.bufremove").delete
					if vim.bo.modified then
						local choice = vim.fn.confirm(
							("Save changes to %q?"):format(vim.fn.bufname()),
							"&Yes\n&No\n&Cancel"
						)
						if choice == 1 then -- Yes
							vim.cmd.write()
							bd(0)
						elseif choice == 2 then -- No
							bd(0, true)
						end
					else
						bd(0)
					end
				end,
				desc = "Delete Buffer",
			},
			{
				"<localleader>X",
				function()
					require("mini.bufremove").delete(0, true)
				end,
				desc = "Delete Buffer (Force)",
			},
		},
	},
}
