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


-- Auto indent
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local pos = vim.fn.getpos(".")
    vim.cmd("normal gg=G")
    vim.fn.setpos(".", pos)
  end,
})
