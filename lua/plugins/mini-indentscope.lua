return {
	"echasnovski/mini.indentscope",
	lazy = false,
	opts = {
		draw = { delay = 500 }, -- Set delay for rendering
		symbol = "┃", -- Customize indent guide symbol
		options = { try_as_border = true },
	},
	config = function(_, opts)
		local indentscope = require("mini.indentscope")

		indentscope.setup(opts)

		-- Disable the plugin in terminal mode
		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "*",
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})
	end
}
