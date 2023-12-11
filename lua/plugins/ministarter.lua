return {
	{
		"echasnovski/mini.starter",
		event = "VimEnter",
		opts = function()
			local logo = table.concat({

				"         .▄▄ · ▪  ▄▄▌   ▄▄▄·    󰲓     Z",
				" 󰩖     ▐█ ▀. ██ ██•  ▐█ ▀█      Z    ",
				"         ▄▀▀▀█▄▐█·██▪  ▄█▀▀█   z       ",
				"         ▐█▄▪▐█▐█▌▐█▌▐▌▐█ ▪▐ z         ",
				"          ▀▀▀▀ ▀▀▀.▀▀▀  ▀  ▀           ",
			}, "\n")
			local pad = string.rep(" ", 14)
			local new_section = function(name, action, section)
				return { name = name, action = action, section = pad .. section }
			end

			local starter = require("mini.starter")
  --stylua: ignore
  local config = {
    silent = true, -- this is so important to not bother me
    evaluate_single = true,
    header = logo,
    items = {


      new_section("Find file",    "Pick files", "Pick"),
      new_section("Recent files", "Pick oldfiles",   "Pick"),
      new_section("Grep text",    "Pick grep_live",  "Pick"),
      -- new_section("Projects",    "Pick projects",  "Pick"),
      new_section("init.lua",     "e $MYVIMRC",           "Config"),
      new_section("Lazy",         "Lazy",                 "Config"),
      new_section("New file",     "ene | startinsert",    "Built-in"),
      new_section("Obsidian find","ObsidianSearch",       "Obsidian"),
      new_section("Quit",         "qa",                   "Built-in"),
      -- new_section("Session restore", [[lua require("persistence").load()]], "Session"),
    },
    content_hooks = {
      starter.gen_hook.adding_bullet(pad .. "░ ", false),
      starter.gen_hook.aligning("center", "center"),
    },
  }
			return config
		end,
		config = function(_, config)
			local starter = require("mini.starter")
			starter.setup(config)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					local pad_footer = string.rep(" ", 8)
					starter.config.footer = pad_footer
						.. "⚡ Neovim loaded "
						.. stats.loaded
						.. "/"
						.. stats.count
						.. " plugins in "
						.. ms
						.. "ms"
					pcall(starter.refresh)
				end,
			})
		end,
	},
}
