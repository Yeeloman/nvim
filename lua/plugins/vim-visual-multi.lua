return {
	"mg979/vim-visual-multi",
	branch = "master",
	init = function()
		vim.g.VM_default_mappings = 1

		vim.g.VM_maps = {
			["Find Under"]         = "<leader>rm",
			["Find Subword Under"] = "<leader>rm",
		}
	end,
	config = function()
	end,
}
