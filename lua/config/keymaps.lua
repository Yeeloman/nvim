local g = vim.g

g.mapleader = " "
g.maplocalleader = "\\"

local keymap = vim.keymap
local opts = {}
local silent_opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<Esc>', ':nohlsearch<CR><Esc>', { noremap = true, silent = true })

-- Disable the spacebar key's default behavior in Normal and Visual modes
keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Vertical scroll and center
keymap.set('n', '<C-d>', '<C-d>zz', silent_opts)
keymap.set('n', '<C-u>', '<C-u>zz', silent_opts)

-- Find and center
keymap.set('n', 'n', 'nzzzv', silent_opts)
keymap.set('n', 'N', 'Nzzzv', silent_opts)

-- Resize with arrows
keymap.set('n', '<Up>', ':resize -2<CR>', silent_opts)
keymap.set('n', '<Down>', ':resize +2<CR>', silent_opts)
keymap.set('n', '<Left>', ':vertical resize -2<CR>', silent_opts)
keymap.set('n', '<Right>', ':vertical resize +2<CR>', silent_opts)

-- Buffers
keymap.set('n', '<Tab>', ':bnext<CR>', silent_opts)
keymap.set('n', '<S-Tab>', ':bprevious<CR>', silent_opts)

-- delete single character without copying into register
keymap.set('n', 'x', '"_x', silent_opts)

-- refresh
keymap.set("n", "<F4>", ":source ~/.config/nvim/init.lua<CR>", opts)

-- changing visual block mode keybind
keymap.set('n', 'gv', '<C-v>', opts)

-- navigate wrapped lines gracefully
keymap.set('n', 'j', 'gj', silent_opts)
keymap.set('n', 'k', 'gk', silent_opts)

-- Window management
keymap.set('n', '<leader>v', '<C-w>v', { noremap = true, silent = true, desc = "Split window vertically" })   -- split window vertically
keymap.set('n', '<leader>h', '<C-w>s', { noremap = true, silent = true, desc = "Split window horizontally" }) -- split window horizontally
keymap.set('n', '<leader>sr', '<C-w>=', { noremap = true, silent = true, desc = "Reset window size" })        -- make split windows equal width & height
keymap.set('n', '<leader>xs', ':close<CR>', { noremap = true, silent = true, desc = "Close current split" })  -- close current split window

-- pane nav
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)

-- Tabs
keymap.set('n', '<leader>to', ':tabnew<CR>', opts)   -- open new tab
keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab


-- move selected lines
keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv")
keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv")

keymap.set('n', "J", "mzJ`z")

-- Keep last yanked when pasting
keymap.set('v', 'p', '"_dP', opts)

-- key map for lazy
keymap.set('n', '<leader>l', "<cmd>Lazy<CR>", { desc = "Open lazy", noremap = true, silent = true })

-- Stay in visual mode after command indent < >
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

--keymap to look for highlights
keymap.set("n", "<leader>th", "<cmd>Telescope highlights<CR>",
	{ desc = "Open highlights", noremap = true, silent = true })
