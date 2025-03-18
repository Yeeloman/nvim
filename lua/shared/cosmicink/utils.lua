M = {}

local ink_colors = require("shared.cosmicink.colors")
-- Random icons
math.randomseed(os.time())
M.icon_sets = {
	stars = { '★', '☆', '✧', '✦', '✶', '✷', '✸', '✹' },
	runes = { '✠', '⛧', '𖤐', 'ᛟ', 'ᚨ', 'ᚱ', 'ᚷ', 'ᚠ', 'ᛉ', 'ᛊ', 'ᛏ', '☠', '☾', '♰', '✟', '☽', '⚚', '🜏' },
	hearts = { '❤', '♥', '♡', '❦', '❧' },
	waves = { '≈', '∿', '≋', '≀', '⌀', '≣', '⌇' },
	crosses = { '☨', '✟', '♰', '♱', '⛨', "" },
}

M.get_random_icon = function(icons)
	return icons[math.random(#icons)]
end

-- Shuffle table
M.shuffle_table = function(tbl)
	local n = #tbl
	while n > 1 do
		local k = math.random(n)
		tbl[n], tbl[k] = tbl[k], tbl[n]
		n = n - 1
	end
end

M.icon_sets_list = {}
for _, icons in pairs(M.icon_sets) do
	table.insert(M.icon_sets_list, icons)
end
M.shuffle_table(M.icon_sets_list)

-- Reverse table
M.reverse_table = function(tbl)
	local reversed = {}
	for i = #tbl, 1, -1 do
		table.insert(reversed, tbl[i])
	end
	return reversed
end

M.reversed_icon_sets = M.reverse_table(M.icon_sets_list)


M.create_separator = function(side, use_mode_color)
	return {
		function()
			return side == 'left' and '' or ''
		end,
		color = function()
			local color = use_mode_color and ink_colors.get_mode_color() or
					ink_colors.get_opposite_color(ink_colors.get_mode_color())
			return {
				fg = color,
			}
		end,
		padding = {
			left = 0,
		},
	}
end

M.create_mode_based_component = function(content, icon, color_fg, color_bg)
	return {
		content,
		icon = icon,
		color = function()
			local mode_color = ink_colors.get_mode_color()
			local opposite_color = ink_colors.get_opposite_color(mode_color)
			return {
				fg = color_fg or ink_colors.color.FG,
				bg = color_bg or opposite_color,
				gui = 'bold',
			}
		end,
	}
end

-- Mode indicator
M.mode = function()
	local mode_map = {
		n = 'N',
		i = 'I',
		v = 'V',
		[''] = 'V',
		V = 'V',
		c = 'C',
		no = 'N',
		s = 'S',
		S = 'S',
		ic = 'I',
		R = 'R',
		Rv = 'R',
		cv = 'C',
		ce = 'C',
		r = 'R',
		rm = 'M',
		['r?'] = '?',
		['!'] = '!',
		t = 'T',
	}
	return mode_map[vim.fn.mode()] or "[UNKNOWN]"
end

return M
