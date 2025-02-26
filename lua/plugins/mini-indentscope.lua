return {
  "echasnovski/mini.indentscope",
  lazy = false,
  config = function()
    require("mini.indentscope").setup({
      draw = { delay = 500 }, -- No delay in rendering
      symbol = "┃", -- ┃ ╎ Customize the indent guide symbol
      options = { try_as_border = true },
    })
    local pg = require("shared.PaletteGen")
    local colors = pg.colors_to_strings(pg.read_wal_colors())
    vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = colors[5] or "#FF0000", nocombine = true })
  end
}
