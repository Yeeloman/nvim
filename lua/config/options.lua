local opt = vim.opt

-- Tab / Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = false
opt.smartindent = true
opt.smarttab = true
opt.wrap = true

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Appearance
opt.foldmethod = "indent"
opt.foldenable = false
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.colorcolumn = "80"
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.scrolloff = 999
opt.completeopt = "menuone,noinsert,noselect"
opt.laststatus = 2
opt.showmatch = true
opt.cursorline = true
opt.cursorcolumn = false
opt.linebreak = true
opt.showbreak = "+++"
opt.ruler = true
opt.wildmode = "longest,list,full"
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Behaviour
opt.hidden = true
opt.errorbells = true
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.undofile = true
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true
opt.autochdir = false
opt.iskeyword:append("-")
opt.mouse:append("a")
opt.clipboard:append("unnamedplus")
opt.modifiable = true
opt.encoding = "UTF-8"
opt.showmode = false
opt.showcmd = true
opt.autoread = true
opt.background = "dark"
opt.guicursor = "n-v-c:block,i-ci-ve:block"
opt.virtualedit = "block"
opt.inccommand = "split"

vim.o.undofile = true -- Save undo history (default: false)

-- this two options makes the cmdline appear under lualine
-- vim.o.wildmenu = true
-- vim.o.wildmode = "longest:full,full"
-- opt.cmdheight = 0

-- make the bg transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFoalt", { bg = "none" })
