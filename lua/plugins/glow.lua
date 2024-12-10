return {
  "ellisonleao/glow.nvim",
  event = "VeryLazy",
  config = function()
    require("glow").setup({
      style = "dark",  -- You can set this to 'light' or 'dark' based on preference
      width = 120,     -- Adjust width of the preview window
      height = 50,     -- Adjust height of the preview window
    })  -- Optional: add any custom configuration here
  end
}
