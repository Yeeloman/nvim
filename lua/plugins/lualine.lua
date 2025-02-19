return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  config = function()
    -- Theme colors
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
      yellow   = wal_colors[3] or default_colors.yellow,
      cyan     = wal_colors[6] or default_colors.cyan,
      darkblue = wal_colors[2] or default_colors.darkblue,
      green    = wal_colors[4] or default_colors.green,
      orange   = wal_colors[7] or default_colors.orange,
      violet   = wal_colors[5] or default_colors.violet,
      magenta  = wal_colors[3] or default_colors.magenta,
      blue     = wal_colors[4] or default_colors.blue,
      red      = wal_colors[9] or default_colors.red,
    }

    for key, default_color in pairs(default_colors) do
      colors[key] = shared_colors.ensure_contrast(colors[key], default_color)
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
      return opposite_colors[mode_color] or colors.fg
    end

    local function get_animated_color(mode_color)
      local all_colors = {
        colors.red, colors.blue, colors.green, colors.magenta,
        colors.orange, colors.cyan, colors.violet, colors.yellow,
        colors.darkblue
      }
      local possible_opposites = {}
      for _, color in ipairs(all_colors) do
        if color ~= mode_color then
          table.insert(possible_opposites, color)
        end
      end
      if #possible_opposites > 0 then
        local random_index = math.random(1, #possible_opposites)
        return possible_opposites[random_index]
      else
        return colors.fg
      end
    end

    -- Conditions
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

    -- Random icons
    math.randomseed(12345)
    local icon_sets = {
      stars = { '★', '☆', '✧', '✦', '✶', '✷', '✸', '✹' },
      runes = { '✠', '⛧', '𖤐', 'ᛟ', 'ᚨ', 'ᚱ', 'ᚷ', 'ᚠ', 'ᛉ', 'ᛊ', 'ᛏ', '☠', '☾', '♰', '✟', '☽', '⚚', '🜏' },
      hearts = { '❤', '♥', '♡', '❦', '❧' },
      waves = { '≈', '∿', '≋', '≀', '⌀', '≣', '⌇' },
      crosses = { '☨', '✟', '♰', '♱', '⛨', "" },
    }

    local function get_random_icon(icons)
      return icons[math.random(#icons)]
    end

    -- Shuffle table
    local function shuffle_table(tbl)
      local n = #tbl
      while n > 1 do
        local k = math.random(n)
        tbl[n], tbl[k] = tbl[k], tbl[n]
        n = n - 1
      end
    end

    local icon_sets_list = {}
    for _, icons in pairs(icon_sets) do
      table.insert(icon_sets_list, icons)
    end
    shuffle_table(icon_sets_list)

    -- Reverse table
    local function reverse_table(tbl)
      local reversed = {}
      for i = #tbl, 1, -1 do
        table.insert(reversed, tbl[i])
      end
      return reversed
    end
    local reversed_icon_sets = reverse_table(icon_sets_list)

    -- Config
    local config = {
      options = {
        component_separators = '',
        section_separators = '',
        theme = {
          normal = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } }, -- Simplified inactive theme
        },
        disabled_filetypes = { "neo-tree", "undotree", "sagaoutline", "diff" },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {

            "location",
            color = function()
              return {
                fg = colors.fg,
                gui = 'bold',
              }
            end,
          },
        },
        lualine_x = {
          {
            'filename',
            icon = get_random_icon(icon_sets.waves),
            color = function()
              return { fg = get_animated_color(colors.fg), gui = 'bold,italic' }
            end,
          },
        },
        lualine_y = {},
        lualine_z = {},
      },
    }

    -- Helper functions
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

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

    -- Mode indicator
    local function mode()
      local mode_map = {
        n = 'N',
        i = 'I',
        v = 'V',
        [''] = 'V',
        V = 'V',
        c = 'C',
        no = 'N',
        s = 'S',
        S = 'S',
        ic = 'I',
        R = 'R',
        Rv = 'R',
        cv = 'C',
        ce = 'C',
        r = 'R',
        rm = 'M',
        ['r?'] = '?',
        ['!'] = '!',
        t = 'T',
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
        local virtual_env = vim.env.VIRTUAL_ENV
        if virtual_env then
          return { fg = get_animated_color(), gui = 'bold' }
        else
          return { fg = get_mode_color(), gui = 'bold' }
        end
      end,
    }

    ins_left(create_separator('right'))

    ins_left(create_mode_based_component('filename', nil, colors.bg))

    ins_left(create_separator('left'))

    ins_left {
      function()
        return ''
      end,
      color = function()
        return { fg = get_mode_color() }
      end,
      cond = conditions.hide_in_width,
    }

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
        }
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
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
        return ''
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
      icon = ' ',
      fmt = function(branch)
        if branch == '' or branch == nil then
          return 'No Repo'
        end
        return branch
      end,
      color = function()
        local mode_color = get_mode_color()
        return {
          fg = mode_color,
          gui = 'bold',
        }
      end,
    }

    ins_right(create_separator('right'))

    ins_right(create_mode_based_component('progress', nil, colors.bg))

    require('lualine').setup(config)
  end,
}
