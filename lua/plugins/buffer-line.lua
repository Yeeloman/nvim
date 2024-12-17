
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
        mode = 'buffers',
        indicator = {
          icon = " ⧐ ", -- ⇛ 
          style = "icon",
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
        buffer_close_icon = "❂", --  ✺ 
        modified_icon = "⨮", -- ●
        close_icon = "✺",
        left_trunc_marker = "⭅",
        right_trunc_marker = "⭆",
        max_name_length = 30,
        max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
        tab_size = 21,
        diagnostics = false,
        diagnostics_update_in_insert = false,
        minimum_padding = 1,
        maximum_padding = 5,
        maximum_length = 15,
        enforce_regular_tabs = true,

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

    local keymap = vim.keymap
    keymap.set("n", "<leader>ba", ":BufferLinePick<CR>")
    keymap.set("i", "<C-b>", "<C-o>:BufferLinePick<CR>")
  end,
}
