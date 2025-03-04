return {
	"chrisgrieser/nvim-lsp-endhints",
	event = "LspAttach",
	opts = {
		icons = {
			type = "󰜁 ",
			parameter = "󰏪 ",
			offspec = " ", -- hint kind not defined in official LSP spec
			unknown = " ", -- hint kind is nil
		},
		label = {
			truncateAtChars = 20,
			padding = 1,
			marginLeft = 0,
			sameKindSeparator = ", ",
		},
		extmark = {
			priority = 50,
		},
		autoEnableHints = true,
	}, -- required, even if empty
	config = function(_, opts)
		require("lsp-endhints").setup(opts)
		vim.keymap.set(
			"n",
			"<leader>ih",
			"<cmd>lua require('lsp-endhints').toggle()<CR>",
			{
				desc = "display type hints",
				noremap = true,
				silent = true,
			}
		)
	end
}
