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
