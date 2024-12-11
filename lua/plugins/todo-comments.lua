local keymap = vim.keymap
return {
  "folke/todo-comments.nvim",
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
  },
  config = function ()
    require("todo-comments").setup({
      signs = false,
      highlight = {
        pattern = [[.*<(KEYWORDS)\s*]],
      },
    })
    keymap.set("n", "<leader>tn", function()
      require("todo-comments").jump_next()
    end, { desc = "Next todo comment" })

    keymap.set("n", "<leader>tp", function()
      require("todo-comments").jump_prev()
    end, { desc = "Previous todo comment" })
    keymap.set('n', "<leader>tq", ":TodoQuickFix<CR>", { desc = "Todo quick fix" })
    keymap.set('n', "<leader>ts", ":TodoTelescope<CR>", { desc = "Todo telescope" })
  end
}
