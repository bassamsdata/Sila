-- total rewrite version, thanks to Bekaboo "https://github.com/Bekaboo/nvim/blob/master/plugin/colorswitch.lua"
-- thanks to nvchad as well for the idea of dofile and replace_word

local M = {}
M.color_scheme = M.color_scheme or {
	bg = "dark",
	colors_name = "nano",
}

M.file_path = vim.fn.stdpath("config") .. "/plugin/colorswitch.lua"

if M.color_scheme.bg ~= vim.go.bg then
	vim.go.bg = M.color_scheme.bg
end

if M.color_scheme.colors_name ~= vim.g.colors_name then
	vim.cmd.colorscheme({
		args = { M.color_scheme.colors_name },
		mods = { emsg_silent = true },
	})
end

function M.replace_word(old, new)
	local file, err = io.open(M.file_path, "r")
	if not file then
		vim.notify("Failed to open file: " .. err, vim.log.levels.ERROR)
		return
	end
	local content = file:read("*all")
	file:close()
	-- TODO: vim.g.colors_name only output the first word - try to implemtnt vim.fn.getcompletion('', 'color')
	-- local added_pattern = string.gsub(old, "-", "%%-") -- add % before - if exists
	local new_content = content:gsub(old, new)
	file, err = io.open(M.file_path, "w")
	if not file then
		vim.notify("Failed to open file for writing: " .. err, vim.log.levels.ERROR)
		return
	end
	file:write(new_content)
	file:close()
end

vim.api.nvim_create_autocmd("Colorscheme", {
	group = vim.api.nvim_create_augroup("ColorSwitch", {}),
	desc = "Update color scheme on colorscheme change.",
	callback = function()
		-- we can utilize dofile() here but this option is better
		local old = M.color_scheme
		vim.schedule(function()
			local new = vim.g.colors_name
			local n_bg = vim.go.bg
			if new ~= old.colors_name or n_bg ~= old.bg then
				M.replace_word(old.bg, n_bg)
				M.replace_word(old.colors_name, new)
				pcall(vim.system, { "setbg", vim.go.bg })
				pcall(vim.system, { "setcolor", vim.g.colors_name })
				M.color_scheme = {
					bg = n_bg,
					colors_name = new,
				}
			end
		end)
	end,
})

return M
