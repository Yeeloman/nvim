local keymap = vim.keymap

return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local highlights = require("nord").bufferline.highlights({
      italic = true,
      bold = true,
      -- fill = "#181c24"
    })
    require("bufferline").setup({
      options = {
        indicator = {
          icon = "▎",
          style = "underline",
        },
        separator_style = "thick",
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            padding = 5,
          },
        },
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
      },
      highlights = highlights,
      -- highlights = {
      --   buffer_selected = {
      --     underline = false,
      --     italic = true,
      --     bg = "#2d1216",
      --     fg = "#D05A67",
      --     sp = "#7DB78C",
      --   },
      -- },
    })

    keymap.set("n", "<leader>ba", ":BufferLinePick<CR>")
    keymap.set("i", "<C-b>", "<C-o>:BufferLinePick<CR>")
  end,
}
