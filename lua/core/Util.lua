local M = {}

function M.custom_notify(message, level)
	local highlight = {
		Error = "ErrorMsg",
		Warn = "WarningMsg",
		Info = "None",
		Debug = "Comment",
	}

	local style = {
		Error = "✗",
		Warn = "⚠",
		Info = "ℹ",
		Debug = "☰",
	}

	local icon = style[level] or "ℹ"
	local hl = highlight[level] or "None"

	vim.api.nvim_echo({
		{ icon, hl },
		{ ": ", "None" },
		{ message, hl },
	}, true, {})
end

