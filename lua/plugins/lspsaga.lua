local keymap = vim.keymap
return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  config = true,
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
  },

  keymap.set("n", "<leader>ol", "<cmd>Lspsaga outline<CR>", { desc = "Toggle Lsp Outline" }),
  keymap.set("n", "<leader>oa", "<cmd>Lspsaga code_action<CR>", { desc = "Code action" }),
  keymap.set("n", "<leader>of", "<cmd>Lspsaga finder<CR>", { desc = "Lsp finder" }),
  keymap.set("n", "<leader>oh", "<cmd>Lspsaga hover_doc<CR>", { desc = "Hover documentation" }),
  keymap.set("n", "<leader>or", "<cmd>Lspsaga rename<CR>", { desc = "Rename variable" }),
  keymap.set("n", "<leader>opd", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek definition" }),
  keymap.set("n", "<leader>opt", "<cmd>Lspsaga peek_type_definition<CR>", { desc = "Peek type definition" }),
  keymap.set("n", "<leader>ojn", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "diagnostic jump next" }),
  keymap.set("n", "<leader>ojp", "<cmd>Lspsaga diagnostic_jump_previous<CR>", { desc = "diagnostic jump prev" }),
  -- keymap.set("n", "<leader>ot", "<cmd>Lspsaga term_toggle<CR>", { desc = "Toggle terminal" }),
}
