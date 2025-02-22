return {
  -- TODO: need more work on lush to generate dynamic colorschemes
  -- {
  --   'rktjmp/lush.nvim',
  --   lazy = false,
  -- },
  {
    "RedsXDD/neopywal.nvim",
    name = "neopywal",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      local M = require("shared.PaletteGen")
      local base_colors = M.read_wal_colors()

      local generated_colors = M.colors_to_strings(M.generate_palette(base_colors, 15))

      require("neopywal").setup({
        transparent_background = true,
      })
    end
  },
  {
    "zaldih/themery.nvim",
    lazy = false,
    opts = {
      themes = {
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
