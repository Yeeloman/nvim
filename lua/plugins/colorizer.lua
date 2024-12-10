return {
  "chrisbra/Colorizer",
  lazy = false,
  config = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*",
      command = "ColorHighlight",
    })
    vim.keymap.set("n", "<leader>co", ":ColorToggle<CR>", { noremap = true, silent = true })
  end,
}
