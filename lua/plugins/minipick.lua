return {
	{
		"echasnovski/mini.pick",
		dependencies = { "echasnovski/mini.extra", opts = {} },
		cmd = "Pick",
		opts = {
			window = {
				config = function()
					local height = math.floor(0.55 * vim.o.lines)
					local width = math.floor(0.55 * vim.o.columns)

					return {
						anchor = "NW",
						height = height,
						width = width,
						row = math.floor(0.5 * (vim.o.lines - height)),
						col = math.floor(0.5 * (vim.o.columns - width)),
					}
				end,
			},
		},
	},
}
