local pg = require("shared.PaletteGen")
local colors = pg.colors_to_strings(pg.read_wal_colors())
return {
	'Bekaboo/deadcolumn.nvim',
	opts = {
		scope = 'line', ---@type string|fun(): integer
		---@type string[]|boolean|fun(mode: string): boolean
		modes = function(mode)
			return mode:find('^[iRss\x13]') ~= nil
		end,

		blending = {
			threshold = 0.5,
			colorcode = colors[5] or '#000000',
			hlgroup = { 'Normal', 'bg' },
		},
		warning = {
			alpha = 0.4,
			offset = 0,
			colorcode = colors[3] or "#ff6666",
			hlgroup = { 'Error', 'bg' },
		},
		extra = {
			---@type string?
			follow_tw = nil,
		},
	},
	config = function(_, opts)
		require('deadcolumn').setup(opts)
	end
}
