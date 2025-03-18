M = {}

-- Default Theme Colors: Define a set of base colors for your theme
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

-- Load additional colors from external source (like Wal colors)
local shared_colors = require("shared.PaletteGen")                       -- Import the PaletteGen module
local wal_colors = shared_colors.read_wal_colors()                       -- Read colors generated by Wal
local generated_palette = shared_colors.generate_palette(wal_colors, 11) -- Generate a palette from Wal colors
local final_palette = shared_colors.colors_to_strings(generated_palette) -- Convert colors to strings for usage

-- Final theme colors: Set the theme colors by either using the generated palette or default colors
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

-- Function to get the color associated with the current mode in Vim
local function get_mode_color()
	-- Define a table mapping modes to their associated colors
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
	-- Return the opposite color, or fallback to foreground color
	return mode_color[vim.fn.mode()]
end

-- Function to get the opposite color of a given mode color
local function get_opposite_color(mode_color)
	-- Define a table mapping colors to their opposite color
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
	-- Return the opposite color, or fallback to foreground color
	return opposite_colors[mode_color] or colors.FG
end

-- Function to get an animated color (randomly chosen from available colors)
local function get_animated_color(mode_color)
	-- Define a list of all available colors
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
	-- Create a list of possible opposite colors (excluding the current mode color)
	local possible_opposites = {}
	for _, color in ipairs(all_colors) do
		if color ~= mode_color then
			table.insert(possible_opposites, color)
		end
	end
	-- Randomly select an opposite color
	if #possible_opposites > 0 then
		local random_index = math.random(1, #possible_opposites)
		return possible_opposites[random_index]
	else
		return colors.FG -- Default to foreground color if no opposite found
	end
end

-- Function to interpolate between two colors for a smooth transition
local function interpolate_color(color1, color2, step)
	-- Blend two colors based on the given step factor (0.0 -> color1, 1.0 -> color2)
	local blend = function(c1, c2, step)
		return math.floor(c1 + (c2 - c1) * step)
	end
	-- Extract the RGB values of both colors (in hex)
	local r1, g1, b1 = tonumber(color1:sub(2, 3), 16), tonumber(color1:sub(4, 5), 16), tonumber(color1:sub(6, 7), 16)
	local r2, g2, b2 = tonumber(color2:sub(2, 3), 16), tonumber(color2:sub(4, 5), 16), tonumber(color2:sub(6, 7), 16)

	-- Calculate the new RGB values for the blended color
	local r = blend(r1, r2, step)
	local g = blend(g1, g2, step)
	local b = blend(b1, b2, step)

	-- Return the blended color in hex format
	return string.format("#%02X%02X%02X", r, g, b)
end

-- Function to get a middle color by interpolating between mode color and its opposite
local function get_middle_color(color_step)
	-- Set default value for color_step if not provided
	color_step = color_step or 0.5           -- If color_step is nil, default to 0.5

	local color1 = get_mode_color()          -- Get the current mode color
	local color2 = get_opposite_color(color1) -- Get the opposite color

	-- Return an interpolated color between the two (based on the color_step value)
	return interpolate_color(color1, color2, color_step)
end

-- Expose the color functions and color palette to other modules
M.color = colors
M.get_mode_color = get_mode_color
M.get_opposite_color = get_opposite_color
M.get_middle_color = get_middle_color
M.get_animated_color = get_animated_color
M.interpolate_color = interpolate_color

return M
