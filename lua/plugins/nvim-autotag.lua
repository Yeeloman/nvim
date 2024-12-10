return {
  "windwp/nvim-ts-autotag",
  lazy = false,
  config = function()
    require('nvim-ts-autotag').setup({
      aliases = {
        ["svelte"] = "html",
        ["django"] = "html",
      },
    })
  end,
}
