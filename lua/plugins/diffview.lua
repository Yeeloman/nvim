local keymap = vim.keymap
local opt = { noremap = true, silent = true }
return {
  'sindrets/diffview.nvim',
  event = "VeryLazy",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keymap.set('n', '<leader>gvo', ":DiffviewOpen<CR>", opt),
  keymap.set('n', '<leader>gvc', ":DiffviewClose<CR>", opt),
  keymap.set('n', '<leader>gvh', ":DiffviewFileHistory<CR>", opt),
  -- keymap.set('n', '<leader>gvf', ":DiffviewToggleFiles<CR>", opt),
}
