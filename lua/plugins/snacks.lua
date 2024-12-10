return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      sections = {
        {
          section = "terminal",
          cmd = "chafa $HOME/.config/nvim/lua/eclipse.jpg --format symbols --symbols vhalf --size 60x17 --stretch; sleep .1",
          height = 17,
          padding = 1,
        },
        -- {
        --   pane = 2,
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
        -- },
      },
    },
    notifier = {
      enabled = true,
      style = "compact",
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = false },
    words = { enabled = true },
    styles = {
      notification = {
        wo = {
          wrap = true,
        },
      },
    },
  },
  keys = {
    { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    { "<leader>tt", function() Snacks.terminal() end, desc = "Toggle Terminal", mode = { "n", "t" } },
  },
}
