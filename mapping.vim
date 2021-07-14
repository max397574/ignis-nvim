nnoremap <leader>tsff <cmd>Telescope find_files<CR>
nnoremap <leader>tsts <cmd>Telescope treesitter<CR>

"open window with fix from lsp
nnoremap <leader>fix <CMD>lua vim.lsp.buf.code_action()<CR>
nnoremap <leader>w :w<CR>
nnoremap <silent> <leader>xx :TroubleToggle<CR>

"{{{Markdown
nnoremap <silent> <leader>mdh1 :call MdHeading1()<CR>
nnoremap <silent> <leader>mdh2 :call MdHeading2()<CR>
nnoremap <silent> <leader>mdh3 :call MdHeading3()<CR>
nnoremap <silent> <leader>mda :call MdLink()<CR>
nnoremap <silent> <leader>mdhr :call MdHorizontalRule()<CR>
inoremap <silent> <leader>mdhr <ESC>:call MdHorizontalRule()<CR>
nnoremap <silent> <leader>mdlu :call MdUnorderedList()<CR>
nnoremap <silent> <leader>mdlo :call MdOrderedList()<CR>
inoremap <silent> <leader>mdlu <ESC>:call MdUnorderedList()<CR>
inoremap <silent> <leader>mdlo <ESC>:call MdOrderedList()<CR>
nnoremap <silent> <leader>mdlt :call MdTaskList()<CR>
inoremap <silent> <leader>mdlt <ESC>:call MdTaskList()<CR>
vnoremap <silent> <leader>mdit :call VisualItalic()<CR>
vnoremap <silent> <leader>mdbd :call VisualBold()<CR>
"1}}}

"move line to top of a list
nnoremap <silent> <leader>mt :call MoveLineToTopOfList()<CR>
"fix last spelling error
nnoremap <silent> <leader>sp :call FixLastSpellingError()<CR>
"show list with fixes for spelling
nnoremap <leader>spl [sz=
"use function to mark next search result
nnoremap <silent> n   n:call HLNext(0.4)<CR>
nnoremap <silent> N   N:call HLNext(0.4)<CR>
"better digraphs
inoremap <expr>  <C-K>   BDG_GetDigraph()
"toggle lists (comma separated, bullet)
nmap <silent> <leader>tl  :call ListTrans_toggle_format()<CR>nh
vmap <silent> <leader>tl  :call ListTrans_toggle_format('visual')<CR>nh
nnoremap <silent> nh :nohlsearch<CR>
inoremap jj <ESC>
"shortcut for a often used command
nnoremap S  :%s///g<LEFT><LEFT><LEFT>

"{{{Swap some keys
"Swap commands for visual and visual block mode
nnoremap v <C-V>
nnoremap <C-V> v
xnoremap v <C-V>
xnoremap <C-V> v
"swap , and ; because , is used much more often
nnoremap , ;
nnoremap ; ,
xnoremap , ;
xnoremap ; ,
"1}}}

xnoremap <BS> x
nnoremap <silent> <leader>hp :LvimHelper<CR>
nnoremap <silent> <leader>d :call MoveLineDown()<CR>
nnoremap <silent> <leader>u :call MoveLineUp()<CR>
nnoremap <silent> <leader>" :call Surrondiwquotes()<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
nnoremap <silent> <Leader>ut :UndotreeToggle<CR>
"paste over the current line with <C-P> in normal mode
nnoremap  <C-P> 0d$"*p
"paste over the visual selected block with <C-P> in visual mode
xnoremap  <C-P> "*pgv
"use <leader>yy with a text object to copy to system clipboard
nnoremap <Leader>y "+y
nnoremap <Leader>yy 0"+y$
nnoremap fzf :Files<CR>
"edit init.vim in split
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
"Shift-Tab in visual mode to number lines (numbered list)
xnoremap <S-TAB> :s/\%V/0<C-V><TAB>/<CR>gvg<C-A>gv:retab<ESC>gvI<C-G>u<ESC>gv/ <CR>:s/\%V /./<CR>
nnoremap <silent> <leader>O :call AddLineAbove()<CR>
nnoremap <silent> <leader>o :call AddLineBelow()<CR>
"convert current word to uppercase
inoremap <silent> <c-u> <ESC> :call ConvertWordUppercase()<CR>i
nnoremap <silent> <c-u> :call ConvertWordUppercase()<CR>
"source init.vim
nnoremap <silent> <leader>sv :source ~/.config/nvim/init.vim<CR>
"toggle the tagbar
nnoremap <silent> <Leader>tb :TagbarToggle<CR>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"DistractionFree writing
nnoremap <silent> <leader>df :ZenMode<CR>
"use vmath
vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap         ++  vip++
