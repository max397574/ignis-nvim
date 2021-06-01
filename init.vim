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

"backspace behaves like exspected (goes over eol etc.)
set backspace=start,indent,eol

set hidden


let $RC="/Users/andri/.vimrc"


let $RTP=split(&runtimepath, ',')[0]


set shiftwidth=4 


set tabstop=4 softtabstop=4 


set expandtab 


set autoindent 


set exrc

"use relative line numbers for easier use of repeating commands (eg d10j)
set relativenumber

"use line numbers
set nu

"highlight search results
set hlsearch

"turn of the error bell
set noerrorbells

"no wrap at end
set nowrap


set noswapfile


set nobackup


set undodir=~/.vim/undodir

"set timoutlen (time for commands consisting of multiple keystrokes) to 300ms
set timeoutlen=300

"allow virtualedit (go over end of line) in virtual block mode
set virtualedit=block


set undofile

"show where matches are while searching
set incsearch


set completeopt=menuone,noselect


set wildmenu


set termguicolors

"start scrolling when cursor is 8 lines above the bottom
set scrolloff=8


set signcolumn=yes

"the space for commands is 2 lines high
set cmdheight=2


set scl=yes

"turn bell off
set belloff=all

"set a line, where the cursor is
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

"easier configuration of built in lsp
Plug 'neovim/nvim-lspconfig'

"a colorscheme
Plug 'gruvbox-community/gruvbox'

"statusline plugin
Plug 'itchyny/lightline.vim'

"automatically color nested brackets
Plug 'frazrepo/vim-rainbow'

"show lokations of all marks <leader>mb
Plug 'Yilin-Yang/vim-markbar'

"automatically add second one of (, [ etc.
Plug 'jiangmiao/auto-pairs'

"use multiple cursors <leader>cd <leader>cu <leader>fu
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

"comment out lines <leader>cc
Plug 'preservim/nerdcommenter'

"plugin for better latex coding in vim
Plug 'lervag/vimtex'

"highlight the text that was janked for a short time
Plug 'machakann/vim-highlightedyank'

"a colorscheme
Plug 'folke/tokyonight.nvim'

"automatically change closing html tag when changning opening tag
Plug 'AndrewRadev/tagalong.vim'

"<leader>t to toggle a floating terminal
Plug 'voldikss/vim-floaterm'

"snippets, view with <leader>sp
Plug 'SirVer/ultisnips'


Plug 'ap/vim-templates'


Plug 'honza/vim-snippets'

"plugin for add and change surroundings <leader>ys<text-object><surrounding to add>
"<leader>cs<old surrounding><new surrounding>
Plug 'tpope/vim-surround' 

"easily fold stuff
Plug 'pseewald/vim-anyfold'

"syntax checking for python
Plug 'davidhalter/jedi'

"file finder activate with 'fzf'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

"better fzf for vim
Plug 'junegunn/fzf.vim'

"completition plugin
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }


Plug 'akinsho/nvim-bufferline.lua'


Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}


Plug 'nvim-treesitter/playground'

"show tree with latest changes and diff in buffer <leader>ut 
Plug 'mbbill/undotree'


Plug 'nvim-lua/popup.nvim'
Plug 'skywind3000/asyncrun.vim'
Plug 'nvim-lua/plenary.nvim'

"show vertical lines where indents are
Plug 'Yggdroot/indentLine'

":goyo for disctraction free writing
Plug 'junegunn/goyo.vim'

"file finder <leader>ff
Plug 'nvim-telescope/telescope.nvim'

"tagbar with functions variables etc <leader>tb
Plug 'preservim/tagbar'

"more icons
Plug 'ryanoasis/vim-devicons'


Plug 'ThePrimeagen/vim-apm'

"more icons
Plug 'kyazdani42/nvim-web-devicons'

"deoplete completition with jedi as source
Plug 'deoplete-plugins/deoplete-jedi'


Plug 'mattn/webapi-vim'


Plug 'christoomey/vim-quicklink'

"pull visual selected blocks around with arrows
Plug 'zirrostig/vim-schlepp'

"easily install new lsp servers
Plug 'kabouzeid/nvim-lspinstall'

"visually show lsp errors <leader>tt for list 
Plug 'folke/trouble.nvim'

"auto completitioin for nvim
Plug 'hrsh7th/nvim-compe'

"file explorer
"show git status of files in nerdtree
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'

"better colors for lsp
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


"..........................................................lspinstall
lua << EOF
    require'lspinstall'.setup() -- important

    local servers = require'lspinstall'.installed_servers()
    for _, server in pairs(servers) do
      require'lspconfig'[server].setup{}
    end
EOF

"..........................................................Lspconfig

lua << EOF
    require'lspconfig'.pyright.setup{}
    require'lspconfig'.pyls.setup{}
    require'lspconfig'.html.setup{}
    require'lspconfig'.jedi_language_server.setup{}
    require'lspconfig'.tsserver.setup{}
    require'lspconfig'.cssls.setup {
         capabilities = capabilities,
        }
    require'lspconfig'.html.setup {
         capabilities = capabilities,
        }
    require'lspconfig'.html.setup{}
EOF


"..........................................................trouble.nvim
lua << EOF
  require("trouble").setup {
  }
EOF




" Use deoplete.
let g:deoplete#enable_at_startup = 1


"..........................................................nvim-compe
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
    "class with filename and class main
    autocmd BufNewFile *.java
      \ exe "normal Opublic class " . expand('%:t:r') . "{\npublic static void main(String[] args) {\n}\n}\<Esc>2G"

augroup END

"  ___ ___ .__       .__    .__  .__       .__     __          
" /   |   \|__| ____ |  |__ |  | |__| ____ |  |___/  |_  ______
"/    ~    \  |/ ___\|  |  \|  | |  |/ ___\|  |  \   __\/  ___/
"\    Y    /  / /_/  >   Y  \  |_|  / /_/  >   Y  \  |  \___ \ 
" \___|_  /|__\___  /|___|  /____/__\___  /|___|  /__| /____  >
"       \/   /_____/      \/       /_____/      \/          \/ 


"line number where cursor is has different color
highlight CursorLineNr term=bold ctermfg=11 gui=bold guifg=Yellow 


highlight Normal guibg=none


highlight NonText guibg=none


highlight Normal ctermbg=none


highlight NonText ctermbg=none


highlight Normal ctermbg=red guibg=red


colorscheme gruvbox


set background=dark " use dark mode


" set background=light " uncomment to use light mode

"comments are important :)
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

"user <leader>tt to toggle trouble.nvim
nnoremap <leader>tt :TroubleToggle<cr>
