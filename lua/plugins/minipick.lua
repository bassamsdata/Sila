return {
	{
		"echasnovski/mini.pick",
		dependencies = { "echasnovski/mini.extra", opts = {} },
		cmd = "Pick",
		config = function()
			local MiniPick = require("mini.pick")

			-- Setup 'mini.pick'
			MiniPick.setup({})

			-- File picker configuration
			local cursor_win_config = {
				relative = "cursor",
				anchor = "NW",
				row = 0,
				col = 0,
				width = 40,
				height = 20,
			}

			-- Modify the 'files' picker directly
			MiniPick.registry.files = function()
				return MiniPick.builtin.files({}, { window = { config = cursor_win_config } })
			end
			-- Help picker configuration
			local right_win_config = {
				relative = "editor",
				anchor = "SE",
				row = vim.o.lines,
				col = vim.o.columns,
				height = 20,
				width = 40,
			}

			-- Modify the 'help' picker directly
			MiniPick.registry.buffers = function()
				return MiniPick.builtin.buffers({}, { window = { config = right_win_config } })
			end
		end,
	},
}
