local M = {}

local ink_colors = require("shared.cosmicink.colors")
local ink_utils = require("shared.cosmicink.utils")
local ink_conditions = require("shared.cosmicink.conditions")

-- Config
local config = {
	options = {
		component_separators = '',
		section_separators = '',
		theme = {
			normal = {
				c = {
					fg = ink_colors.color.FG,
					bg = ink_colors.color.BG,
				}
			},
			inactive = {
				c = {
					fg = ink_colors.color.FG,
					bg = ink_colors.color.BG,
				},
			}, -- Simplified inactive theme
		},
		disabled_filetypes = {
			"neo-tree",
			"undotree",
			"sagaoutline",
			"diff",
		},
	},
	sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {
			{

				"location",
				color = function()
					return {
						fg = ink_colors.color.FG,
						gui = 'bold',
					}
				end,
			},
		},
		lualine_x = {
			{
				'filename',
				color = function()
					return {
						fg = ink_colors.color.FG,
						gui = 'bold,italic',
					}
				end,
			},
		},
		lualine_y = {},
		lualine_z = {},
	},
}


-- Helper functions
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

-- LEFT
ins_left {
	ink_utils.mode,
	color = function()
		local mode_color = ink_colors.get_mode_color()
		return {
			fg = ink_colors.color.BG,
			bg = mode_color,
			gui = 'bold',
		}
	end,
	padding = { left = 1, right = 1 },
}

ins_left(ink_utils.create_separator('left', true))

ins_left {
	function()
		return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
	end,
	icon = ' ',
	color = function()
		local virtual_env = vim.env.VIRTUAL_ENV
		if virtual_env then
			return {
				fg = ink_colors.get_mode_color(),
				gui = 'bold,strikethrough',
			}
		else
			return {
				fg = ink_colors.get_mode_color(),
				gui = 'bold',
			}
		end
	end,
}

ins_left(
	ink_utils.create_separator('right')
)

ins_left(
	ink_utils.create_mode_based_component('filename', nil, ink_colors.color.BG)
)

ins_left(
	ink_utils.create_separator('left')
)

ins_left {
	function()
		return ''
	end,
	color = function()
		return {
			fg = ink_colors.get_middle_color(),
		}
	end,
	cond = ink_conditions.hide_in_width,
}

ins_left {
	function()
		local git_status = vim.b.gitsigns_status_dict
		if git_status then
			return string.format(
				'+%d ~%d -%d',
				git_status.added or 0,
				git_status.changed or 0,
				git_status.removed or 0
			)
		end
		return ''
	end,
	-- icon = '󰊢 ',
	color = {
		fg = ink_colors.color.YELLOW,
		gui = 'bold',
	},
	cond = ink_conditions.hide_in_width,
}

for _, icons in pairs(ink_utils.icon_sets_list) do
	ins_left {
		function() return ink_utils.get_random_icon(icons) end,
		color = function()
			return {
				fg = ink_colors.get_animated_color(),
			}
		end,
		cond = ink_conditions.hide_in_width,
	}
end

ins_left {
	'searchcount',
	color = {
		fg = ink_colors.color.GREEN,
		gui = 'bold',
	},
}

-- RIGHT
ins_right {
	function()
		local reg = vim.fn.reg_recording()
		return reg ~= '' and '[' .. reg .. ']' or ''
	end,
	color = {
		fg = '#ff3344',
		gui = "bold",
	},
	cond = function()
		return vim.fn.reg_recording() ~= ''
	end
}

ins_right {
	'selectioncount',
	color = {
		fg = ink_colors.color.GREEN,
		gui = 'bold',
	},
}

for _, icons in ipairs(ink_utils.reversed_icon_sets) do
	ins_right {
		function() return ink_utils.get_random_icon(icons) end,
		color = function()
			return {
				fg = ink_colors.get_animated_color(),
			}
		end,
		cond = ink_conditions.hide_in_width,
	}
end

ins_right {
	function()
		local msg = 'No Active Lsp'
		local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
		local clients = vim.lsp.get_active_clients()
		if next(clients) == nil then
			return msg
		end
		local lsp_short_names = {
			pyright = "py",
			tsserver = "ts",
			rust_analyzer = "rs",
			lua_ls = "lua",
			clangd = "c++",
			bashls = "sh",
			jsonls = "json",
			html = "html",
			cssls = "css",
			tailwindcss = "tw",
			dockerls = "docker",
			sqlls = "sql",
			yamlls = "yml",
		}
		for _, client in ipairs(clients) do
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				return lsp_short_names[client.name] or client.name:sub(1, 2)
			end
		end
		return msg
	end,
	icon = ' ',
	color = {
		fg = ink_colors.color.YELLOW,
		gui = 'bold',
	},
}

ins_right {
	function()
		return ''
	end,
	color = function()
		return { fg = ink_colors.get_middle_color() }
	end,
	cond = ink_conditions.hide_in_width,
}

ins_right(
	ink_utils.create_separator('right')
)

ins_right(
	ink_utils.create_mode_based_component('location', nil, ink_colors.color.BG)
)

ins_right(
	ink_utils.create_separator('left')
)

ins_right {
	'branch',
	icon = '', -- 
	fmt = function(branch)
		if branch == '' or branch == nil then
			return 'No Repo '
		end

		-- Function to truncate a segment to a specified length
		local function truncate_segment(segment, max_length)
			if #segment > max_length then
				return segment:sub(1, max_length)
			end
			return segment
		end

		-- Split the branch name by '/'
		local segments = {}
		for segment in branch:gmatch('[^/]+') do
			table.insert(segments, segment)
		end

		-- Truncate all segments except the last one
		for i = 1, #segments - 1 do
			segments[i] = truncate_segment(segments[i], 1) -- Truncate to 1 character
		end

		-- If there's only one segment (no '/'), return it as-is
		if #segments == 1 then
			return segments[1] .. " "
		end

		-- Capitalize the first segment and lowercase the rest (except the last one)
		segments[1] = segments[1]:upper() -- First segment uppercase
		for i = 2, #segments - 1 do
			segments[i] = segments[i]:lower() -- Other segments lowercase
		end

		-- Combine the first segments with no separator and add '›' before the last segment
		local truncated_branch = table.concat(segments, '', 1, #segments - 1) .. '›' .. segments[#segments]

		-- Ensure the final result doesn't exceed a maximum length
		local max_total_length = 15
		if #truncated_branch > max_total_length then
			truncated_branch = truncated_branch:sub(1, max_total_length) .. '…'
		end

		return truncated_branch .. ' '
	end,
	color = function()
		local mode_color = ink_colors.get_mode_color()
		return {
			fg = mode_color,
			gui = 'bold',
		}
	end,
}

ins_right(
	ink_utils.create_separator('right')
)

ins_right(
	ink_utils.create_mode_based_component('progress', nil, ink_colors.color.BG)
)

M.cfg = config

return M
