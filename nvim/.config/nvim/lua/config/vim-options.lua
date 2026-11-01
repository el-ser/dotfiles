local opt = vim.opt

opt.relativenumber = true -- show relative line number
opt.number = true -- show current line number
opt.expandtab = true -- use spaces when <Tab> is inserted
opt.tabstop = 2 -- number of spaces that <Tab> in file uses
opt.softtabstop = 2 -- number of spaces that <Tab> uses while editing
opt.shiftwidth = 2 -- number of spaces to use for (auto)indent step
opt.swapfile = false -- whether to use a swapfile for a buffer
opt.fillchars = { eob = " " } -- remove tilde as filler character
opt.cursorline = true -- highlight the screen line of the cursor
opt.clipboard:append("unnamedplus") -- use the clipboard as the unnamed register, yank uses clipboard for register
opt.wrap = false -- long lines wrap and continue on the next line
opt.signcolumn = "yes" -- when and how to display the sign column
opt.foldcolumn = "1" -- when and how to display the fold column
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions" -- required by auto-session to restore filetype/highlighting
vim.wo.number = true
vim.g.mapleader = " "
vim.g.lazygit_floating_window_winblend = 0
vim.g.lazygit_floating_window_scaling_factor = 1
vim.g.autoformat = true
