local api = vim.api
return {
	"max397574/better-escape.nvim",
	event = "VeryLazy",
	opts = {
		default_mappings = false,
		mappings = {
			i = {
				j = {
					j = function()
						api.nvim_input("<esc>")
						local current_line = api.nvim_get_current_line()
						if current_line:match("^%s+j$") then
							vim.schedule(function()
								api.nvim_set_current_line("")
							end)
						end
					end
				},
			}
		},
	},
	config = true,
}
