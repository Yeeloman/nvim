-- load the session for the current directory
vim.keymap.set("n", "<leader>qc", function() require("persistence").load() end, { desc = "load the session for cwd" })

-- select a session to load
vim.keymap.set("n", "<leader>qs", function() require("persistence").select() end, { desc = "Select a session" })

-- load the last session
vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end,
  { desc = "load last session" })

-- stop Persistence => session won't be saved on exit
vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end, { desc = "Stop saving the session" })
return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
  }
}
