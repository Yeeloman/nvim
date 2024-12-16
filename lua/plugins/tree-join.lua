return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesj").setup({ use_default_keymaps = false })
    vim.keymap.set(
      "n",
      "<leader>m",
      ":lua require('treesj').toggle()<CR>",
      { noremap = true, silent = true }
    )
  end,
}
