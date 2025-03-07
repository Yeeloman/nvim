local pg = require("shared.PaletteGen")
local wal_colors = pg.read_wal_colors()
local colors = pg.colors_to_strings(wal_colors)

return -- lazy.nvim
{
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		{
			"rcarriga/nvim-notify",
			event = "VeryLazy",
			opts = {
				stages = "fade_in_slide_out", -- fade
				max_width = 50,
				timeout = 5000,
				render = "wrapped-compact",
				top_down = true,
				background_colour = colors[2] or "#1e1e2e",
				animate = true,
				icons = {
					DEBUG = "󱐌", -- 
					WARN = "", -- 
					ERROR = "", --    
					TRACE = "󱑽", --   󰙴
					INFO = "", --      
				},
			},
			config = function(_, opts)
				require("notify").setup(opts)
				vim.notify = require("notify")
				-- Set custom highlight groups for each level
				vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = colors[5] or "#0000FF" }) -- Debug Border Color
				vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { fg = colors[5] or "#0000FF" }) -- Debug Icon Color
				vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { fg = colors[5] or "#0000FF" }) -- Debug Title Color
				vim.api.nvim_set_hl(0, "NotifyDEBUGText", { fg = colors[5] or "#0000FF" }) -- Debug Text Color

				vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = colors[4] or "#00FF00" }) -- Info Border Color
				vim.api.nvim_set_hl(0, "NotifyINFOIcon", { fg = colors[4] or "#00FF00" }) -- Info Icon Color
				vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = colors[4] or "#00FF00" }) -- Info Title Color
				vim.api.nvim_set_hl(0, "NotifyINFOText", { fg = colors[4] or "#00FF00" }) -- Info Text Color

				vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg = colors[3] or "#FFFF00" }) -- Warn Border Color
				vim.api.nvim_set_hl(0, "NotifyWARNIcon", { fg = colors[3] or "#FFFF00" }) -- Warn Icon Color


				vim.api.nvim_set_hl(0, "NotifyWARTitle", { fg = colors[3] or "#FFFF00" }) -- Warn Title Color

				vim.api.nvim_set_hl(0, "NotifyWARNText", { fg = colors[3] or "#FFFF00" }) -- Warn Text Color

				vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = colors[6] or "#FF0000" }) -- Error Border Color
				vim.api.nvim_set_hl(0, "NotifyERRORIcon", { fg = colors[6] or "#FF0000" }) -- Error Icon Color
				vim.api.nvim_set_hl(0, "NotifyERRORTitle", { fg = colors[6] or "#FF0000" }) -- Error Title Color
				vim.api.nvim_set_hl(0, "NotifyERRORText", { fg = colors[6] or "#FF0000" }) -- Error Text Color

				-- vim.notify("This is a DEBUG message", vim.log.levels.DEBUG)
				-- vim.notify("This is an INFO message", vim.log.levels.INFO)
				-- vim.notify("This is a WARN message", vim.log.levels.WARN)
				-- vim.notify("This is an ERROR message", vim.log.levels.ERROR)
			end
		},
	},
	opts = {
		cmdline = {
			enabled = true, -- Enable the command-line UI
			view = "cmdline", -- Use a popup style cmdline_popup
			format = {
				-- Default command-line icon
				cmdline = { title = "", icon = "   ", highlight = "NoiceCmdlineIcon" },
				-- Lua command icon
				lua = { icon = "   ", highlight = "NoiceCmdlineLua" },
				-- Shell command icon
				shell = { title = "Sh", icon = "  ", highlight = "NoiceCmdlineShell" },
				-- Search command icon
				search_down = { icon = "󰶚  ", highlight = "NoiceCmdlineSearch" },
				search_up = { icon = "󰶚  ", highlight = "NoiceCmdlineSearch" },
				-- Filter command icon
				filter = { title = "", icon = "  ", highlight = "NoiceCmdlineFilter" },
				-- Help command icon
				help = { icon = "  ", highlight = "NoiceCmdlineHelp" },
			}
		},
		messages = {
			enabled = true, -- Enable messages (e.g., `:messages`)
			view = "notify", -- Use a minimal style for messages
		},
		popupmenu = {
			enabled = true,                                       -- Enable the popup menu UI
			backend = "nui",                                      -- Use `nui` for popup UI
			win_options = {
				winblend = 10,                                      -- Add transparency
				winhighlight = "Normal:Normal,FloatBorder:FloatBorder", -- Highlighting
			},
		},
		history = {
			view = "popup",                           -- Show history in a split window instead of a popup
			opts = { enter = true, format = "details" }, -- Enter mode & show details
		},
		views = {
			-- Custom view for the cmdline
			cmdline = {
				border = {
					style = "double", -- Options: "none", "single", "double", "rounded", "solid"
					padding = { 1, 1 },
				},
				position = {
					row = "90%", -- Position from the top
					col = "50%", -- Center horizontally
				},
				size = {
					width = "60%", -- Auto-adjust width
					height = "auto", -- Auto-adjust height
				},
				win_options = {
					winblend = 10,                                                   -- Transparency
					winhighlight = "NormalFloat:MyNormalFloat,FloatBorder:MyFloatBorder", -- Custom highlights
				},
			},
			popupmenu = {
				relative = "editor",
				position = {
					row = "70%",
					col = "50%",
				},
				size = {
					width = "40%",
					height = "30%",
				},
				border = {
					style = "double",
					padding = { 1, 2 },
				},
				win_options = {
					winblend = 10,
					-- winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
					winhighlight = "Normal:PopupNormal,FloatBorder:MyPopupBorder", -- Custom highlights
				},
			},
			cmdline_popup = {
				border = {
					style = "none", -- Options: "none", "single", "double", "rounded", "solid"
					padding = { 1, 1 },
				},
				position = {
					row = "15%",
					col = "50%",
				},
				size = {
					width = "auto",
					height = "auto",
				},
				win_options = {
					winblend = 10,
					winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
				},
			},
		},
		lsp = {
			progress = {
				enabled = true, -- Show LSP progress in the UI
				view = "mini", -- mini notify hover popup split notify_send
			},
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		presets = {
			bottom_search = true,      -- Use a bottom search bar like in IDEs
			command_palette = false,   -- Disable the command palette preset
			long_message_to_split = true, -- Split long messages into a separate buffer
			inc_rename = true,         -- for inc-rename to display smaller
		},
		routes = {
			{
				filter = { event = "msg_show", kind = "search_count" },
				view = "notify", -- used to be mini
			},
		},
	},
	-- config = true,
	config = function(_, opts)
		require("noice").setup(opts)

		-- Define custom highlights
		vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = colors[3] or "#d360aa", bold = true }) -- Default command-line icon

		-- Popup Menu Background Color
		-- vim.api.nvim_set_hl(0, "MyPopupNormal", { bg = wal_colors[1] or "#1e1e2e", fg = "#cdd6f4" })

		-- Popup Menu Border Color
		vim.api.nvim_set_hl(0, "MyPopupBorder", { fg = colors[3] or "#f5e0dc", bold = true })
	end,
}
