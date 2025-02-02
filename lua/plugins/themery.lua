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
      local M = require("shared.colors")
      local base_colors = M.read_wal_colors()

      -- Get the number of unique colors needed for custom_colors
      local custom_colors_keys = {
        "dim_bg", "comment", "cursorline", "directory",
        "diff_added", "diff_changed", "diff_removed", "diff_untracked",
        "error", "hint", "info", "unnecessary", "warn", "ok", "inlay_hints",
        "variable", "constant", "string", "character", "number", "boolean", "float",
        "identifier", "func", "statement", "conditional", "loop", "label",
        "exception", "operator", "keyword", "debug",
        "preproc", "include", "define", "macro", "precondit",
        "type", "structure", "storageclass", "typedef",
        "special", "specialchar", "tag", "delimiter", "specialcomment",
        "linenrabove", "linenr", "linenrbelow"
      }

      local needed_colors_count = #custom_colors_keys
      local generated_colors = M.generate_variants(base_colors, needed_colors_count)

      -- Map generated colors dynamically
      local custom_colors = {}
      for i, key in ipairs(custom_colors_keys) do
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
