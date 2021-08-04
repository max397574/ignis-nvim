local map = vim.api.nvim_set_keymap
local options = { noremap = true }
-- remove highlighting from search
map('n', 'nh', ':nohlsearch<CR>', { noremap = true, silent = true})
-- move visual blocks up and down
map('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
map('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
