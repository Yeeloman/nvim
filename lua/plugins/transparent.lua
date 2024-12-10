return {
  "xiyaowong/transparent.nvim",
  lazy = true,
  config = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*",
      command = "TransparentEnable",
    })
    vim.cmd([[hi StatusLine ctermbg=0 cterm=NONE]])
  end,
}
