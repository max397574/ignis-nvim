local map = vim.api.nvim_set_keymap
local nore_silent = { noremap = true, silent = true }
local nore = { noremap = true }

-- remove highlighting from search
map("n", "nh", ":nohlsearch<CR>", nore_silent)
-- move visual blocks up and down
map("v", "J", ":m '>+1<CR>gv=gv", nore_silent)
map("v", "K", ":m '<-2<CR>gv=gv", nore_silent)
map("v", "jk", "<ESC>", nore)
map("i", "jj", "<ESC>", nore)
