-- for vim-repeat
-- silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

local map = vim.api.nvim_set_keymap
local nore_silent = { noremap = true, silent = true }
local nore = { noremap = true }
local silent = { silent = true }

-- neorg cycle tasks
map("n", "<c-t>", ":Neorg keybind norg core.norg.qol.todo_items.todo.task_cycle<CR>", nore_silent)

-- view latex pdf in preview
map("n","<leader>vl", ":silent !pdflatex %; open %:t:r.pdf<CR>", nore_silent)

-- open helpfile of word under cursor
-- follow link
map('n', '<C-f>', ':lua vim.cmd(":vert :h "..vim.fn.expand("<cword>"))<CR>', nore_silent)
-- remove highlighting from search
map("n", "nh", ":nohlsearch<CR>", nore_silent)
-- select colorscheme
map("n", "<leader>cs", ":lua require'telescope.builtin'.colorscheme{}<CR>", nore)
-- capitalize word under cursor
map("n", "<C-U>", "b~", nore_silent)
-- easy split navigation
map("n", "<c-j>", ":wincmd j<CR>", nore_silent)
map("n", "<c-h>", ":wincmd h<CR>", nore_silent)
map("n", "<c-k>", ":wincmd k<CR>", nore_silent)
map("n", "<c-l>", ":wincmd l<CR>", nore_silent)
-- alt hjkl
-- use sed -n l to get chars with alt
map("n", "º", ":wincmd J<CR>", nore_silent)
map("n", "ª", ":wincmd H<CR>", nore_silent)
map("n", "∆", ":wincmd K<CR>", nore_silent)
map("n", "¬", ":wincmd L<CR>", nore_silent)
-- open netrw
map("n", "<leader>es", ":Vexplore<CR>", nore_silent)
map("n", "<leader>ef", ":Explore<CR>", nore_silent)
-- easy git
map("n", "<leader>ga", ":Git add %<CR>", nore_silent)
map("n", "<leader>gc", ":Git commit<CR>", nore_silent)
map("n", "<leader>gl", ":GV<CR>", nore_silent)
map("n", "<leader>gp", ":Git push<CR>", nore_silent)
map("n", "<leader>gs", ":G<CR>", nore_silent)
map("n", "<leader>gd", ":Git diff<CR>", nore_silent)
-- faster navigation
map("n", "<leader>K", "10k",nore)
map("n", "<leader>J", "10j",nore)
-- treesitter playground
map("n", "<leader>tspg", ":TSPlaygroundToggle<CR>", nore_silent)
map("n", "<leader>tshc", ":TSHighlightCapturesUnderCursor<CR>", nore_silent)
-- Telescope Mappings
map('n', "<C-s>", ":Telescope current_buffer_fuzzy_find<CR>", nore_silent)
map('n', "<Leader>lg", ":Telescope live_grep<CR>", nore_silent)
map('n', "<Leader>fh", ":Telescope help_tags<CR>", nore_silent)
map('n', "<Leader>fb", ":Telescope buffers<CR>", nore_silent)
map('n', "<Leader>fo", ":Telescope oldfiles<CR>", nore_silent)
map('n', "<Leader>fs", ":Telescope lsp_workspace_symbols<CR>", nore_silent)
map("n", "<leader>ff", ":Telescope find_files<CR>", nore_silent)
map('n', "<leader>fd", ":Telescope zoxide list<CR>", nore_silent)
map("n", "<leader>tcts", ":Telescope treesitter<CR>", nore_silent)
map("n", "<leader>tctd", ":TodoTelescope<CR>", nore_silent)
-- https://github.com/nvim-telescope/telescope.nvim#pickers
map("n", "<leader>tcch", ":lua require'telescope.builtin'.command_history{}<CR>", nore)
map("n", "<leader>tcsh", ":lua require'telescope.builtin'.search_history{}<CR>", nore)
map("n", "<leader>tcgc", ":lua require'telescope.builtin'.git_commits{}<CR>", nore)
map("n", "<leader>tcsb", ":lua require'telescope.builtin'.symbols{}<CR>", nore)
map("n", "<leader>tcbi", ":lua require'telescope.builtin'.builtin{}<CR>", nore)
-- highlight search result and center cursor
map("n", "n", "nzzzv", nore_silent)
map("n", "N", "Nzzzv", nore_silent)
-- move visual blocks up and down
map("v", "J", ":m '>+1<CR>gv=gv", nore_silent)
map("v", "K", ":m '<-2<CR>gv=gv", nore_silent)
-- easier escape
map("v", "jk", "<ESC>", nore)
map("i", "jj", "<ESC>", nore)
-- easy save
map("n", "<leader>w", ":w<CR>", nore)
-- paste over selected text without overwriting yank register
map("v", "<leader>p", "_dP", nore)
-- execute macro q
map("n", "Q", "@q", nore)
-- edit macro q
map("n", "<leader>q", ':let @t = \'let @q = "\' . @q<CR>:<C-f>o<ESC>"tp$a"<Esc>', nore)
-- don't move cursor down when joining lines
map("n", "J", "mzJ`z", nore)
map("x", "<BS>", "x", nore)
-- subsitute on current line
map("n", "<leader>ss", "V s", { noremap = false })
-- and on whole file
map("n", "<leader>S", "ggVG s", { noremap = false })
-- and to the end of the file
map("n", "<leader>sG", "VG s", { noremap = false })
-- markdown
map("n", "<leader>mdh1", ":MdHeading1<CR>", nore_silent)
map("n", "<leader>mdh2", ":MdHeading2<CR>", nore_silent)
map("n", "<leader>mdh3", ":MdHeading3<CR>", nore_silent)
map("n", "<leader>mda", ":MdLink<CR>", nore_silent)
map("n", "<leader>mdhr", ":MdHorizontalRule<CR>", nore_silent)
map("i", "<leader>mdhr", "<ESC>:MdHorizontalRule<CR>", nore_silent)
map("n", "<leader>mdlu", ":MdUnorderedList<CR>", nore_silent)
map("n", "<leader>mdlo", ":MdOrderedList<CR>", nore_silent)
map("n", "<leader>mdlt", ":MdTaskList<CR>", nore_silent)
map("i", "<leader>mdlu", "<ESC>:MdUnorderedList<CR>", nore_silent)
map("i", "<leader>mdlo", "<ESC>:MdOrderedList<CR>", nore_silent)
map("i", "<leader>mdlt", "<ESC>:MdTaskList<CR>", nore_silent)
map("v", "<leader>mdit", ":call VisualItalic()<CR>", nore_silent)
map("v", "<leader>mdbd", ":call VisualBold()<CR>", nore_silent)
-- better undo
map("i", ",", ",<c-g>u", nore)
map("i", "!", "!<c-g>u", nore)
map("i", ".", ".<c-g>u", nore)
map("i", " ", " <c-g>u", nore)
map("i", "?", "?<c-g>u", nore)
map("i", "<CR>", "<CR><c-g>u", nore)
-- move lines up and down in visual and normal mode
map("i", "<C-j>", "<ESC>:m .+1<CR>==i<RIGHT>", nore)
map("i", "<C-k>", "<ESC>:m .-2<CR>==i<RIGHT>", nore)
map("n", "<leader>j", ":m .+1<CR>==", nore_silent)
map("n", "<leader>k", ":m .-2<CR>==", nore_silent)
-- Snip Run
map("n", "<leader>sr", ":SnipRun<CR>", nore_silent)
map("n", "<leader>sc", ":SnipClose<CR>", nore_silent)
map("v", "<leader>sr", "<Plug>SnipRun", silent)
-- insert empty line below/above
map("n", "<leader>o", "o<ESC>k", nore)
map("n", "<leader>O", "O<ESC>j", nore)
-- enter space before/after
map("n", "<leader>i", "i <ESC>l", nore)
map("n", "<leader>a", "a <ESC>h", nore)
-- substitute on visual selection
map("v", "<leader>s", ":s///g<LEFT><LEFT><LEFT>", nore)
-- copy to system clipboard
map("n", "<leader>y", '"+y', nore)
map("n", "<leader>Y", 'gg"+yG', nore)
-- move right
map("i", "kk", "<RIGHT>", nore)
-- use vmath on visually selected area
map("v", "<leader>vm", "<ESC>:Vmath<CR>", nore)
-- DistractionFree writing
map("n", "<leader>df", ":ZenMode<CR>", nore_silent)
-- open help files
map("n", "<leader>hp", ":LvimHelper<CR>", nore_silent)
-- toggle undotree
map("n", "<leader>ut", ":UndotreeToggle<CR>", nore_silent)
-- lsp
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", nore)
map("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", nore_silent)
-- toggle trouble
map("n", "<leader>trt", ":TroubleToggle<CR>", nore_silent)
-- show todo items in trouble window
map("n", "<leader>trtd", ":TodoTrouble<CR>", nore_silent)
-- lsp diagnostics in trouble
map("n", "<leader>trld", ":Trouble lsp_workspace_diagnostics<CR>", nore_silent)
-- help from ts with textobjects
map("o", "m", ":<C-U>lua require('tsht').nodes()<CR>", { silent = true })
map("v", "m", ":<C-U>lua require('tsht').nodes()<CR>", nore_silent)
-- visual multi
vim.cmd([[let g:VM_maps = {}
  let g:VM_maps["Add Cursor Down"]    = '<Leader>cd'   " new cursor down
  let g:VM_maps["Add Cursor Up"]      = '<Leader>cu'   " new cursor up
  let g:VM_maps['Find Under']         = '<Leader>fu'
]])
