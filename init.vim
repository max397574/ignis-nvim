"   ____________  _____    _____      ____________    ________    ________ _______    ______   ____________         ___________
"  /            \|\    \   \    \    /            \  /        \  /        \\      |  |      | /            \       /           \
" |\___/\  \\___/|\\    \   |    |  |\___/\  \\___/||\         \/         /||     /  /     /||\___/\  \\___/|     /    _   _    \
"  \|____\  \___|/ \\    \  |    |   \|____\  \___|/| \            /\____/ ||\    \  \    |/  \|____\  \___|/    /    //   \\    \
"        |  |       \|    \ |    |         |  |     |  \______/\   \     | |\ \    \ |    |         |  |        /    //     \\    \
"   __  /   / __     |     \|    |    __  /   / __   \ |      | \   \____|/  \|     \|   |    __  /   / __    /     \\_____//     \
"  /  \/   /_/  |   /     /\      \  /  \/   /_/  |   \|______|  \   \        |\         /|   /  \/   /_/  |  /       \ ___ /       \
" |____________/|  /_____/ /______/||____________/|            \  \___\ ___   | \_______/ |  |____________/| /________/|   |\________\
" |           | / |      | |     | ||           | /             \ |   ||   |   \ |     | /   |           | /|        | |   | |        |
" |___________|/  |______|/|_____|/ |___________|/               \|___||___|    \|_____|/    |___________|/ |________|/     \|________|


set nocompatible
filetype plugin on
syntax on
filetype plugin indent on
set backspace=start,indent,eol
set hidden
let $RC="/Users/andri/.vimrc"
let $RTP=split(&runtimepath, ',')[0]
set shiftwidth=4 
set tabstop=4 softtabstop=4 
set expandtab 
set autoindent 
set exrc
set relativenumber
set encoding=UTF-8
set nu
set hlsearch
set noerrorbells
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set wildmenu
set termguicolors
set scrolloff=8
set signcolumn=yes
set cmdheight=2
set scl=yes
set belloff=all
set cursorline

set splitbelow

" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

let g:livepreview_engine = 'skim'
let g:livepreview_previewer = 'evince'

" disable autocompletion, because we use deoplete for completion
let g:jedi#completions_enabled = 0

" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"


set tags+=$HOME


let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:deoplete#enable_at_startup = 1

"__________.__               .__               
"\______   \  |  __ __  ____ |__| ____   ______
" |     ___/  | |  |  \/ ___\|  |/    \ /  ___/
" |    |   |  |_|  |  / /_/  >  |   |  \\___ \ 
" |____|   |____/____/\___  /|__|___|  /____  >
"                    /_____/         \/     \/ 


call plug#begin('~/.vim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'frazrepo/vim-rainbow'
Plug 'Yilin-Yang/vim-markbar'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'conornewton/vim-latex-preview'
Plug 'preservim/nerdcommenter'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'preservim/nerdtree'
Plug 'lervag/vimtex'
Plug 'machakann/vim-highlightedyank'
Plug 'folke/tokyonight.nvim'
Plug 'voldikss/vim-floaterm'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround' 
Plug 'pseewald/vim-anyfold'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'nvim-lua/popup.nvim'
Plug 'skywind3000/asyncrun.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'preservim/tagbar'
Plug 'zchee/deoplete-jedi'
Plug 'dense-analysis/ale'
Plug 'davidhalter/jedi-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'zirrostig/vim-schlepp'
Plug 'folke/lsp-colors.nvim'
Plug 'folke/lsp-trouble.nvim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
call plug#end()


"activate Plugins
let g:rainbow_active = 1
let g:ale_completion_enabled = 1



" Start NERDTree and leave the cursor in it.
"autocmd VimEnter * NERDTree
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

set laststatus=2
if !has('gui_running')
  set t_Co=256
endif

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ],
      \ }
      \ }

" ___________              __    ________ ___.        __               __
" \__    ___/___ ___  ____/  |_  \_____  \\_ |__     |__| ____   _____/  |_  ______
"   |    |_/ __ \\  \/  /\   __\  /   |   \| __ \    |  |/ __ \_/ ___\   __\/  ___/
"   |    |\  ___/ >    <  |  |   /    |    \ \_\ \   |  \  ___/\  \___|  |  \___ \
"   |____| \___  >__/\_ \ |__|   \_______  /___  /\__|  |\___  >\___  >__| /____  >
"              \/      \/                \/    \/\______|    \/     \/          \/
" in( for inside next ()
onoremap in( :<c-u>normal! f(vi(<cr>

"               __                                                         .___      
"_____   __ ___/  |_  ____   ____  ____   _____   _____ _____    ____    __| _/______
"\__  \ |  |  \   __\/  _ \_/ ___\/  _ \ /     \ /     \\__  \  /    \  / __ |/  ___/
" / __ \|  |  /|  | (  <_> )  \__(  <_> )  Y Y  \  Y Y  \/ __ \|   |  \/ /_/ |\___ \ 
"(____  /____/ |__|  \____/ \___  >____/|__|_|  /__|_|  (____  /___|  /\____ /____  >
"     \/                        \/            \/      \/     \/     \/      \/    \/ 


augroup ActivatePlugins
    autocmd!
    au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>80v', -1)
    au ColorScheme * highlight Normal ctermbg=none guibg=none
    autocmd VimEnter * AnyFoldActivate
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    au BufWinEnter,BufRead,BufNewFile * RainbowToggle
    "Toggle Rainbowbrackets
augroup END

augroup FileHeaders
    autocmd!
    "Auto beginning depending on file type
    "
    "
    "For .java
    "class with filename and class main
    autocmd BufNewFile *.java
      \ exe "normal Opublic class " . expand('%:t:r') . "{\n\tpublic static void main(String[] args) {\n\n}\n}\<Esc>3G"
    
    "For .c
    "include main librarys and create main function


    "for .tex
    "write document start and end
augroup END

"  ___ ___ .__       .__    .__  .__       .__     __          
" /   |   \|__| ____ |  |__ |  | |__| ____ |  |___/  |_  ______
"/    ~    \  |/ ___\|  |  \|  | |  |/ ___\|  |  \   __\/  ___/
"\    Y    /  / /_/  >   Y  \  |_|  / /_/  >   Y  \  |  \___ \ 
" \___|_  /|__\___  /|___|  /____/__\___  /|___|  /__| /____  >
"       \/   /_____/      \/       /_____/      \/          \/ 


highlight CursorLineNr term=bold ctermfg=11 gui=bold guifg=Yellow 
highlight ColorColumn ctermbg=red ctermfg=red guibg=red guifg=red
highlight Normal guibg=none
highlight NonText guibg=none
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight Normal ctermbg=red guibg=red
colorscheme gruvbox
set background=dark " use dark mode
" set background=light " uncomment to use light mode
highlight Comment term=bold cterm=italic ctermfg=white gui=italic guifg=white






"   _____                       .__                      
"  /     \ _____  ______ ______ |__| ____    ____  ______
" /  \ /  \\__  \ \____ \\____ \|  |/    \  / ___\/  ___/
"/    Y    \/ __ \|  |_> >  |_> >  |   |  \/ /_/  >___ \ 
"\____|__  (____  /   __/|   __/|__|___|  /\___  /____  >
"        \/     \/|__|   |__|           \//_____/     \/ 

let mapleader= " "

"espace insert mode with jj
inoremap jj <ESC>
"use diw and dd in insert mode
inoremap diw <ESC>diwi
inoremap <leader>dd <ESC>ddi

"swap mappings for visual and visual block mode
nnoremap v <C-V>
nnoremap <C-V> v

xnoremap v <C-V>
xnoremap <C-V> v

" Use space to jump down a page (like browsers do)...
nnoremap   <Space> <PageDown>
xnoremap   <Space> <PageDown>

"drag visual blocks around with arrow keys
xmap <up>    <Plug>SchleppUp
xmap <down>  <Plug>SchleppDown
xmap <left>  <Plug>SchleppLeft
xmap <right> <Plug>SchleppRight

"use D to drag a duplicate of block to the left
xmap D       <Plug>SchleppDupLeft

"toggle markbar
nmap <Leader>mb <Plug>ToggleMarkbar

"telescope find files
nnoremap <leader>ff <cmd>Telescope find_files<cr>

"ToggleTagbar with <leader>tb
nnoremap <leader>tb :TagbarToggle<CR>

"help file for quick command reference
nnoremap <leader>hp :vsplit ~/vimhelp.txt<cr>

"Quickly insert an empty new line without entering insert mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

"Cut and paste from the system clipboard

" When in Normal mode, paste over the current line...
nnoremap  <C-P> 0d$"*p

" When in Visual mode, paste over the selected region...
xnoremap  <C-P> "*pgv

"go through auto-completition with tab
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"toggle floating Terminal
nnoremap <silent> <Leader>t   :FloatermToggle<CR>
"toggle floating Terminal in terminal-mode
tnoremap <silent> <Leader>t   <C-\><C-n>:FloatermToggle<CR>

"start new line with \ (used for latex)
nnoremap <Leader>7 o\

"toggle latex preview
nnoremap <Leader>lp :StartLatexPreview<CR> 

let g:VM_maps = {}
let g:VM_maps["Add Cursor Down"]    = '<Leader>cd'   " new cursor down
let g:VM_maps["Add Cursor Up"]      = '<Leader>cu'   " new cursor up
let g:VM_maps['Find Under']         = '<Leader>fu'

"use <leader>yy to copy to system clipboard
nnoremap <Leader>yy "+y

"edit vimrc
:nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<cr>
