return -- lazy.nvim
{
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    cmdline = {
      enabled = true, -- Enable the command-line UI
      view = "cmdline_popup", -- Use a popup style cmdline_popup
      format = {
        cmdline = { icon = " " }, -- Customize the command-line icon
      },
    },
    messages = {
      enabled = true, -- Enable messages (e.g., `:messages`)
      view = "mini",  -- Use a minimal style for messages
    },
    popupmenu = {
      enabled = true,                                           -- Enable the popup menu UI
      backend = "nui",                                          -- Use `nui` for popup UI
      win_options = {
        winblend = 10,                                          -- Add transparency
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder", -- Highlighting
      },
    },
    views = {
      cmdline_popup = {
        border = {
          style = "none", -- Options: "none", "single", "double", "rounded", "solid"
          padding = { 1, 1 },
        },
        position = {
          row = "15%",
          col = "90%",
        },
        size = {
          width = "auto",
          height = "auto",
        },
        win_options = {
          winblend = 10,
          winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        },
      },
    },
    lsp = {
      progress = {
        enabled = true, -- Show LSP progress in the UI
        view = "mini",  -- Minimal style for LSP progress
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      bottom_search = true,         -- Use a bottom search bar like in IDEs
      command_palette = false,      -- Disable the command palette preset
      long_message_to_split = true, -- Split long messages into a separate buffer
    },
    routes = {
      {
        filter = { event = "msg_show", kind = "search_count" },
        view = "mini",
      },
    },
  },
  config = true,
}
