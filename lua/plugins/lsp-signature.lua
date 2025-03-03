-- https://github.com/ray-x/lsp_signature.nvim
return {
	"ray-x/lsp_signature.nvim",
	event = "InsertEnter",
	opts = {
		bind = true,
		handler_opts = {
			border = "rounded"
		}
	},
}
