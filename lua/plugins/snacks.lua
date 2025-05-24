return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			formats = {
				key = function(item)
					return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
				end,
			},
			sections = {
				{
					section = "terminal",
					cmd =
					"chafa $(echo $WAL_WALLPAPER) --format symbols --symbols block --size 60x17 --stretch || chafa $HOME/.config/nvim/lua/eclipse.jpg --format symbols --symbols block --size 60x17 --stretch; sleep .1",
					-- cat $HOME/.config/nvim/lua/current_wallpaper.txt
					height = 17,
					padding = 1,
				},
				{
					gap = 1,
					{
						action = "<leader>ff",
						key = "f",
						desc = "Find File",
						icon = " ",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')"
					},
					{
						action = "<leader>fg",
						key = "t",
						desc = "Find Text",
						icon = "󱎸 ",
					},
					{
						action = "<leader>qs",
						key = "s",
						desc = "Sessions",
						icon = " ",
					},
					{
						icon = " ",
						desc = "Browse Repo",
						padding = 1,
						key = "b",
						action = function()
							Snacks.gitbrowse()
						end,
					},
					{
						action = ":qa",
						key = "q",
						desc = "Quit",
						icon = "󰈆 ",
					},
					-- {
					-- 	icon = " ",
					-- 	title = "Git Status",
					-- 	section = "terminal",
					-- 	enabled = function()
					-- 		return Snacks.git.get_root() ~= nil
					-- 	end,
					-- 	cmd = "git status --short --branch --renames",
					-- 	height = 2,
					-- 	ttl = 1 * 60,
					-- 	indent = 3,
					-- },
				},
			},
		},
		notifier = {
			enabled = false,
			style = "compact",
		},
		quickfile = { enabled = true },
		statuscolumn = { enabled = false },
		words = { enabled = true },
		scratch = {
			icon = " ",
		},
		lazygit = {
			-- Theme for lazygit
			theme = {
				[241]                      = { fg = "Special" },
				activeBorderColor          = { fg = "Character", bold = true },
				cherryPickedCommitBgColor  = { fg = "Identifier" },
				cherryPickedCommitFgColor  = { fg = "Function" },
				defaultFgColor             = { fg = "Title" },
				inactiveBorderColor        = { fg = "Tag" },
				optionsTextColor           = { fg = "Visual" },
				searchingActiveBorderColor = { fg = "MatchParen", bold = true },
				selectedLineBgColor        = { bg = "IncSearch" }, -- set to `default` to have no background colour
				unstagedChangesColor       = { fg = "PreProc" },
			},

		},
		styles = {
			notification = {
				wo = {
					wrap = true,
				},
			},
			scratch = {
				wo = { winhighlight = "NormalFloat:Normal" }, -- change the the theme using hi groups
			},
		},
	},

	keys = {
		{ "<leader>os", function() Snacks.scratch() end,            desc = "Toggle Scratch Buffer" },
		{ "<leader>tS", function() Snacks.scratch.select() end,     desc = "Select Scratch Buffer" },
		-- { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
		{ "<leader>bd", function() Snacks.bufdelete() end,          desc = "Delete Buffer" },
		{ "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
		{ "<leader>gg", function() Snacks.lazygit() end,            desc = "Lazygit" },
		{ "<leader>gl", function() Snacks.lazygit.log() end,        desc = "Lazygit logs" },
		-- { "<leader>un", function() Snacks.notifier.hide() end,         desc = "Dismiss All Notifications" },
		{ "<leader>tt", function() Snacks.terminal() end,           desc = "Toggle Terminal",      mode = { "n", "t" } },
		{ "<leader>z",  function() Snacks.zen() end,                desc = "Toggle Zen Mode" },
	},
}
