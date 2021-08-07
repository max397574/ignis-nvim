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
map("n", "<leader>w", ":w<CR>", nore)
-- paste over selected text without overwriting yank register
map("v", "<leader>p", "_dP", nore)
map("n", "Q", "@q", nore)
-- edit macro q
map("n", "<leader>q", ":let @t = 'let @q = \"' . @q<CR>:<C-f>o<ESC>\"tp$a\"<Esc>", nore)
