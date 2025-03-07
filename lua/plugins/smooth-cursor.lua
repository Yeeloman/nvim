if true then return {} end
return {
  'gen740/SmoothCursor.nvim',
  lazy = false,
  config = function()
    require('smoothcursor').setup({
      type = "matrix", -- Cursor movement calculation method, choose "default", "exp" (exponential) or "matrix".

      cursor = "", -- Cursor shape (requires Nerd Font). Disabled in fancy mode.
      texthl = "SmoothCursor", -- Highlight group. Default is { bg = nil, fg = "#FFD400" }. Disabled in fancy mode.
      linehl = nil, -- Highlights the line under the cursor, similar to 'cursorline'. "CursorLine" is recommended. Disabled in fancy mode.


      matrix = { -- Loaded when 'type' is set to "matrix"
        head = {
          -- Picks a random character from this list for the cursor text
          cursor = require('smoothcursor.matrix_chars'),
          -- Picks a random highlight from this list for the cursor text
          texthl = {
            'SmoothCursor',
          },
          linehl = nil, -- No line highlight for the head
        },
        body = {
          length = 6, -- Specifies the length of the cursor body
          -- Picks a random character from this list for the cursor body text
          cursor = require('smoothcursor.matrix_chars'),
          -- Picks a random highlight from this list for each segment of the cursor body
          texthl = {
            'SmoothCursorGreen',
          },
        },
        tail = {
          -- Picks a random character from this list for the cursor tail (if any)
          cursor = nil,
          -- Picks a random highlight from this list for the cursor tail
          texthl = {
            'SmoothCursor',
          },
        },
        unstop = true, -- Determines if the cursor should stop or not (false means it will stop)
      },

      autostart = true,         -- Automatically start SmoothCursor
      always_redraw = true,     -- Redraw the screen on each update
      flyin_effect = nil,       -- Choose "bottom" or "top" for flying effect
      speed = 20,               -- Max speed is 100 to stick with your current position
      intervals = 35,           -- Update intervals in milliseconds
      priority = 10,            -- Set marker priority
      timeout = 8000,           -- Timeout for animations in milliseconds
      threshold = 3,            -- Animate only if cursor moves more than this many lines
      disable_float_win = true, -- Disable in floating windows
      enabled_filetypes = nil,  -- Enable only for specific file types, e.g., { "lua", "vim" }
      disabled_filetypes = nil, -- Disable for these file types, ignored if enabled_filetypes is set. e.g., { "TelescopePrompt", "NvimTree" }
    })
  end,
}
