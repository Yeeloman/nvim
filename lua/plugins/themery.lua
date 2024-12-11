return {

  {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        transparent = true,
      })
    end,
  },
  {
    "dasupradyumna/midnight.nvim",
  },
  {
    'shaunsingh/nord.nvim',
    config = function ()
      vim.g.nord_disable_background = true
      vim.g.nord_italic = true
    end
  },
  {
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
      vim.keymap.set('n', "<leader>ct", ":Themery<CR>", { desc = "Theme picker" })
      require("themery").setup({
        themes = {
          "nord",
          "tokyonight",
          "tokyonight-night",
          "tokyonight-storm",
          "tokyonight-day",
          "midnight",

          -- Default Vim themes
          "default",       -- Default color scheme (light background)
          "desert",        -- Desert color scheme
          "elflord",       -- Elflord color scheme
          "evening",       -- Evening color scheme
          "koehler",       -- Koehler color scheme
          "murphy",        -- Murphy color scheme
          "pablo",         -- Pablo color scheme
          "peachpuff",     -- Peachpuff color scheme
          "shine",         -- Shine color scheme
          "slate",         -- Slate color scheme
          "torte",         -- Torte color scheme
          "zellner",       -- Zellner color scheme

        },

        livePreview = true,
        -- add the config here
      })
    end
  },
}
