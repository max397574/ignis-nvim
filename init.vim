
" /$$           /$$   /$$                /$$
"|__/          |__/  | $$               |__/
" /$$ /$$$$$$$  /$$ /$$$$$$   /$$    /$$ /$$ /$$$$$$/$$$$
"| $$| $$__  $$| $$|_  $$_/  |  $$  /$$/| $$| $$_  $$_  $$
"| $$| $$  \ $$| $$  | $$     \  $$/$$/ | $$| $$ \ $$ \ $$
"| $$| $$  | $$| $$  | $$ /$$  \  $$$/  | $$| $$ | $$ | $$
"| $$| $$  | $$| $$  |  $$$$//$$\  $/   | $$| $$ | $$ | $$
"|__/|__/  |__/|__/   \___/ |__/ \_/    |__/|__/ |__/ |__/

"use :set foldmethod=marker in vim

"{{{============================================================== Sets

"{{{.............................................................. General
"use space as <leader> key
let mapleader = ' '
set conceallevel=0
"height of the commandline
set cmdheight=2
set mouse=a
set termguicolors
"don't wrap lines when they are longer than screenwidth
set nowrap
set softtabstop=4
set shiftwidth=4
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
"2}}}

"{{{.............................................................. Folding

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
"2}}}

"}}}

"{{{============================================================== Source

luafile ~/.config/nvim/plugin_settings/lsp.lua
luafile ~/.config/nvim/plugin_settings/twilight.lua
luafile ~/.config/nvim/plugin_settings/which_key.lua
luafile ~/.config/nvim/plugin_settings/todo-comments.lua
luafile ~/.config/nvim/plugin_settings/lvim_helper.lua
luafile ~/.config/nvim/plugin_settings/telescope.lua
luafile ~/.config/nvim/plugin_settings/treesitter.lua
source ~/.config/nvim/mapping.vim
source ~/.config/nvim/spelling.vim
source ~/.config/nvim/plugin_settings/markdown_preview.vim
source ~/.config/nvim/plugin_settings/tablemode.vim
source ~/.config/nvim/plugin_settings/limelight.vim
source ~/.config/nvim/plugin_settings/indentline.vim
let s:prefix = '~/.config/nvim/plugins'
for s:fname in glob(s:prefix . '/**/*.vim', 1, 1)
    execute 'source' s:fname
endfor

"}}}

"{{{============================================================== Plugins

call plug#begin('~/.vim/plugged')

"{{{Colorschemes
"a colorscheme
Plug 'monsonjeremy/onedark.nvim'
"generate colorschemes
Plug 'tjdevries/colorbuddy.vim'
"gruvbox for nvim
Plug 'tjdevries/gruvbuddy.nvim'
"a colorscheme
Plug 'savq/melange'
"a colorscheme
Plug 'morhetz/gruvbox'
"a colorscheme
Plug 'eddyekofo94/gruvbox-flat.nvim'
"a colorscheme
Plug 'folke/tokyonight.nvim'
"2}}}

Plug '~/jump-ray'
Plug '~/mark-ray'
Plug 'tzachar/compe-tabnine', { 'do': './install.sh' }
Plug 'tweekmonster/startuptime.vim'
Plug 'max397574/nvim-whid'
"use f after f{char} to jump to next occurence
Plug 'folke/zen-mode.nvim'
Plug 'folke/lua-dev.nvim'
Plug 'folke/twilight.nvim'
Plug 'rhysd/clever-f.vim'
"motion like f and t but with 2 letters
Plug 'justinmk/vim-sneak'
"preview markdown in browser
Plug 'JamshedVesuna/vim-markdown-preview'
"better visual mode
Plug 'vim-scripts/vis'
"easily create tables
Plug 'dhruvasagar/vim-table-mode'
"Displays suggestions for key bindings
Plug 'folke/which-key.nvim'
"automatically add pairs for (['"{ etc.
Plug 'jiangmiao/auto-pairs'
"move around visual blocks
Plug 'zirrostig/vim-schlepp'
"multiple cursors
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
"a floating terminal
Plug 'voldikss/vim-floaterm'
"vertical lines at indents
Plug 'Yggdroot/indentLine'
"snippets
Plug 'sirver/UltiSnips'
"easily add and change surrondings
Plug 'tpope/vim-surround'
"snippets for ultisnips
Plug 'honza/vim-snippets'
"sql support for nvim
Plug 'tami5/sql.nvim'
"Calculate average sum etc
Plug 'drxcc/vim-vmath'
"highlight word under cursor everywhere
Plug 'yamatsum/nvim-cursorline'
"easily comment out code
Plug 'preservim/nerdcommenter'
"display structure of file (variables,functions etc)
Plug 'preservim/tagbar'
"game to practice movements
Plug 'ThePrimeagen/vim-be-good'
"show last changes in list and last change in signcolumn
Plug 'mbbill/undotree'
"Show git symbols in signcolumn
Plug 'mhinz/vim-signify'
Plug 'folke/todo-comments.nvim'
"a file explorer
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"fzf vim integration
Plug 'junegunn/fzf.vim'
"run a selected part of code
Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
Plug 'sharkdp/bat'
"expand html 'snippets'
Plug 'mattn/emmet-vim'
"color nested brackets in different colors
Plug 'luochen1990/rainbow'
"telescope dependency
Plug 'nvim-lua/popup.nvim'
"telescope dependency
Plug 'nvim-lua/plenary.nvim'
"a file explorer
Plug 'nvim-telescope/telescope.nvim'
"more icons
Plug 'ryanoasis/vim-devicons'
"even more icons
Plug 'kyazdani42/nvim-web-devicons'
"test code from inside nvim
Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }
"list and display lsp diagnostic
"Plug 'folke/trouble.nvim'
"easily display help files
Plug 'lvim-tech/lvim-helper'
"distraction free writing
Plug 'junegunn/limelight.vim'
Plug 'hrsh7th/nvim-compe'
"nvim lsp
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'folke/lsp-colors.nvim'
Plug 'folke/trouble.nvim'

". . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  TreeSitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'
Plug 'romgrk/nvim-treesitter-context'

call plug#end()
"}}}

"{{{============================================================== Plugin Settings

"{{{.............................................................. Lua Dev

lua << EOF
local luadev = require("lua-dev").setup({
  -- add any options here, or leave empty to use the default settings
  -- lspconfig = {
  --   cmd = {"lua-language-server"}
  -- },
})

local lspconfig = require('lspconfig')
lspconfig.sumneko_lua.setup(luadev)
EOF
"2}}}

"{{{.............................................................. Compe

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}

let g:compe.source.tabnine = {}
let g:compe.source.tabnine.max_line = 1000
let g:compe.source.tabnine.max_num_results = 6
let g:compe.source.tabnine.priority = 5000
let g:compe.source.tabnine.sort = v:false
let g:compe.source.tabnine.show_prediction_strength = v:true
let g:compe.source.tabnine.ignore_pattern = ''

let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true

let g:compe.source.nvim_lsp = {}
let g:compe.source.nvim_lsp.max_num_results = 5
let g:compe.source.nvim_lsp.max_line = 100

let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true
"2}}}

"{{{.............................................................. NERDTree
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

let g:NERDTreeGitStatusUseNerdFonts = 1
"2}}}

"{{{.............................................................. Emmet

let g:user_emmet_leader_key='<leader>emmet'
"2}}}

"{{{.............................................................. VisualMulti

let g:VM_maps = {}
let g:VM_maps["Add Cursor Down"]    = '<Leader>cd'   " new cursor down
let g:VM_maps["Add Cursor Up"]      = '<Leader>cu'   " new cursor up
let g:VM_maps['Find Under']         = '<Leader>fu'
"2}}}

"{{{.............................................................. Floaterm

"toggle floating Terminal
nnoremap <silent> <Leader>ft   :FloatermToggle<CR>
"toggle floating Terminal in terminal-mode
tnoremap <silent> <Leader>ft   <C-\><C-n>:FloatermToggle<CR>
"2}}}

"{{{.............................................................. Schlepp

"Move visual selected blocks with arrow keys
xmap <up>    <Plug>SchleppUp
xmap <down>  <Plug>SchleppDown
xmap <left>  <Plug>SchleppLeft
xmap <right> <Plug>SchleppRight
"use D to move a copy of a visual selected block
xmap D       <Plug>SchleppDupLeft
"2}}}

"{{{.............................................................. NERDCommenter

"Create default mappings
let g:NERDCreateDefaultMappings = 1

"Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 0

"Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

"Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

"Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

"Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

"Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

"Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

"Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

"use same mapping in insert mode 
imap <leader>cc <ESC><leader>cc
"2}}}

"1}}}

"{{{============================================================== Autocommands

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
    au BufWinEnter *.{py,java,html,c,cpp,cs,vim} 
      \let w:m1=matchadd('Search', '\%<81v.\%>80v', -1)
augroup END

"{{{.............................................................. Filetypes
augroup filetypes
    autocmd!
    autocmd BufNewFile,BufRead,BufWinEnter *.html syntax on
    autocmd BufNewFile,BufRead,BufWinEnter *.{md,txt,html} set spell
    autocmd BufNewFile,BufRead,BufWinEnter *.vim set foldmethod=marker
    autocmd BufNewFile,BufRead,BufWinEnter *.md set conceallevel=0
    autocmd BufNewFile,BufRead,BufWinEnter *.lua set shiftwidth=2
    "class with filename and class main
    autocmd BufNewFile *.java
      \ exe "normal Opublic class " . expand('%:t:r') . "{\npublic static void main(String[] args) {\n}\n}\<Esc>"

augroup END
"2}}}


"{{{.............................................................. HighlightYank
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END
"2}}}

"{{{.............................................................. NoSimultaneousEdits
let ErrorMsg='Duplicate edit session (readonly)'
augroup NoSimultaneousEdits
    autocmd!
    autocmd SwapExists * let v:swapchoice = 'o'
    autocmd SwapExists * echomsg ErrorMsg
    autocmd SwapExists * echo 'Duplicate edit session (readonly)'
    autocmd SwapExists * echohl None
    autocmd SwapExists * sleep 2
augroup END
"2}}}

"1}}}

"{{{============================================================== Highlights

colorscheme gruvbox
"line number where cursor is has different color
highlight CursorLineNr term=bold ctermfg=11 gui=bold guifg=Yellow

"the search results
highlight       Search    ctermfg=White  ctermbg=Black  cterm=bold
"the first search result
highlight    IncSearch    ctermfg=White  ctermbg=grey   cterm=bold

set background=dark

highlight GreenString guifg=#207245
highlight BlueOperator guifg=#3572A5
highlight BlueNumber guifg=#519ABA
highlight RedConditional guifg=#B30B00
highlight YellowVariable ctermfg=214 guifg=#FABD2F
highlight PurpleBoolean guifg=#6600CC
highlight LightBlueConstant guifg=#009999
highlight RedLoops guifg=#CC0000


highlight LspDiagnosticsDefaultError ctermbg=none guibg=none ctermfg=167 guifg=#FB4934
highlight LspDiagnosticsDefaultHint ctermbg=none guibg=none ctermfg=109 guifg=#83A598
highlight LspDiagnosticsDefaultWarning ctermbg=none guibg=none ctermfg=208 guifg=#FE8019
highlight LspDiagnosticsDefaultInformation ctermbg=none guibg=none ctermfg=214 guifg=#FABD2F


highlight ItalicRed term=italic ctermfg=12 gui=italic guifg=#b30b00
highlight Folded term=bold cterm=italic ctermfg=white gui=italic guifg=white
highlight Folded guibg=none ctermbg=none

"transparent background
highlight  Normal   guibg=none
highlight  Normal   ctermbg=none
highlight NonText   ctermbg=none
highlight NonText   guibg=none
hi! EndOfBuffer ctermbg=none ctermfg=none guibg=none guifg=none

"comments are important :)
highlight Comment term=bold cterm=italic ctermfg=white gui=italic guifg=white
highlight WhiteOnRed ctermbg=red guibg=red ctermfg=white guifg=white

function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#\%('.@/.'\)'
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction
"}}}

"{{{============================================================== Misc

set nowrap
"Square up visual selections...
set virtualedit=block
"}}}
