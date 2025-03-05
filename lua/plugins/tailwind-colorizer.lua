return {
	"roobert/tailwindcss-colorizer-cmp.nvim",
	-- optionally, override the default options:
	config = function()
		require("tailwindcss-colorizer-cmp").setup({
			color_square_width = 2,
		})
		local cmp = require("cmp")
		local tailwindcss_colorizer_cmp = require("tailwindcss-colorizer-cmp").formatter

		cmp.setup({
			formatting = {
				format = function(entry, item)
					item = tailwindcss_colorizer_cmp(entry, item)
					return item
				end,
			},
		})
	end
}
