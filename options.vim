"use space as <leader> key
let mapleader = ' '
set conceallevel=0
"height of the commandline
set cmdheight=2
set termguicolors
"don't wrap lines when they are longer than screenwidth
set nowrap
set softtabstop=4
set shiftwidth=4
set expandtab
set updatetime=2000
set hidden
set completeopt=menuone,noselect
"time between characters of commands (ms)
set timeoutlen=300
highlight clear Search
"live preview of s command
set inccommand=nosplit
"line numbers
set number
"signcolumn is always activated
set signcolumn=yes
"color line where cursor is
set cursorline
"relative line numbers make it easier to repeat commands
set relativenumber
"undofiles are stored here
set undodir=~/.vim/undodir
set undofile
"start scrolling when cursor is 8 lines from top/bottom
set scrolloff=8

"use TreeSitter for folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
"function for custom fold text
function! MyFoldText()
    let line = getline(v:foldstart)
    let folded_line_num = v:foldend - v:foldstart
    let line_text = substitute(line, '^"{\+', '', 'g')
    let fillcharcount = &textwidth - len(line_text) + 2
    return '+'. line_text . repeat('.', fillcharcount) . ' (' . folded_line_num . ' L)'
endfunction
"use the text of the function above
set foldtext=MyFoldText()
