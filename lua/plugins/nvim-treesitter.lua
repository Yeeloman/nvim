return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      event = "VeryLazy",
      -- lazy = false,
      enabled = true,
    },
  },
  build = ":TSUpdate",
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "python",
        "rust",
        "html",
        "javascript",
        "typescript",
        "css",
        "svelte",
        "bash",
        "json",
        "yaml",
        "regex",
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<leader>ss", -- set to `false` to disable one of the mappings
          node_incremental = "<leader>si",
          scope_incremental = "<leader>sc",
          node_decremental = "<leader>sd",
        },
      },
      textobjects = {
        select = {
          enable = true,

          lookahead = true,

          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
          },
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'v',  -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          include_surrounding_whitespace = true,
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>sn"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>sp"] = "@parameter.inner",
          },
        },
        -- check if this section is actually needed or not
        lsp_interop = {
          enable = true,
          border = 'none',
          floating_preview_opts = {},
          peek_definition_code = {
            ["<leader>df"] = "@function.outer",
            ["<leader>dF"] = "@class.outer",
          },
        },
      },
    })
    -- Safely require and configure repeatable_move
    local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
    local keymap = vim.keymap.set
    keymap({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
    keymap({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
    keymap({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
    keymap({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
    keymap({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
    keymap({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
  end,
}
