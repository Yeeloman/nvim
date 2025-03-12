return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "LspAttach", -- Or `LspAttach`
	priority = 1000,    -- needs to be loaded in first
	opts = {
		-- Style preset for diagnostic messages
		-- Available options:
		-- "modern", "classic", "minimal", "powerline",
		-- "ghost", "simple", "nonerdfont", "amongus"
		preset = "modern",
		options = {
			multilines = {
				-- Enable multiline diagnostic messages
				enabled = true,

				-- Always show messages on all lines for multiline diagnostics
				always_show = false,
			},
			format = function(diagnostic)
				return " [ " .. diagnostic.message .. " ]"
			end
		},
	},
	config = function(_, opts)
		require('tiny-inline-diagnostic').setup(opts)
		vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
	end
}
