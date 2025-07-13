if true then return {} end
return {
	'stonelasley/flare.nvim',
	lazy = false,
	opts = {
		enabled = true,       -- disable highlighting
		hl_group = "IncSearch", -- set highlight group used for highlight
		x_threshold = 10,     -- column changes greater than this number trigger highlight
		y_threshold = 5,      -- row changes greater than this number trigger highlight
		expanse = 20,         -- highlight will expand to the left and right of cursor up to this amount (depending on space available)
		file_ignore = {       -- suppress highlighting for files of this type
			"NvimTree",
			"fugitive",
			"TelescopePrompt",
			"TelescopeResult",
		},
		fade = true,     -- if false will flash highlight for entire area similar to 'vim.highlight.on_yank'
		underline = false, -- if true will use more subtle underline highlight. Underline highlight can also be accomplished by setting hl_group
		timeout = 150,   -- timeout delay
	},
	config = true,
}
