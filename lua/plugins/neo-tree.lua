return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "echasnovski/mini.icons",
  },
  opts = {
    close_if_last_window = true,
    window = {
      position = "right",
      width = 30,
    },
  },
  config = true,
  vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true }),
}
