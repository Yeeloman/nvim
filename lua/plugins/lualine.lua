return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  config = function()
    -- theme colors
    local default_colors = {
      bg       = '#16181b', -- Dark background
      fg       = '#c5c4c4', -- Light foreground for contrast
      yellow   = '#e8b75f', -- Vibrant yellow
      cyan     = '#00bcd4', -- Soft cyan
      darkblue = '#2b3e50', -- Deep blue
      green    = '#00e676', -- Bright green
      orange   = '#ff7733', -- Warm orange
      violet   = '#7a3ba8', -- Strong violet
      magenta  = '#d360aa', -- Deep magenta
      blue     = '#4f9cff', -- Light-medium blue
      red      = '#ff3344', -- Strong red
    }

    local shared_colors = require("shared.colors")
    local wal_colors = shared_colors.read_wal_colors()

    local colors = {
      bg       = wal_colors[1] or default_colors.bg, -- Dark background
      fg       = wal_colors[8] or default_colors.fg, -- Light foreground for contrast

      -- Assigning colors while ensuring contrast and avoiding duplications
      yellow   = wal_colors[3] or default_colors.yellow,   -- Stronger, vibrant color
      cyan     = wal_colors[6] or default_colors.cyan,     -- Softer cyan tone
      darkblue = wal_colors[2] or default_colors.darkblue, -- Strong deep blue
      green    = wal_colors[4] or default_colors.green,    -- Muted green/yellow mix for balance
      orange   = wal_colors[7] or default_colors.orange,   -- Softer orange tone
      violet   = wal_colors[5] or default_colors.violet,   -- Strong violet/purple tone
      magenta  = wal_colors[10] or default_colors.magenta, -- Deep magenta/red mix
      blue     = wal_colors[12] or default_colors.blue,    -- Light-medium blue for balance
      red      = wal_colors[9] or default_colors.red,      -- Strong red
    }

    local function luminance(color)
      local r, g, b = color:match("#(%x%x)(%x%x)(%x%x)")
      r, g, b = tonumber(r, 16) / 255, tonumber(g, 16) / 255, tonumber(b, 16) / 255
      return 0.2126 * r + 0.7152 * g + 0.0722 * b
    end

    local function adjust_color(color, factor)
      local r, g, b = color:match("#(%x%x)(%x%x)(%x%x)")
      r, g, b = tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)

      -- Increase brightness if too dark, decrease if too bright
      r = math.min(math.max(r * factor, 0), 255)
      g = math.min(math.max(g * factor, 0), 255)
      b = math.min(math.max(b * factor, 0), 255)

      return string.format("#%02x%02x%02x", r, g, b)
    end

    local function ensure_contrast(color, default)
      local contrast = luminance(color) - luminance(colors.bg)
      if contrast < 0.3 then          -- Use a better contrast ratio
        return adjust_color(color, 1) -- Adjust brightness
      end
      return color
    end

    for key, default_color in pairs(default_colors) do
      colors[key] = ensure_contrast(colors[key], default_color)
    end

    local function get_mode_color()
      local mode_color = {
        n = colors.darkblue,
        i = colors.violet,
        v = colors.red,
        [''] = colors.blue,
        V = colors.red,
        c = colors.magenta,
        no = colors.red,
        s = colors.orange,
        S = colors.orange,
        [''] = colors.orange,
        ic = colors.yellow,
        R = colors.orange,
        Rv = colors.orange,
        cv = colors.red,
        ce = colors.red,
        r = colors.cyan,
        rm = colors.cyan,
        ['r?'] = colors.cyan,
        ['!'] = colors.red,
        t = colors.red,
      }
      return mode_color[vim.fn.mode()]
    end

    local function get_opposite_color(mode_color)
      -- Define a mapping of mode colors to their opposites (randomized)
      local opposite_colors = {
        [colors.red] = colors.cyan,
        [colors.blue] = colors.orange,
        [colors.green] = colors.magenta,
        [colors.magenta] = colors.darkblue,
        [colors.orange] = colors.blue,
        [colors.cyan] = colors.yellow,
        [colors.violet] = colors.green,
        [colors.yellow] = colors.red,
        [colors.darkblue] = colors.violet,
      }
      return opposite_colors[mode_color] or colors.fg -- Default to fg if no opposite is found
    end

    local function get_animated_color(mode_color)
      -- List of all available colors (assuming these are the colors you're working with)
      local all_colors = {
        colors.red, colors.blue, colors.green, colors.magenta,
        colors.orange, colors.cyan, colors.violet, colors.yellow,
        colors.darkblue
      }

      -- Remove the input color from the list to ensure the opposite is different
      local possible_opposites = {}
      for _, color in ipairs(all_colors) do
        if color ~= mode_color then
          table.insert(possible_opposites, color)
        end
      end

      -- Randomly select an opposite color from the remaining options
      if #possible_opposites > 0 then
        local random_index = math.random(1, #possible_opposites)
        return possible_opposites[random_index]
      else
        -- If no opposite is found (unlikely), return a default color
        return colors.fg
      end
    end

    -- checks the conditions
    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- Logic for random icons
    math.randomseed(12345)
    local icon_sets = {
      stars = { '★', '☆', '✧', '✦', '✶', '✷', '✸', '✹' },
      runes = { '✠', '⛧', '𖤐', 'ᛟ', 'ᚨ', 'ᚱ', 'ᚷ', 'ᚠ', 'ᛉ', 'ᛊ', 'ᛏ', '☠', '☾', '♰', '✟', '☽', '⚚', '🜏' },
      hearts = { '❤', '♥', '♡', '❦', '❧' },
      waves = { '≈', '∿', '≋', '≀', '⌀', '≣', '⌇' },
      crosses = { '☨', '✟', '♰', '♱', '⛨', "", },
    }

    local function get_random_icon(icons)
      return icons[math.random(#icons)]
    end

    -- Function to shuffle a table
    local function shuffle_table(tbl)
      local n = #tbl
      while n > 1 do
        local k = math.random(n)
        tbl[n], tbl[k] = tbl[k], tbl[n]
        n = n - 1
      end
    end

    -- Create a list of icon sets to shuffle
    local icon_sets_list = {}

    for _, icons in pairs(icon_sets) do
      table.insert(icon_sets_list, icons)
    end

    -- Shuffle the icon sets order
    shuffle_table(icon_sets_list)

    -- Function to reverse the table
    local function reverse_table(tbl)
      local reversed = {}
      for i = #tbl, 1, -1 do
        table.insert(reversed, tbl[i])
      end
      return reversed
    end

    -- Reverse the shuffled icon_sets_list
    local reversed_icon_sets = reverse_table(icon_sets_list)

    -- configs
    local config = {
      options = {
        component_separators = '',                               -- No separators between components
        section_separators = '',                                 -- No separators between sections
        theme = {
          normal = { c = { fg = colors.fg, bg = colors.bg } },   -- Active statusline colors
          inactive = { c = { fg = colors.bg, bg = colors.fg } }, -- Inactive statusline colors
        },
      },
      sections = {
        lualine_a = {}, -- Leftmost section
        lualine_b = {}, -- Left section
        lualine_c = {}, -- Middle-left section
        lualine_x = {}, -- Middle-right section
        lualine_y = {}, -- Right section
        lualine_z = {}, -- Rightmost section
      },
      inactive_sections = {
        lualine_a = {}, -- Inactive leftmost section
        lualine_b = {}, -- Inactive left section
        lualine_c = {}, -- Inactive middle-left section
        lualine_x = {}, -- Inactive middle-right section
        lualine_y = {}, -- Inactive right section
        lualine_z = {}, -- Inactive rightmost section
      },
    }

    -- function to insert to the left in the status line
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- function to insert to the right in the status line
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    -- Helper function to create a separator component
    local function create_separator(side, use_mode_color)
      return {
        function()
          return side == 'left' and '' or ''
        end,
        color = function()
          local color = use_mode_color and get_mode_color() or get_opposite_color(get_mode_color())
          return { fg = color }
        end,
        padding = { left = 0 },
      }
    end

    -- Helper function to create a component with mode-based colors
    local function create_mode_based_component(content, icon, color_fg, color_bg)
      return {
        content,
        icon = icon,
        color = function()
          local mode_color = get_mode_color()
          local opposite_color = get_opposite_color(mode_color)
          return {
            fg = color_fg or colors.bg,
            bg = color_bg or opposite_color,
            gui = 'bold',
          }
        end,
      }
    end

    -- Mode indicator function
    local function mode()
      local mode_map = {
        n = 'N',      -- Normal Mode
        i = 'I',      -- Insert Mode
        v = 'V',      -- Visual Mode
        [''] = 'V',  -- Visual Block Mode
        V = 'V',      -- Visual Line Mode
        c = 'C',      -- Command Mode
        no = 'N',     -- Operator-pending Mode
        s = 'S',      -- Select Mode
        S = 'S',      -- Select Mode
        ic = 'I',     -- Insert Mode (Completion)
        R = 'R',      -- Replace Mode
        Rv = 'R',     -- Virtual Replace Mode
        cv = 'C',     -- Command Mode
        ce = 'C',     -- Command Mode
        r = 'R',      -- Hit-enter Mode
        rm = 'M',     -- More Mode
        ['r?'] = '?', -- Prompt Mode
        ['!'] = '!',  -- Shell Mode
        t = 'T',      -- Terminal Mode
        -- n = "NORMAL",
        -- i = "INSERT",
        -- v = "VISUAL",
        -- [''] = "V-BLOCK",
        -- V = "V-LINE",
        -- c = "COMMAND",
        -- no = "N-OPERATOR",
        -- s = "SELECT",
        -- S = "S-LINE",
        -- [''] = "S-BLOCK",
        -- ic = "INSERT COMPL",
        -- R = "REPLACE",
        -- Rv = "V-REPLACE",
        -- cv = "COMMAND",
        -- ce = "COMMAND",
        -- r = "PROMPT",
        -- rm = "MORE",
        -- ['r?'] = "CONFIRM",
        -- ['!'] = "SHELL",
        -- t = "TERMINAL",
      }
      return mode_map[vim.fn.mode()] or "[UNKNOWN]"
    end

    -- LEFT
    ins_left {
      mode,
      color = function()
        local mode_color = get_mode_color()
        return { fg = colors.bg, bg = mode_color, gui = 'bold' }
      end,
      padding = { left = 1, right = 1 },
    }

    ins_left(create_separator('left', true))

    ins_left {
      function()
        return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
      end,
      icon = ' ',
      color = function()
        -- Check if a virtual environment is active by looking for the VIRTUAL_ENV environment variable
        local virtual_env = vim.env.VIRTUAL_ENV
        if virtual_env then
          return { fg = get_animated_color(), gui = 'bold' }
        else
          return { fg = get_mode_color(), gui = 'bold' }
        end
      end,
    }

    -- Right separator
    ins_left(create_separator('right'))

    ins_left(create_mode_based_component('filename', nil, colors.bg))

    ins_left(create_separator('left'))

    ins_left {
      function()
        return '' -- 󱎶
      end,
      color = function()
        return { fg = get_mode_color() }
      end,
      cond = conditions.hide_in_width,
    }

    --
    ins_left {
      function()
        local git_status = vim.b.gitsigns_status_dict
        if git_status then
          return string.format(
            '+%d ~%d -%d',
            git_status.added or 0,
            git_status.changed or 0,
            git_status.removed or 0
          )
        end
        return ''
      end,
      icon = '󰊢 ',
      color = { fg = colors.yellow, gui = 'bold' },
      cond = conditions.hide_in_width,
    }

    -- ins_left {
    --   'diff',
    --   symbols = { added = '󰯫 ', modified = '󰰏 ', removed = '󰰞 ' },
    --   diff_color = {
    --     added = { fg = colors.green },
    --     modified = { fg = colors.orange },
    --     removed = { fg = colors.red },
    --   },
    --   cond = conditions.hide_in_width,
    -- }

    for _, icons in pairs(icon_sets_list) do
      ins_left {
        function() return get_random_icon(icons) end,
        color = function()
          return { fg = get_animated_color() }
        end,
        cond = conditions.hide_in_width,
      }
    end

    ins_left {
      'searchcount',
      color = { fg = colors.green, gui = 'bold' },
    }

    -- RIGHT
    -- local function get_weather()
    --   local job = require('plenary.job')
    --   job:new({
    --     command = 'curl',
    --     args = { '-s', 'wttr.in/?format=%c+%t' },
    --     on_exit = function(j, return_val)
    --       if return_val == 0 then
    --         local weather = table.concat(j:result(), ' ')
    --         vim.schedule(function()
    --           vim.b.weather = weather
    --         end)
    --       end
    --     end,
    --   }):start()
    --   return vim.b.weather or 'N/A'
    -- end
    --
    -- ins_right {
    --   function() return get_weather() end,
    --   icon = '󰖐 ',
    --   color = { fg = colors.cyan, gui = 'bold' },
    -- }
    --

    ins_right {
      function()
        local reg = vim.fn.reg_recording()
        return reg ~= '' and '[' .. reg .. ']' or ''
      end,
      color = { fg = '#ff3344', gui = "bold" },
      cond = function()
        return vim.fn.reg_recording() ~= ''
      end,
    }

    ins_right {
      'selectioncount',
      color = { fg = colors.green, gui = 'bold' },
    }


    for _, icons in ipairs(reversed_icon_sets) do
      ins_right {
        function() return get_random_icon(icons) end,
        color = function()
          return { fg = get_animated_color() }
        end,
        cond = conditions.hide_in_width,
      }
    end

    ins_right {
      function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end

        -- Map LSP names to their shortened versions
        local lsp_short_names = {
          pyright = "py",
          tsserver = "ts",
          rust_analyzer = "rs",
          lua_ls = "lua",
          clangd = "c++",
          bashls = "sh",
          jsonls = "json",
          html = "html",
          cssls = "css",
          tailwindcss = "tw",
          dockerls = "docker",
          sqlls = "sql",
          yamlls = "yaml",
          -- Add more mappings as needed
        }

        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            -- Return the shortened name if available, otherwise return the first two letters of the LSP name
            return lsp_short_names[client.name] or client.name:sub(1, 2)
          end
        end
        return msg
      end,
      icon = ' ',
      color = { fg = colors.yellow, gui = 'bold' },
    }

    ins_right {
      function()
        return '' -- 󱎶
      end,
      color = function()
        return { fg = get_mode_color() }
      end,
      cond = conditions.hide_in_width,
    }

    ins_right(create_separator('right'))

    ins_right(create_mode_based_component('location', nil, colors.bg))

    ins_right(create_separator('left'))

    ins_right {
      'branch',
      icon = ' ', --a
      fmt = function(branch)
        if branch == '' or branch == nil then
          return 'No Repo' -- Change this to any icon or text you prefer
        end
        return branch
      end,
      color = function()
        local mode_color = get_mode_color() -- Get the color for the current mode
        return {
          fg = mode_color,                  -- Set background to the opposite color
          gui = 'bold',                     -- Keep the text bold
        }
      end,
    }

    ins_right(create_separator('right'))

    ins_right(create_mode_based_component('progress', nil, colors.bg))

    require('lualine').setup(config)
  end,
}
