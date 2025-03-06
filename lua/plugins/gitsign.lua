return {
	"lewis6991/gitsigns.nvim",
	event = "BufEnter",
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "│" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
		numhl = false,   -- Toggle with `:Gitsigns toggle_numhl`
		linehl = false,  -- Toggle with `:Gitsigns toggle_linehl`
		word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
		watch_gitdir = {
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 500,
			ignore_whitespace = false,
			virt_text_priority = 100,
			virt_text_fg = 'red',
		},
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil,
		max_file_length = 40000,
		preview_config = {
			border = "single",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
	},
	config = true,
	vim.keymap.set("n", "<leader>gP", ":Gitsigns preview_hunk<CR>", { noremap = true, silent = true }),
	vim.keymap.set("n", "<leader>gd", ":Gitsigns diffthis<CR>", { noremap = true, silent = true }),
	vim.keymap.set("n", "<leader>gx", ":Gitsigns toggle_linehl<CR>", { noremap = true, silent = true }),
}
