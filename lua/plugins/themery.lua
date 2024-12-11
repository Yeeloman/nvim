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
    config = function ()
      vim.g.nord_disable_background = true
      vim.g.nord_italic = true
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

        -- Default Vim themes
        "desert",        -- Desert color scheme
        "elflord",       -- Elflord color scheme
        "evening",       -- Evening color scheme
        "koehler",       -- Koehler color scheme
        "murphy",        -- Murphy color scheme
        "slate",         -- Slate color scheme
        "torte",         -- Torte color scheme

      },

      livePreview = true,
      -- add the config here
    },
    config =  true,
    vim.keymap.set('n', "<leader>ct", ":Themery<CR>", { desc = "Theme picker" }),
  },
}
