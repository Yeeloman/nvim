return {
  "nat-418/boole.nvim",
  event = "VeryLazy",
  opts = {
    mappings = {
      increment = "<C-a>",
      decrement = "<C-x>",
    },
    additions = {
      { "Foo", "Bar" },
      { "tic", "tac", "toe" },
    },
    allow_caps_additions = {
      { "enable", "disable" },
    },
  },
  config = true,
}

