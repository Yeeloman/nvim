return {
  "leath-dub/snipe.nvim",
  keys = {
    {
      "<S-l>",
      function()
        require("snipe").open_buffer_menu()
      end,
      desc = "Open Snipe buffer menu",
    },
  },
  config = function()
    local snipe = require("snipe")
    snipe.setup({
      ui = {
        position = "center", -- "topleft", "bottomleft", "topright", "bottomright", "center", "cursor"
        preselect_current = true,
        text_align = "file-first",
      },
      hints = {
        dictionary = "asfghl;wertyuiop",
      },
      navigate = {
        cancel_snipe = "q",
        -- cancel_snipe = ["<esc>", "q"],

        -- Open buffer in vertical split
        open_vsplit = "V",

        -- Open buffer in split, based on `vim.opt.splitbelow`
        open_split = "H",

        -- close_buffer = "d",
      },
      sort = "default",
    })
  end,
}
