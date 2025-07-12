return {
	"leon-richardt/comment-highlights.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	lazy = true,
	opts = {},
	cmd = "CHToggle",
	keys = {
		{
			"<leader>cc",
			function() require("comment-highlights").toggle() end,
			desc = "Toggle comment highlighting"
		},
	},
}
