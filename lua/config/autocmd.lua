-- get the colors as a table
local pg = require("shared.PaletteGen")
local colors = pg.colors_to_strings(pg.read_wal_colors())

vim.api.nvim_exec(
	[[
  augroup MyCursorShapes
    autocmd!
    autocmd InsertEnter * set guicursor=n-v-c:ver25,i-ci-ve:ver25
    autocmd InsertLeave * set guicursor=n-v-c:block,i-ci-ve:block
    autocmd VimLeave * set guicursor=n-v-c:block,i-ci-ve:block
  augroup END
]],
	false
)
-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*" },
	callback = function()
		vim.api.nvim_exec('silent! normal! g`"zv', false)
	end,
})

-- style the indent color
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = colors[5] or "#FF0000", nocombine = true })
	end,
})

-- Highlight Yanked text
vim.api.nvim_create_augroup('highlight_yank', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	group = 'highlight_yank',
	pattern = '*',
	callback = function()
		vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 300 })
	end
})


-- Open mini-files if nvim is opened with a dir as an argument
-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		local arg = vim.fn.argv(0)        -- Get the first argument passed to nvim
-- 		if arg and vim.fn.isdirectory(arg) == 1 then
-- 			require("mini.files").open(arg) -- Open mini.files in the given directory
-- 		end
-- 	end,
-- })
