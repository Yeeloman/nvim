return {
  {
    "dasupradyumna/midnight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('midnight').setup({
      })
      vim.cmd("colorscheme habamax")
    end,
  },
}
