-- Formatting.
return {
	{
		"stevearc/conform.nvim",
		event = { "LspAttach", "BufWritePre" },
		dependencies = { "mason.nvim" }, -- it doesn't work without this
		cmd = "ConformInfo",
		keys = {
			{
				"<leader>cF",
				function()
					require("conform").format({ formatters = { "injected" } })
				end,
				mode = { "n", "v" },
				desc = "Format Injected Langs",
			},
		},
		config = function()
			local conform = require("conform")
			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					go = { "goimports", "gofmt" },
					python = function(bufnr)
						if
							require("conform").get_formatter_info("ruff_format", bufnr).available
						then
							return { "ruff_format" }
						else
							return { "isort", "black" }
						end
					end,
				},
				-- formatters = {
				-- 	black = { prepend_args = { "--fast" } },
				-- },
				format_on_save = function(bufnr)
					-- Disable with a global or buffer-local variable
					if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
						return
					end
					return { timeout_ms = 2000, lsp_fallback = true }
				end,
			})

			vim.api.nvim_create_user_command("FormatDisable", function(args)
				if args.bang then
					-- FormatDisable! will disable formatting just for this buffer
					vim.b.disable_autoformat = true
				else
					vim.g.disable_autoformat = true
				end
				vim.notify("Autoformat disabled", vim.log.levels.INFO)
			end, {
				desc = "Disable autoformat-on-save",
				bang = true,
			})
			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
				vim.notify("Autoformat enabled", vim.log.levels.INFO)
			end, {
				desc = "Re-enable autoformat-on-save",
			})
			vim.keymap.set(
				"n",
				"<leader>me",
				"<cmd>FormatEnable<CR>",
				{ desc = "Enable autoformat-on-save" }
			)
			vim.keymap.set(
				"n",
				"<leader>md",
				"<cmd>FormatDisable<CR>",
				{ desc = "Disable autoformat-on-save" }
			)
			vim.keymap.set({ "n", "v" }, "<leader>mp", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end, { desc = "Format file or range" })
		end,
	},
}
