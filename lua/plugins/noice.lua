-- if true then return {} end
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
      enabled = true,   -- Enable the command-line UI
      view = "cmdline", -- Use a popup style cmdline_popup
      format = {
        -- Default command-line icon
        cmdline = { icon = "   ", highlight = "NoiceCmdlineIcon" },
        -- Lua command icon
        lua = { icon = "   ", highlight = "NoiceCmdlineLua" },
        -- Shell command icon
        shell = { icon = "  ", highlight = "NoiceCmdlineShell" },
        -- Search command icon
        search_down = { icon = "󰶚  ", highlight = "NoiceCmdlineSearch" },
        search_up = { icon = "󰶚  ", highlight = "NoiceCmdlineSearch" },
        -- Filter command icon
        filter = { icon = "  ", highlight = "NoiceCmdlineFilter" },
        -- Help command icon
        help = { icon = "  ", highlight = "NoiceCmdlineHelp" },
      }
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
      -- Custom view for the cmdline
      cmdline = {
        border = {
          style = "double", -- Options: "none", "single", "double", "rounded", "solid"
          padding = { 1, 1 },
        },
        position = {
          row = "90%", -- Position from the top
          col = "50%", -- Center horizontally
        },
        size = {
          width = "60%",   -- Auto-adjust width
          height = "auto", -- Auto-adjust height
        },
        win_options = {
          winblend = 10,                                                        -- Transparency
          winhighlight = "NormalFloat:MyNormalFloat,FloatBorder:MyFloatBorder", -- Custom highlights
        },
      },
      popupmenu = {
        relative = "editor",
        position = {
          row = "70%",
          col = "50%",
        },
        size = {
          width = "40%",
          height = "30%",
        },
        border = {
          style = "double",
          padding = { 1, 2 },
        },
        win_options = {
          winblend = 10,
          -- winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
          winhighlight = "Normal:PopupNormal,FloatBorder:MyPopupBorder", -- Custom highlights
        },
      },
      cmdline_popup = {
        border = {
          style = "none", -- Options: "none", "single", "double", "rounded", "solid"
          padding = { 1, 1 },
        },
        position = {
          row = "15%",
          col = "50%",
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
  -- config = true,
  config = function(_, opts)
    require("noice").setup(opts)

    -- Define custom highlights
    local shared_colors = require("shared.colors")
    local wal_colors = shared_colors.read_wal_colors()
    vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = wal_colors[3] or "#d360aa", bold = true }) -- Default command-line icon

    -- Popup Menu Background Color
    -- vim.api.nvim_set_hl(0, "MyPopupNormal", { bg = wal_colors[1] or "#1e1e2e", fg = "#cdd6f4" })

    -- Popup Menu Border Color
    vim.api.nvim_set_hl(0, "MyPopupBorder", { fg = wal_colors[3] or "#f5e0dc", bold = true })
  end,
}
