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
-- Auto indent
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function()
--     local pos = vim.fn.getpos(".")
--     vim.cmd("normal gg=G")
--     vim.fn.setpos(".", pos)
--   end,
-- })
