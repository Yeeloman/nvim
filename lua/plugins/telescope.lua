return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({
        pickers = {
          buffers = {
            theme = "dropdown", -- Use a predefined theme like dropdown, cursor, or ivy
            previewer = false,
            layout_config = {
              width = 0.4,
              height = 0.3,
              prompt_position = "top",
            },
            mappings = {
              i = {
                ["<C-d>"] = "delete_buffer",
              },
              n = {
                ["<C-d>"] = "delete_buffer",
              },
            },
          },


          find_files = {
            theme = "ivy",
            previewer = true,
            layout_config = {
              height = 0.7,
              prompt_position = "top",
            },
          },
          live_grep = {
            theme = "dropdown",
            previewer = true,
            layout_config = {
              height = 0.3,
              prompt_position = "top",
            },
          },
        },
      })

      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope Git files' })
      -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end,
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    event = "VeryLazy",
    config = function()
      require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}

          }
        }
      }
      require("telescope").load_extension("ui-select")
    end
  }
}
