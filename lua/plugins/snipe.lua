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
        position = "center",       -- "topleft", "bottomleft", "topright", "bottomright", "center", "cursor"
        preselect_current = true,
        text_align = "file-first", -- right, left, file-first
        open_win_override = {
          title = "Switch",
          border = "double", -- use "rounded" for rounded border
        },
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

    -- Customize highlight groups for Snipe
    vim.api.nvim_set_hl(0, "SnipeNormal", { bg = "#1e1e2e", fg = "#cdd6f4" })     -- Background and text color
    vim.api.nvim_set_hl(0, "SnipeBorder", { bg = "#1e1e2e", fg = "#89b4fa" })     -- Border color
    vim.api.nvim_set_hl(0, "SnipeCursorLine", { bg = "#313244", fg = "#cdd6f4" }) -- Highlight for selected item
    vim.api.nvim_set_hl(0, "SnipeHint", { bg = "#1e1e2e", fg = "#f38ba8" })       -- Hint text color
  end,
}
