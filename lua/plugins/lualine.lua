return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = function()
		local cosmicink = require("shared.cosmicink.config")

		require('lualine').setup(cosmicink.cfg)
	end,
}
