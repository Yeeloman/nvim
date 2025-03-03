return {
	"roobert/action-hints.nvim",
	config = function()
		local pg = require("shared.PaletteGen")
		local colors = pg.colors_to_strings(pg.read_wal_colors())
		require("action-hints").setup({
			template = {
				definition = { text = " 󱌃 ", color = colors[3] or "#add8e6" },
				references = { text = " 󰤘 %s", color = colors[7] or "#ff6666" },
			},
			use_virtual_text = true,
		})
	end,
}
