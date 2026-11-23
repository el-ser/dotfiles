vim.g.mapleader = " "
local map = vim.keymap.set

-- exit insert mode
map("i", "jk", "<esc>", { desc = "Exit insert mode" })
-- clear search with <esc>
map({ "n", "i" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })
-- save file
map({ "n", "i", "v", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
-- quit neovim
map("n", "<c-q>", "<cmd>q<cr>", { desc = "Quit Neovim" })
-- navigate vim panes
map("n", "<c-k>", "<cmd>wincmd k<cr>", { desc = "Switch to Upper Window", silent = true })
map("n", "<c-h>", "<cmd>wincmd h<cr>", { desc = "Switch to Left Window", silent = true })
map("n", "<c-j>", "<cmd>wincmd j<cr>", { desc = "Switch to Bottom Window", silent = true })
map("n", "<c-l>", "<cmd>wincmd l<cr>", { desc = "Switch to Right Window", silent = true })
-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other Window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

map("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
map("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete Non-Pinned Buffers" })
map("n", "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", { desc = "Delete Other Buffers" })
map("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
map("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })
-- map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
-- map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
-- lazy nvim
map("n", "<leader>lp", "<cmd>Lazy<cr>", { desc = "Lazy Package Manager" })
-- lazy git
map("n", "<leader>lg", ":LazyGit<cr>", { desc = "LazyGit" })
-- todo telescope
map("n", "<leader>T", "<cmd>TodoTelescope<cr>", { desc = "Todo Telescope" })
