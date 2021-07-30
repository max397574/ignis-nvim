inoremap jj <ESC>
"add j and k with count to jumplist
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'

" substitute on visual selection
vnoremap <leader>s :s///g<LEFT><LEFT><LEFT>

"{{{better undo
inoremap , ,<c-g>u
inoremap ! !<c-g>u
inoremap . .<c-g>u
inoremap ? ?<c-g>u
"1}}}

" use vmath on visually selected area
vnoremap <leader>vm <ESC>:Vmath<CR>

"{{{ Visual Multi
let g:VM_maps = {}
let g:VM_maps["Add Cursor Down"]    = '<Leader>cd'   " new cursor down
let g:VM_maps["Add Cursor Up"]      = '<Leader>cu'   " new cursor up
let g:VM_maps['Find Under']         = '<Leader>fu'
"1}}}

"{{{ Telescope mappings
nnoremap <leader>tcff <cmd>Telescope find_files<CR>
nnoremap <leader>tcts <cmd>Telescope treesitter<CR>
nnoremap <leader>tcht <cmd>Telescope help_tags<CR>
"1}}}

"{{{ Snip Run
" run snippet
nnoremap <silent> <leader>rs :SnipRun<CR>
" close result of snippet run
nnoremap <silent> <leader>cs :SnipClose<CR>
" run snippet
vmap <leader>rs <Plug>SnipRun
"1}}}


"open window with fix from lsp
nnoremap <leader>fix <CMD>lua vim.lsp.buf.code_action()<CR>

" easily write file
nnoremap <leader>w :w<CR>

"{{{ Trouble
nnoremap <silent> <leader>trt :TroubleToggle<CR>
nnoremap <silent> <leader>trtd :TodoTrouble<CR>
nnoremap <silent> <leader>trld :Trouble lsp_workspace_diagnostics<CR>
"1}}}

"{{{Markdown
nnoremap <silent> <leader>mdh1 :MdHeading1<CR>
nnoremap <silent> <leader>mdh2 :MdHeading2<CR>
nnoremap <silent> <leader>mdh3 :MdHeading3<CR>
nnoremap <silent> <leader>mda  :MdLink<CR>
nnoremap <silent> <leader>mdhr :call MdHorizontalRule()<CR>
inoremap <silent> <leader>mdhr <ESC>:call MdHorizontalRule()<CR>
nnoremap <silent> <leader>mdlu :MdUnorderedList<CR>
nnoremap <silent> <leader>mdlo :MdOrderedList<CR>
inoremap <silent> <leader>mdlu <ESC>:MdUnorderedList<CR>
inoremap <silent> <leader>mdlo <ESC>:MdOrderedList<CR>
nnoremap <silent> <leader>mdlt :MdTaskList<CR>
inoremap <silent> <leader>mdlt <ESC>:MdTaskList<CR>
vnoremap <silent> <leader>mdit :call VisualItalic()<CR>
vnoremap <silent> <leader>mdbd :call VisualBold()<CR>
"1}}}

" don't move cursor when joining lines
nnoremap J mzJ`z
" highlight search result and center cursor
nnoremap <silent> n   nzzzv:call HLNext(0.4)<CR>
nnoremap <silent> N   Nzzzv:call HLNext(0.4)<CR>
" remove highlighting from search
nnoremap <silent> nh :nohlsearch<CR>
" search and replace in whole file
nnoremap S  :%s///g<LEFT><LEFT><LEFT>

"Swap commands for visual and visual block mode
nnoremap v <C-V>
nnoremap <C-V> v
xnoremap v <C-V>
xnoremap <C-V> v

" delete visual selections with <BS>
xnoremap <BS> x
" open help files
nnoremap <silent> <leader>hp :LvimHelper<CR>
" toggle undotree
nnoremap <silent> <leader>ut :UndotreeToggle<CR>
"paste over the current line with <C-P> in normal mode
nnoremap  <C-P> 0d$"*p
"paste over the visual selected block with <C-P> in visual mode
xnoremap  <C-P> "*pgv
"use <leader>y with a text object to copy to system clipboard
nnoremap <leader>y "+y
"Shift-Tab in visual mode to number lines (numbered list)
xnoremap <S-TAB> :s/\%V/0<C-V><TAB>/<CR>gvg<C-A>gv:retab<ESC>gvI<C-G>u<ESC>gv/ <CR>:s/\%V /./<CR>




" edit macro q
nnoremap <Leader>q :let @t = 'let @q = "' . @q<CR>:<C-f>o<ESC>"tp$a"<Esc>
" move visual blocks up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" move lines up and down in visual and normal mode
inoremap <C-j> <ESC>:m .+1<CR>==i
inoremap <C-k> <ESC>:m .-2<CR>==i
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
" execute macro q
nnoremap Q @q
" insert empty line below/above
nnoremap <leader>o o<ESC>k
nnoremap <leader>O O<ESC>j
" enter space before/after
nnoremap <leader>i i <ESC>l
nnoremap <leader>a a <ESC>h

"convert current word to uppercase
inoremap <silent> <c-u> <ESC> :call ConvertWordUppercase()<CR>i
nnoremap <silent> <c-u> :call ConvertWordUppercase()<CR>
" move throught completitions with tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"DistractionFree writing
nnoremap <silent> <leader>df :ZenMode<CR>
