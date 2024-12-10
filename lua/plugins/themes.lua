return {
  -- { 
  --   "sekke276/dark_flat.nvim",
  --   config = function()
  --     require("dark_flat").setup({
  --       transparent = true,
  --       colors = {},
  --       themes = function(colors)
  --         return {}
  --       end,
  --       italics = true,
  --     })
  --   end,
  -- },
  {
    "dasupradyumna/midnight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('midnight').setup({
      })
      vim.cmd("colorscheme midnight")
    end,
  },
}
