return {
	--- apply one highlight for bg and another for fg
	"echasnovski/mini.hipatterns",
	cond = function()
		return not vim.b.large_file
	end,
	event = "BufReadPost",
	config = function()
		local mini_hipatterns = require("mini.hipatterns")

		if mini_hipatterns then
			-- local keywords = { "NOTE", "BUG", "LOVE", "TODO", "FIX" }
			-- local icons = { "󰎞 ", "󰃤 ", "󰩖 ", "󰸞 ", "󰁨 " }
			local highlighters = {
				hex_color = mini_hipatterns.gen_highlighter.hex_color(),
				hsl_color = { -- thanks to https://github.com/craftzdog/dotfiles-public/blob/master/.config/nvim/lua/plugins/editor.lua
					pattern = "hsl%(%d+,? %d+%%?,? %d+%%?%)",
					group = function(_, match)
						local utils = require("utils.hi")
						--- @type string, string, string
						local nh, ns, nl = match:match("hsl%((%d+),? (%d+)%%?,? (%d+)%%?%)")
						--- @type number?, number?, number?
						local h, s, l = tonumber(nh), tonumber(ns), tonumber(nl)
						--- @type string
						local hex_color = utils.hslToHex(h, s, l)
						return mini_hipatterns.compute_hex_color_group(hex_color, "bg")
					end,
				},
			}
			-- for _, keyword in ipairs(keywords) do
			-- 	-- this is how we get attributes `fg = vim.api.nvim_get_hl(0, { name = 'NonText' }).fg,`
			-- 	local lowerKeyword = string.lower(keyword)
			-- 	-- local highlightGroup = string.format("HiPatterns%s", keyword)
			-- 	-- local fg = vim.api.nvim_get_hl(0, { name = highlightGroup }).fg
			-- 	highlighters[lowerKeyword] = {
			-- 		pattern = string.format("%s:", keyword),
			-- 		group = "IncSearch",
			-- 		extmark_opts = {
			-- 			sign_text = icons[_],
			-- 			sign_hl_group = "IncSearch",
			-- 		},
			-- 	}
			-- 	highlighters[string.format("%s_trail", lowerKeyword)] = {
			-- 		pattern = string.format("%s: ()%%S+.*()", keyword),
			-- 		group = "IncSearch",
			-- 	}
			-- end

			mini_hipatterns.setup({ highlighters = highlighters })
		end
	end,
}
