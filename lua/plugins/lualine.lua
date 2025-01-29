return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  config = function()
    -- theme colors
    local colors = {
      bg       = '#1c1b1b',
      fg       = '#f2e7d5',
      yellow   = '#e8b75f',
      cyan     = '#5ad1b3',
      darkblue = '#2b3e50',
      green    = '#5eff73',
      orange   = '#ff7733',
      violet   = '#7a3ba8',
      magenta  = '#d360aa',
      blue     = '#4f9cff',
      red      = '#ff3344',
    }

    local function get_mode_color()
      local mode_color = {
        n = colors.darkblue,
        i = colors.magenta,
        v = colors.red,
        [''] = colors.blue,
        V = colors.red,
        c = colors.magenta,
        no = colors.red,
        s = colors.orange,
        S = colors.orange,
        [''] = colors.orange,
        ic = colors.yellow,
        R = colors.violet,
        Rv = colors.violet,
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
      -- Define a mapping of mode colors to their opposites
      local opposite_colors = {
        [colors.red] = colors.blue,
        [colors.blue] = colors.red,
        [colors.green] = colors.magenta,
        [colors.magenta] = colors.green,
        [colors.orange] = colors.cyan,
        [colors.cyan] = colors.orange,
        [colors.violet] = colors.yellow,
        [colors.yellow] = colors.violet,
      }
      return opposite_colors[mode_color] or colors.fg -- Default to fg if no opposite is found
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

    -- Functions for random icons
    local function get_random_rune()
      local runes = { '✠', '⛧', '𖤐', 'ᛟ', 'ᚨ', 'ᚱ', 'ᚷ', 'ᚠ', 'ᛉ', 'ᛊ', 'ᛏ', '☠', '☾', '♰', '✟', '☽', '⚚', '🜏' }
      return runes[math.random(#runes)]
    end

    local function get_random_star()
        local stars = { '★', '☆', '✧', '✦', '✶', '✷', '✸', '✹' }
        return stars[math.random(#stars)]
      end

    local function get_random_heart()
        local hearts = { '❤', '♥', '♡', '❦', '❧' }
        return hearts[math.random(#hearts)]
      end

      local function get_random_corner()
        local separators = { '', '', '', '' }
        return separators[math.random(#separators)]
      end

    local function get_random_arcane_symbol()
        local symbols = { }
        return symbols[math.random(#symbols)]
    end


    local function get_random_icon(icon_list)
      return icon_list[math.random(#icon_list)]
    end

    local icon_sets = {
  { '✠', '⛧', '𖤐', 'ᛟ', 'ᚨ', 'ᚱ', 'ᚷ', 'ᚠ', 'ᛉ', 'ᛊ', 'ᛏ', '☠', '☾', '♰', '✟', '☽', '⚚', '🜏' }, -- Runes
      { '★', '☆', '✧', '✦', '✶', '✷', '✸', '✹' }, -- Stars
      { '❤', '♥', '♡', '❦', '❧' }, -- Hearts
    }

    local function get_random_middle_icons()
      local middle_space = math.floor(vim.fn.winwidth(0) / 7) -- Configurable width spacing
      local icons = {}

      for _ = 1, middle_space do
        local chosen_set = icon_sets[math.random(#icon_sets)]
        table.insert(icons, get_random_icon(chosen_set))
      end

      return table.concat(icons, " ")
    end

    -- configs
    local config = {
      options = {
        component_separators = '', -- No separators between components
        section_separators = '',   -- No separators between sections
        theme = {
          normal = { c = { fg = colors.fg, bg = colors.bg } }, -- Active statusline colors
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
    local function create_separator(side)
      return {
        function()
          return side == 'left' and '' or ''
        end,
        color = function()
          local mode_color = get_mode_color()
          return { fg = get_opposite_color(mode_color) }
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


    -- LEFT
    ins_left {
      function()
        local shiftwidth = vim.api.nvim_buf_get_option(0, 'shiftwidth')
        local expandtab = vim.api.nvim_buf_get_option(0, 'expandtab')
        return (expandtab and ' s:' or ' t:') .. shiftwidth .. " "
      end,
      -- icon = '󰌒 ',
      color = function()
        local mode_color = get_mode_color()
        return { fg = colors.bg, bg = get_opposite_color(mode_color), gui = 'bold' }
      end,
      padding = { left = 0 },
    }
    -- Left separator
    ins_left(create_separator('left'))

    ins_left {
      function()
        return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
      end,
      icon = ' ',
      color = function()
        return {
          fg = get_mode_color(),
          gui = "bold",
        }
      end,
    }

    -- Right separator
    ins_left(create_separator('right'))

    ins_left(create_mode_based_component('filename', nil, colors.bg))

    ins_left(create_separator('left'))

    -- Mode indicator
    ins_left {
      function()
        return '' -- 󱎶
      end,
      color = function()
        return { fg = get_mode_color() }
      end,
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

    ins_left {
      function() return get_random_star() end,
      color = function()
        return { fg = get_mode_color() }
      end,
    }

    ins_left {
      function() return get_random_rune() end,
      color = function()
        return { fg = get_mode_color() }
      end,
    }
    
    ins_left {
      function() return get_random_heart() end,
      color = function()
        return { fg = get_mode_color() }
      end,
    }
    -- this one makes nvim super slow
    -- ins_right {
    --   function()
    --     local handle = io.popen('curl -s "wttr.in/?format=%c+%t"')
    --     if handle then
    --       local result = handle:read('*a')
    --       handle:close()
    --       return result
    --     end
    --     return 'N/A'
    --   end,
    --   icon = '󰖐 ',
    --   color = { fg = colors.cyan, gui = 'bold' },
    -- }

    -- RIGHT
    ins_right {
      function()
        local reg = vim.fn.reg_recording()
        return reg ~= '' and '@' .. reg or ''
      end,
      icon = '󰻃',
      color = { fg = colors.red },
      cond = function()
        return vim.fn.reg_recording() ~= ''
      end,
    }

    ins_right {
      function() return get_random_heart() end,
      color = function()
        return { fg = get_mode_color() }
      end,
    }
    ins_right {
      function() return get_random_rune() end,
      color = function()
        return { fg = get_mode_color() }
      end,
    }
    ins_right {
      function() return get_random_star() end,
      color = function()
        return { fg = get_mode_color() }
      end,
    }

    ins_right {
      function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = ' ',
      color = { fg = '#e1a95f', gui = 'bold' },
    }

    ins_right {
      function()
        return '' -- 󱎶
      end,
      color = function()
        return { fg = get_mode_color() }
      end,
    }

    ins_right(create_separator('right'))

    ins_right(create_mode_based_component('location', nil, colors.bg))

    ins_right(create_separator('left'))

    ins_right {
      'branch',
      icon = ' ', --a
      color = function()
        local mode_color = get_mode_color() -- Get the color for the current mode
        return {
          fg = mode_color, -- Set background to the opposite color
          gui = 'bold', -- Keep the text bold
        }
      end,
    }

    ins_right(create_separator('right'))
    ins_right(create_mode_based_component('progress', nil, colors.bg))

    require('lualine').setup(config)
  end,
}
