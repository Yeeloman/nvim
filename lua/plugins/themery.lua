return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
    },
    config = true,
  },
  {
    'shaunsingh/nord.nvim',
    config = function()
      vim.g.nord_disable_background = true
      vim.g.nord_italic = true
    end
  },
  {
    "RedsXDD/neopywal.nvim",
    name = "neopywal",
    lazy = false,
    priority = 1000,
    opts = {

    },
    config = function()
      local C = require("neopywal").get_colors()
      local U = require("neopywal.utils.color")
      require("neopywal").setup({

        transparent_background = true,
        custom_colors = {
          -- Extras:
          dim_bg = U.darken(C.background, 5),
          comment = C.color8,
          cursorline = U.blend(C.background, C.foreground, 0.9),
          directory = C.color4,

          -- Diffs:
          diff_added = C.color2,
          diff_changed = C.color6,
          diff_removed = C.color1,
          diff_untracked = C.color5,

          -- LSP/Diagnostics:
          error = C.color1,
          hint = C.color6,
          info = C.foreground,
          unnecessary = C.color8,
          warn = U.blend(C.color1, C.color3, 0.5),
          ok = C.color2,
          inlay_hints = C.color8,

          -- Variable types:
          variable = C.color4,                           -- (preferred) any variable.
          constant = C.color3,                           -- (preferred) any constant
          string = C.foreground,                         -- a string constant: "this is a string"
          character = C.color3,                          -- a character constant: 'c', '\n'
          number = C.color5,                             -- a number constant: 234, 0xff
          boolean = C.color5,                            -- a boolean constant: TRUE, FALSE
          float = C.color5,                              -- a floating point constant: 2.3e10
          identifier = U.blend(C.color1, C.color3, 0.5), -- (preferred) any variable name
          func = C.color2,                               -- function name (also: methods for classes)

          -- Statements:
          statement = C.color1,   -- (preferred) any statement
          conditional = C.color1, -- if, then, else, endif, switch, etc.
          loop = C.color1,        -- for, do, while, etc.
          label = C.color1,       -- case, default, etc.
          exception = C.color1,   -- try, catch, throw
          operator = C.color1,    -- "sizeof", "+", "*", etc.
          keyword = C.color1,     -- any other keyword
          debug = C.color3,       -- debugging statements.

          -- Preprocessors:
          preproc = C.color5,   -- (preferred) generic Preprocessor
          include = C.color5,   -- preprocessor #include
          define = C.color5,    -- preprocessor #define
          macro = C.color5,     -- same as Define
          precondit = C.color5, -- preprocessor #if, #else, #endif, etc.

          -- Type definitions:
          type = C.color6,         -- (preferred) int, long, char, etc.
          structure = C.color6,    -- struct, union, enum, etc.
          storageclass = C.color6, -- static, register, volatile, etc.
          typedef = C.color6,      -- A typedef

          -- Special:
          special = C.color5,                     -- (preferred) any special symbol
          secialchar = C.color5,                  -- special character in a constant
          tag = U.blend(C.color1, C.color3, 0.5), -- you can use CTRL-] on this
          delimiter = C.foreground,               -- character that needs attention
          specialcomment = C.color8,              -- special things inside a comment
        },
      })
    end
  },
  {
    "zaldih/themery.nvim",
    lazy = false,
    opts = {
      themes = {
        "nord",
        "tokyonight",
        "tokyonight-night",
        "tokyonight-storm",
        "neopywal",

        -- Default Vim themes
        "desert",  -- Desert color scheme
        "elflord", -- Elflord color scheme
        "evening", -- Evening color scheme
        "koehler", -- Koehler color scheme
        "murphy",  -- Murphy color scheme
        "slate",   -- Slate color scheme
        "torte",   -- Torte color scheme

      },

      livePreview = true,
      -- add the config here
    },
    config = true,
    vim.keymap.set('n', "<leader>ct", ":Themery<CR>", { desc = "Theme picker" }),
  },
}
