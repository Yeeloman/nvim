return {
  'AckslD/muren.nvim',
  event = "VeryLazy",
  config = true,
  vim.keymap.set(
    'n',
    '<leader>rv',
    ':MurenToggle<CR>',
    {}
  ),
}
