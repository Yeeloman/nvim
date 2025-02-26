return {
  "echasnovski/mini.indentscope",
  lazy = false,
  config = function()
    require("mini.indentscope").setup({
      draw = { delay = 500 }, -- No delay in rendering
      symbol = "┃", -- ┃ ╎ Customize the indent guide symbol
      options = { try_as_border = true },
    })
  end
}
