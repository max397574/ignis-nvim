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
-- execute macro q
map("n", "Q", "@q", nore)
-- edit macro q
map("n", "<leader>q", ":let @t = 'let @q = \"' . @q<CR>:<C-f>o<ESC>\"tp$a\"<Esc>", nore)
-- don't move cursor down when joining lines
map("n", "J", "mzJ`z", nore)
map("x", "<BS>", "x", nore)
-- subsitute on current line
map("n", "<leader>ss", "V s", { noremap = false })
-- and on whole file
map("n", "<leader>S", "ggVG s", { noremap = false })
-- markdown
map("n", "<leader>mdh1", ":MdHeading1<CR>", nore_silent)
map("n", "<leader>mdh2", ":MdHeading2<CR>", nore_silent)
map("n", "<leader>mdh3", ":MdHeading3<CR>", nore_silent)
map("n", "<leader>mda", ":MdLink<CR>", nore_silent)
map("n", "<leader>mdhr", ":call MdHorizontalRule()<CR>", nore_silent)
map("i", "<leader>mdhr", "<ESC>:call MdHorizontalRule()<CR>", nore_silent)
map("n", "<leader>mdlu", "MdUnorderedList", nore_silent)
map("n", "<leader>mdlo", "MdOrderedList", nore_silent)
map("n", "<leader>mdlt", "MdTaskList", nore_silent)
map("i", "<leader>mdlu", "<ESC>MdUnorderedList", nore_silent)
map("i", "<leader>mdlo", "<ESC>MdOrderedList", nore_silent)
map("i", "<leader>mdlt", "<ESC>MdTaskList", nore_silent)
-- substitute on visual selection
map("v", "<leader>s", ":s///g<LEFT><LEFT><LEFT>", nore)
-- copy to system clipboard
map("n", "<leader><", "\"+y", nore)
