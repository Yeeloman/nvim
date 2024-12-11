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
    filesystem = {
      follow_current_file = true, -- Automatically focus on the currently opened file
      use_libuv_file_watcher = true, -- Optional: Update the tree when files change
    },
  },
  config = true,
  vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true }),
}
