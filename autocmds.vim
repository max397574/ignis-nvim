
augroup SexNoArgs
    autocmd!
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | Sex | wincmd j | close | endif
augroup END

augroup tab_completition
    autocmd!
    "use <Tab> to go through list of completitions
    au VimEnter * inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
    au VimEnter * inoremap <expr> <s-Tab> pumvisible() ? "\<C-p>" : "\<s-Tab>"
augroup END

augroup random
    autocmd!
    "autocmd BufNewFile,BufRead,BufWinEnter * set formatoptions="cqrnj"
    au BufWinEnter *.{py,java,html,c,cpp,cs,vim} 
      \let w:m1=matchadd('Search', '\%<81v.\%>80v', -1)
augroup END

augroup filetypes
    autocmd!
    autocmd BufNewFile,BufRead,BufWinEnter *.html syntax on
    autocmd BufNewFile,BufRead,BufWinEnter *.{md,txt,html} set spell
    autocmd BufNewFile,BufRead,BufWinEnter *.vim set foldmethod=marker
    autocmd BufNewFile,BufRead,BufWinEnter *.md set conceallevel=0
    autocmd BufNewFile,BufRead,BufWinEnter *.lua set shiftwidth=2
    autocmd BufNewFile,BufRead,BufWinEnter *.lua set tabstop=2
    autocmd BufNewFile,BufRead,BufWinEnter *.py set tabstop=4
    autocmd BufNewFile,BufRead,BufWinEnter *.java set tabstop=4
    autocmd BufNewFile,BufRead,BufWinEnter * set formatoptions-=o
    "class with filename and class main
    autocmd BufNewFile *.java
      \ exe "normal Opublic class " . expand('%:t:r') . "{\npublic static void main(String[] args) {\n}\n}\<Esc>"

augroup END


augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END

let ErrorMsg='Duplicate edit session (readonly)'
augroup NoSimultaneousEdits
    autocmd!
    autocmd SwapExists * let v:swapchoice = 'o'
    autocmd SwapExists * echomsg ErrorMsg
    autocmd SwapExists * echo 'Duplicate edit session (readonly)'
    autocmd SwapExists * echohl None
    autocmd SwapExists * sleep 2
augroup END
