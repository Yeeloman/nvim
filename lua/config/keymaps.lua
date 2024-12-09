local keymap = vim.keymap
local opts = {}
local silent_opts = { noremap = true, silent = true }

-- refresh
keymap.set("n", "<F4>", ":source ~/.config/nvim/init.lua<CR>", opts)

-- changing visual block mode keybind
keymap.set('n', 'gv', '<C-v>', opts)

-- navigate wrapped lines gracefully
keymap.set('n', 'j', 'gj', silent_opts)
keymap.set('n', 'k', 'gk', silent_opts)


-- pane nav
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)

-- Safely require the repeatable_move module
local ok, ts_repeat_move = pcall(require, "nvim-treesitter.textobjects.repeatable_move")
if ok then
  -- Repeat movement with ; and ,
  keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
  keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

  -- Make builtin f, F, t, T also repeatable with ; and ,
  keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
  keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
  keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
  keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
else
  vim.notify("nvim-treesitter-textobjects not loaded!", vim.log.levels.WARN)
end
