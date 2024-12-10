local keymap = vim.keymap

return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require("bufferline").setup({})

    keymap.set("n", "<leader>ba", ":BufferLinePick<CR>")
    keymap.set("i", "<C-b>", "<C-o>:BufferLinePick<CR>")
  end,
}
