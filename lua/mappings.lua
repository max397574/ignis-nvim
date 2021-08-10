local map = vim.api.nvim_set_keymap
local nore_silent = { noremap = true, silent = true }
local nore = { noremap = true }
local silent = { silent = true }

-- remove highlighting from search
map("n", "nh", ":nohlsearch<CR>", nore_silent)
-- easy git
map("n", "<leader>ga", ":Git add %<CR>", nore_silent)
map("n", "<leader>gc", ":Git commit<CR>", nore_silent)
map("n", "<leader>gl", ":GV<CR>", nore_silent)
map("n", "<leader>gp", ":!gp origin<CR>", nore_silent)
-- Telescope
map("n", "<leader>tcff", "<cmd>Telescope find_files<CR>", nore)
map("n", "<leader>tcts", "<cmd>Telescope treesitter<CR>", nore)
map("n", "<leader>tcht", "<cmd>Telescope help_tags<CR>", nore)
map("n", "<leader>tclg", "<cmd>Telescope live_grep<CR>", nore)
map("n", "<leader>tctd", "<cmd>TodoTelescope<CR>", nore)
-- highlight search result and center cursor
map("n", "n", "nzzzv:call HLNext(0.4)<CR>", nore_silent)
map("n", "N", "Nzzzv:call HLNext(0.4)<CR>", nore_silent)
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
map("i", "?", "?<c-g>u", nore)
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
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", nore)
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
