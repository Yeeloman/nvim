return {
	"smjonas/inc-rename.nvim",
	opts = {
	},
	config = function(_, opts)
		require("inc_rename").setup(opts)
		-- vim.keymap.set("n", "<leader>rn", function()
		-- 	return ":IncRename " .. vim.fn.expand("<cword>")
		-- end, {
		-- 	expr = true,
		-- 	noremap = true,
		-- 	silent = true,
		-- 	desc = "Rename variable under cursor"
		-- })
		vim.keymap.set(
			"n",
			"<leader>rn",
			":IncRename ",
			{
				noremap = true,
				silent = true,
				desc = "Rename variable under cursor"
			}
		)
	end,
}
