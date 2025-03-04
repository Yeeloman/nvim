return {
	"stevanmilic/nvim-lspimport",
	opts = {},
	config = function(_, opts)
		vim.keymap.set("n", "<leader>a", require("lspimport").import, { noremap = true, desc = "auto import" })
	end
}
