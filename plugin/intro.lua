-- Disable default intro message - no need but why not
vim.opt.shortmess:append("I")

local intro_logo = {
	"         .▄▄ · ▪  ▄▄▌   ▄▄▄·    󰲓     Z ",
	" 󰩖     ▐█ ▀. ██ ██•  ▐█ ▀█      Z     ",
	"         ▄▀▀▀█▄▐█·██▪  ▄█▀▀█   z        ",
	"         ▐█▄▪▐█▐█▌▐█▌▐▌▐█ ▪▐ z          ",
	"          ▀▀▀▀ ▀▀▀.▀▀▀  ▀  ▀            ",
	"       As Cutest As The Moon 󰽦    ",
}

local function draw_minintro()
	local buffer = vim.api.nvim_get_current_buf()
	if not vim.api.nvim_buf_is_valid(buffer) then
		return
	end

	local window = vim.fn.bufwinid(buffer)
	local screen_width = vim.api.nvim_win_get_width(window)
	local screen_height = vim.api.nvim_win_get_height(window)
		- vim.opt.cmdheight:get()
	local logo_width = 41
	local logo_height = #intro_logo

	local start_col = math.floor((screen_width - logo_width) / 2)
	local start_row = math.floor((screen_height - logo_height) / 2)
	if start_col < 0 or start_row < 0 then
		return
	end

	local top_space = {}
	for _ = 1, start_row do
		table.insert(top_space, "")
	end

	local col_offset_spaces = {}
	for _ = 1, start_col do
		table.insert(col_offset_spaces, " ")
	end
	local col_offset = table.concat(col_offset_spaces, "")

	local adjusted_logo = {}
	for _, line in ipairs(intro_logo) do
		table.insert(adjusted_logo, col_offset .. line)
	end

	vim.api.nvim_buf_set_lines(buffer, 1, 1, true, top_space)
	vim.api.nvim_buf_set_lines(buffer, start_row, start_row, true, adjusted_logo)
end

-- Display the intro message in the current buffer
local function display_minintro()
	draw_minintro()
end

-- Setup function configures the plugin and creates an auto command that triggers the display_minintro function when Neovim starts
local function setup()
	vim.api.nvim_create_autocmd("VimEnter", {
		callback = display_minintro,
		once = true,
	})
end

return {
	setup = setup,
}
