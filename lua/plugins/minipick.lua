return {
	{
		"echasnovski/mini.pick",
		dependencies = { "echasnovski/mini.extra", opts = {} },
		cmd = "Pick",
		config = function()
			local MiniPick = require("mini.pick")
			local MiniExtra = require("mini.extra")

			-- copy the item under the cursor
			local copy_to_register = {
				char = "<C-y>",
				func = function()
					local current_line = vim.fn.getline(".")
					vim.fn.setreg('"', current_line)
				end,
			}
			-- scrll by margin of 4 lines to not diorient
			local scroll_up = {
				char = "<C-k>",
				func = function()
					-- this is special character in insert mode press C-v then y
					-- while holding Ctrl to invoke
					vim.cmd("normal! 4")
				end,
			}
			local scroll_down = {
				char = "<C-j>",
				func = function()
					vim.cmd("norm! 4")
				end,
			}

			-- Setup 'mini.pick' with default window in the ceneter
			MiniPick.setup({
				use_cache = true,
				window = {
					config = function()
						local height = math.floor(0.618 * vim.o.lines)
						local width = math.floor(0.618 * vim.o.columns)
						return {
							anchor = "NW",
							height = height,
							width = width,
							row = math.floor(0.5 * (vim.o.lines - height)),
							col = math.floor(0.5 * (vim.o.columns - width)),
						}
					end,
				},
				mappings = {
					copy_to_register = copy_to_register,
					scroll_up_a_bit = scroll_up,
					scroll_down_a_bit = scroll_down,
				},
			})
			vim.ui.select = MiniPick.ui_select
			-- == Styles ==
			-- 1 - File picker configuration that follows cursor
			local cursor_win_config = {
				relative = "cursor",
				anchor = "NW",
				row = 0,
				col = 0,
				width = 50,
				height = 16,
			}
			-- 2 - Right side picker configuration
			local right_win_config = {
				relative = "editor",
				anchor = "SE",
				row = vim.o.lines,
				col = vim.o.columns,
				height = 16,
				width = 50,
			}

			-- Define a new picker for the quickfix list
			MiniPick.registry.quickfix = function()
				return MiniExtra.pickers.list({ scope = "quickfix" }, {})
			end

			-- Modify the 'files' picker directly
			MiniPick.registry.files = function()
				return MiniPick.builtin.files({}, { window = { config = cursor_win_config } })
			end

			-- Modify the 'old_files' picker directly
			MiniPick.registry.oldfiles = function()
				return MiniExtra.pickers.oldfiles({}, { window = { config = cursor_win_config } })
			end

			-- Modify the 'buffers' picker directly
			MiniPick.registry.buffers = function()
				return MiniPick.builtin.buffers({}, { window = { config = right_win_config } })
			end
		end,
	},
}
