return {
	'linux-cultist/venv-selector.nvim',
	dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
	opts = {
		stay_on_this_version = true,
		name = {
			"env",
			"venv",
			".env",
			".venv",
			"virtualenv",
		},
		-- auto_refresh = false
	},
	event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
	keys = {
		-- Keymap to open VenvSelector to pick a venv.
		{
			'<leader>ve',
			'<cmd>VenvSelect<cr>'
		},
		-- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
		{
			'<leader>vc',
			'<cmd>VenvSelectCached<cr>'
		},
	},
}
