return {
  "xiyaowong/transparent.nvim",
  lazy = true,
  config = function()
    require('transparent').setup({
    })
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*",
      command = "TransparentEnable",
    })
    -- vim.cmd([[hi StatusLine ctermbg=0 cterm=NONE]])
  end,
}
