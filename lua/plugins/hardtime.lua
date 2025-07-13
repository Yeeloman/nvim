return {
	"m4xshen/hardtime.nvim",
	lazy = false,
	dependencies = { "MunifTanjim/nui.nvim" },
	opts = {
		disabled_keys = {
			["<Up>"] = false, -- Allow <Up> key
			["<Down>"] = false, -- Allow <Up> key
			["<Left>"] = false, -- Allow <Up> key
			["<Right>"] = false, -- Allow <Up> key
		},
	},
}
