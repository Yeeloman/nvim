return {
  "ggandor/leap.nvim",
  lazy = false,
  config = function()
    require('leap').create_default_mappings()
    vim.api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
    vim.api.nvim_set_hl(0, 'LeapMatch', {
      fg = 'white', bold = true, nocombine = true,
    })
  end,
}
