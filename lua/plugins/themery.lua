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
    opts = {},
    config = function()
      local M = require("shared.PaletteGen")
      local base_colors = M.read_wal_colors()

      -- Define color groups for better consistency
      local custom_color_groups = {
        highlights = { "cursorline", "directory", "identifier", "func" },
        syntax = { "variable", "constant", "string", "character", "number", "boolean", "float" },
        ui = { "dim_bg", "comment", "linenrabove", "linenr", "linenrbelow" },
        diagnostics = { "error", "hint", "info", "warn", "ok", "unnecessary", "inlay_hints" },
        git = { "diff_added", "diff_changed", "diff_removed", "diff_untracked" },
        control = { "statement", "conditional", "loop", "label", "exception", "operator", "keyword", "debug" },
        preproc = { "preproc", "include", "define", "macro", "precondit" },
        types = { "type", "structure", "storageclass", "typedef" },
        special = { "special", "specialchar", "tag", "delimiter", "specialcomment" },
      }

      -- Collect all keys and shuffle them
      local all_keys = {}
      for _, group in pairs(custom_color_groups) do
        for _, key in ipairs(group) do
          table.insert(all_keys, key)
        end
      end

      math.randomseed(os.time())

      -- Shuffle function
      local function shuffle(tbl)
        for i = #tbl, 2, -1 do
          local j = math.random(i)
          tbl[i], tbl[j] = tbl[j], tbl[i]
        end
      end

      shuffle(all_keys)

      -- Get the number of unique colors needed
      local needed_colors_count = #all_keys
      local generated_colors = M.colors_to_strings(M.generate_palette(base_colors, needed_colors_count))

      -- Distribute colors dynamically after shuffling
      local custom_colors = {}
      for i, key in ipairs(all_keys) do
        custom_colors[key] = generated_colors[i]
      end

      require("neopywal").setup({
        transparent_background = true,
        custom_colors = custom_colors,
      })

      -- Apply the generated colors to line numbers dynamically
      vim.api.nvim_set_hl(0, "linenrabove", { fg = custom_colors["linenrabove"] })
      vim.api.nvim_set_hl(0, "linenr", { fg = custom_colors["linenr"] })
      vim.api.nvim_set_hl(0, "linenrbelow", { fg = custom_colors["linenrbelow"] })
    end
  },
  {
    "zaldih/themery.nvim",
    lazy = false,
    opts = {
      themes = {
        "neopywal",
        "nord",
        "tokyonight",
        "tokyonight-night",
        "tokyonight-storm",

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
