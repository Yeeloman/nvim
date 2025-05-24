return {
	"leath-dub/snipe.nvim",
	keys = {
		{
			'\\',
			function()
				require("snipe").open_buffer_menu()
			end,
			desc = "Open Snipe buffer menu",
		},
	},
	config = function()
		local snipe = require("snipe")
		snipe.setup({
			ui = {
				position = "center",   -- "topleft", "bottomleft", "topright", "bottomright", "center", "cursor"
				preselect_current = true,
				text_align = "file-first", -- right, left, file-first
				open_win_override = {
					title = "",
					border = "double", -- use "rounded" for rounded border
				},
			},
			hints = {
				dictionary = "asfghl;wertyuiop",
			},
			navigate = {
				cancel_snipe = "q",
				-- cancel_snipe = ["<esc>", "q"],

				-- Open buffer in vertical split
				open_vsplit = "V",

				-- Open buffer in split, based on `vim.opt.splitbelow`
				open_split = "H",

				close_buffer = "d",

				-- Change tag manually
				change_tag = "C",
			},
			sort = "default",
		})

		local paletteGen = require("shared.PaletteGen")

		local wal_colors = paletteGen.colors_to_strings(paletteGen.read_wal_colors())
		-- Customize highlight groups for Snipe
		vim.api.nvim_set_hl(0, "SnipeNormal", { fg = wal_colors[7], bg = wal_colors[1] })   -- Dark background with soft text color
		vim.api.nvim_set_hl(0, "SnipeBorder", { fg = wal_colors[3] })                       -- Keeping the border color as requested
		vim.api.nvim_set_hl(0, "SnipeCursorLine", { bg = wal_colors[4], fg = wal_colors[8] }) -- Brighter background for selection with good contrast
		vim.api.nvim_set_hl(0, "SnipeHint", { bg = wal_colors[6], fg = wal_colors[1] })
	end
}
