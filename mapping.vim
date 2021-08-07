"{{{ Telescope mappings
nnoremap <leader>tcff <cmd>Telescope find_files<CR>
nnoremap <leader>tcts <cmd>Telescope treesitter<CR>
nnoremap <leader>tcht <cmd>Telescope help_tags<CR>
nnoremap <leader>tclg <cmd>Telescope live_grep<CR>
"1}}}

"{{{ changes of some keybindings
"add j and k with count to jumplist
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
" highlight search result and center cursor
nnoremap <silent> n   nzzzv:call HLNext(0.4)<CR>
nnoremap <silent> N   Nzzzv:call HLNext(0.4)<CR>
"Swap commands for visual and visual block mode
nnoremap v <C-V>
nnoremap <C-V> v
xnoremap v <C-V>
xnoremap <C-V> v
"}}}

vnoremap <silent> <leader>mdit :call VisualItalic()<CR>
vnoremap <silent> <leader>mdbd :call VisualBold()<CR>

"{{{ Shortcuts for some commands/keybindings
" move throught completitions with tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" move lines up and down in visual and normal mode
inoremap <C-j> <ESC>:m .+1<CR>==i
inoremap <C-k> <ESC>:m .-2<CR>==i
nnoremap <silent> <leader>j :m .+1<CR>==
nnoremap <silent> <leader>k :m .-2<CR>==
"}}}

let g:VM_maps = {}
let g:VM_maps["Add Cursor Down"]    = '<Leader>cd'   " new cursor down
let g:VM_maps["Add Cursor Up"]      = '<Leader>cu'   " new cursor up
let g:VM_maps['Find Under']         = '<Leader>fu'
" run snippet
nnoremap <silent> <leader>sr :SnipRun<CR>
" close result of snippet run
nnoremap <silent> <leader>sc :SnipClose<CR>
" run snippet
vmap <leader>sr <Plug>SnipRun

"{{{ Insert empty space/lines
" insert empty line below/above
nnoremap <leader>o o<ESC>k
nnoremap <leader>O O<ESC>j
" enter space before/after
nnoremap <leader>i i <ESC>l
nnoremap <leader>a a <ESC>h
"}}}

"{{{ Better undo
inoremap , ,<c-g>u
inoremap ! !<c-g>u
inoremap . .<c-g>u
inoremap ? ?<c-g>u
"1}}}
