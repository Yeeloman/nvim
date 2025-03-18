M = {}

-- Theme colors
M.default_colors = {
	BG       = '#16181b', -- Dark background
	FG       = '#c5c4c4', -- Light foreground for contrast
	YELLOW   = '#e8b75f', -- Vibrant yellow
	CYAN     = '#00bcd4', -- Soft cyan
	DARKBLUE = '#2b3e50', -- Deep blue
	GREEN    = '#00e676', -- Bright green
	ORANGE   = '#ff7733', -- Warm orange
	VIOLET   = '#7a3ba8', -- Strong violet
	MAGENTA  = '#d360aa', -- Deep magenta
	BLUE     = '#4f9cff', -- Light-medium blue
	RED      = '#ff3344', -- Strong red
}

local shared_colors = require("shared.PaletteGen")
local wal_colors = shared_colors.read_wal_colors()
local generated_palette = shared_colors.generate_palette(wal_colors, 11)
local final_palette = shared_colors.colors_to_strings(generated_palette)

local colors = {
	BG       = final_palette[1] or M.default_colors.BG,      -- Dark background
	FG       = final_palette[8] or M.default_colors.FG,      -- Light foreground

	YELLOW   = final_palette[5] or M.default_colors.YELLOW,  -- Usually warm, often a bright accent
	CYAN     = final_palette[4] or M.default_colors.CYAN,    -- Blue-green tones work well here
	DARKBLUE = final_palette[6] or M.default_colors.DARKBLUE, -- A deeper blue, useful for UI highlights
	GREEN    = final_palette[11] or M.default_colors.GREEN,  -- Typically a calm green tone
	ORANGE   = final_palette[7] or M.default_colors.ORANGE,  -- Usually a warm accent color
	VIOLET   = final_palette[2] or M.default_colors.VIOLET,  -- Purple tones, can be prominent
	MAGENTA  = final_palette[3] or M.default_colors.MAGENTA, -- A strong, vivid shade
	BLUE     = final_palette[10] or M.default_colors.BLUE,   -- A more neutral or secondary blue
	RED      = final_palette[9] or M.default_colors.RED,     -- Generally for errors and warnings
}


local function get_mode_color()
	local mode_color = {
		n      = colors.DARKBLUE,
		i      = colors.VIOLET,
		v      = colors.RED,
		['']  = colors.BLUE,
		V      = colors.RED,
		c      = colors.MAGENTA,
		no     = colors.RED,
		s      = colors.ORANGE,
		S      = colors.ORANGE,
		['']  = colors.ORANGE,
		ic     = colors.YELLOW,
		R      = colors.ORANGE,
		Rv     = colors.ORANGE,
		cv     = colors.RED,
		ce     = colors.RED,
		r      = colors.CYAN,
		rm     = colors.CYAN,
		['r?'] = colors.CYAN,
		['!']  = colors.RED,
		t      = colors.RED,
	}
	return mode_color[vim.fn.mode()]
end

local function get_opposite_color(mode_color)
	local opposite_colors = {
		[colors.RED]      = colors.CYAN,
		[colors.BLUE]     = colors.ORANGE,
		[colors.GREEN]    = colors.MAGENTA,
		[colors.MAGENTA]  = colors.DARKBLUE,
		[colors.ORANGE]   = colors.BLUE,
		[colors.CYAN]     = colors.YELLOW,
		[colors.VIOLET]   = colors.GREEN,
		[colors.YELLOW]   = colors.RED,
		[colors.DARKBLUE] = colors.VIOLET,
	}
	return opposite_colors[mode_color] or colors.FG
end

local function get_animated_color(mode_color)
	local all_colors = {
		colors.RED,
		colors.BLUE,
		colors.GREEN,
		colors.MAGENTA,
		colors.ORANGE,
		colors.CYAN,
		colors.VIOLET,
		colors.YELLOW,
		colors.DARKBLUE
	}
	local possible_opposites = {}
	for _, color in ipairs(all_colors) do
		if color ~= mode_color then
			table.insert(possible_opposites, color)
		end
	end
	if #possible_opposites > 0 then
		local random_index = math.random(1, #possible_opposites)
		return possible_opposites[random_index]
	else
		return colors.FG
	end
end

local function interpolate_color(color1, color2, step)
	local blend = function(c1, c2, step)
		return math.floor(c1 + (c2 - c1) * step)
	end
	local r1, g1, b1 = tonumber(color1:sub(2, 3), 16), tonumber(color1:sub(4, 5), 16), tonumber(color1:sub(6, 7), 16)
	local r2, g2, b2 = tonumber(color2:sub(2, 3), 16), tonumber(color2:sub(4, 5), 16), tonumber(color2:sub(6, 7), 16)

	local r = blend(r1, r2, step)
	local g = blend(g1, g2, step)
	local b = blend(b1, b2, step)

	return string.format("#%02X%02X%02X", r, g, b)
end

local function get_middle_color()
	local color1 = get_mode_color()
	local color2 = get_opposite_color(color1)

	-- Return an interpolated color between the two based on a step factor (smooth transition)
	local color_step = 0.5 -- adjust this value (0.0 -> color1, 1.0 -> color2)
	return interpolate_color(color1, color2, color_step)
end


M.color = colors
M.get_mode_color = get_mode_color
M.get_opposite_color = get_opposite_color
M.get_middle_color = get_middle_color
M.get_animated_color = get_animated_color
M.interpolate_color = interpolate_color

return M
