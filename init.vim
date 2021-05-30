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
set nu
set hlsearch
set noerrorbells
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set timeoutlen=300
set undofile
set incsearch
set completeopt=menuone,noselect
set wildmenu
set termguicolors
set scrolloff=8
set signcolumn=yes
set cmdheight=2
set scl=yes
set belloff=all
set cursorline

set splitbelow
set laststatus=2
if !has('gui_running')
  set t_Co=256
endif

set tags+=$HOME

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:deoplete#enable_at_startup = 1


"   _____ ___.  ___.                      .__        __  .__                      
"  /  _  \\_ |__\_ |_________   _______  _|__|____ _/  |_|__| ____   ____   ______
" /  /_\  \| __ \| __ \_  __ \_/ __ \  \/ /  \__  \\   __\  |/  _ \ /    \ /  ___/
"/    |    \ \_\ \ \_\ \  | \/\  ___/\   /|  |/ __ \|  | |  (  <_> )   |  \\___ \ 
"\____|__  /___  /___  /__|    \___  >\_/ |__(____  /__| |__|\____/|___|  /____  >
"        \/    \/    \/            \/             \/                    \/     \/

ab lenght length

"__________.__               .__               
"\______   \  |  __ __  ____ |__| ____   ______
" |     ___/  | |  |  \/ ___\|  |/    \ /  ___/
" |    |   |  |_|  |  / /_/  >  |   |  \\___ \ 
" |____|   |____/____/\___  /|__|___|  /____  >
"                    /_____/         \/     \/ 
call plug#begin('~/.vim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'gruvbox-community/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'frazrepo/vim-rainbow'
Plug 'Yilin-Yang/vim-markbar'
Plug 'jiangmiao/auto-pairs'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'preservim/nerdcommenter'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lervag/vimtex'
Plug 'machakann/vim-highlightedyank'
Plug 'folke/tokyonight.nvim'
Plug 'voldikss/vim-floaterm'
Plug 'preservim/nerdcommenter'
Plug 'SirVer/ultisnips'
Plug 'ap/vim-templates'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround' 
Plug 'pseewald/vim-anyfold'
Plug 'davidhalter/jedi'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'akinsho/nvim-bufferline.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'mbbill/undotree'
Plug 'nvim-lua/popup.nvim'
Plug 'skywind3000/asyncrun.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/goyo.vim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'preservim/tagbar'
Plug 'ryanoasis/vim-devicons'
Plug 'ThePrimeagen/vim-apm'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'mattn/webapi-vim'
Plug 'christoomey/vim-quicklink'
Plug 'zirrostig/vim-schlepp'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'folke/trouble.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'folke/lsp-colors.nvim'
call plug#end()

"----------------------------------------------------------Plugin Settings

"..........................................................NerdTree Git
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

"..........................................................Lspconfig

lua << EOF
    require'lspconfig'.pyright.setup{}
    require'lspconfig'.pyls.setup{}
    require'lspconfig'.jedi_language_server.setup{}
EOF


"..........................................................trouble.nvim
lua << EOF
  require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF


"..........................................................lspinstall
lua << EOF
    require'lspinstall'.setup() -- important

    local servers = require'lspinstall'.installed_servers()
    for _, server in pairs(servers) do
      require'lspconfig'[server].setup{}
    end
EOF


" Use deoplete.
let g:deoplete#enable_at_startup = 1


"..........................................................nvim-compe
let g:compe = {}

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true

highlight link CompeDocumentation NormalFloat

lua << EOF
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = true;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    ultisnips = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
    zsh = true;
  };
}

EOF

"..........................................................NerdCommenter

" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1




let g:jedi#completions_enabled = 0

" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"
let g:rainbow_active = 1

" Start NERDTree and leave the cursor in it.
"autocmd VimEnter * NERDTree
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'absolutepath', 'modified' ] ],
      \ }
      \ }

set encoding=UTF-8

let g:indentLine_setColors = 0
let g:indentLine_char = '┆'



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

augroup filetypes 
    autocmd!
    "Auto beginning depending on file type
    "
    "
    "For .java
    "class with filename and class main
    autocmd BufNewFile *.java
      \ exe "normal Opublic class " . expand('%:t:r') . "{\npublic static void main(String[] args) {\n}\n}\<Esc>2G"

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

"<leader>xx to toggle LspTrouble
nnoremap <leader>xx <cmd>TroubleToggle<cr>

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
nnoremap <leader>hp :vsplit ~/.config/nvim/vimhelp.txt<cr>

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
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<cr>

let g:UltiSnipsExpandTrigger="<tab>"
" list all snippets for current filetype
nnoremap <leader>sp :Snippets<cr>

"use <leader>il to toggle indenlines
nnoremap <leader>il :IndentLinesToggle<cr>

"use <leader>nt to toggle nerdtree
nnoremap <leader>nt :NERDTreeToggle<cr>

"use <leader>ut to toggle undotree
nnoremap <leader>ut :UndotreeToggle<cr>

"use fzf for fzf
nnoremap fzf :Files<cr>
