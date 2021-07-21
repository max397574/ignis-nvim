
" /$$           /$$   /$$                /$$
"|__/          |__/  | $$               |__/
" /$$ /$$$$$$$  /$$ /$$$$$$   /$$    /$$ /$$ /$$$$$$/$$$$
"| $$| $$__  $$| $$|_  $$_/  |  $$  /$$/| $$| $$_  $$_  $$
"| $$| $$  \ $$| $$  | $$     \  $$/$$/ | $$| $$ \ $$ \ $$
"| $$| $$  | $$| $$  | $$ /$$  \  $$$/  | $$| $$ | $$ | $$
"| $$| $$  | $$| $$  |  $$$$//$$\  $/   | $$| $$ | $$ | $$
"|__/|__/  |__/|__/   \___/ |__/ \_/    |__/|__/ |__/ |__/

" use :set foldmethod=marker in vim
" TODO: Add terrortylor/nvim-comment

let mapleader = ' '

"{{{============================================================== Source

luafile ~/.config/nvim/options.lua
luafile ~/.config/nvim/plugin_settings/lsp.lua
luafile ~/.config/nvim/plugin_settings/comment.lua
luafile ~/.config/nvim/plugin_settings/twilight.lua
luafile ~/.config/nvim/plugin_settings/which_key.lua
luafile ~/.config/nvim/plugin_settings/todo-comments.lua
luafile ~/.config/nvim/plugin_settings/lvim_helper.lua
luafile ~/.config/nvim/plugin_settings/telescope.lua
luafile ~/.config/nvim/plugin_settings/treesitter.lua
luafile ~/.config/nvim/plugin_settings/trouble.lua
luafile ~/.config/nvim/plugin_settings/colorizer.lua
source ~/.config/nvim/mapping.vim
source ~/.config/nvim/spelling.vim
source ~/.config/nvim/plugin_settings/markdown_preview.vim
source ~/.config/nvim/plugin_settings/tablemode.vim
let s:prefix = '~/.config/nvim/plugins'
for s:fname in glob(s:prefix . '/**/*.vim', 1, 1)
    execute 'source' s:fname
endfor

"}}}

"{{{============================================================== Plugins

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'

Plug '~/jump-ray'
Plug '~/mark-ray'
Plug 'terrortylor/nvim-comment'
Plug 'tweekmonster/startuptime.vim'
Plug 'max397574/nvim-whid'
Plug 'folke/zen-mode.nvim'
Plug 'folke/twilight.nvim'
Plug 'rhysd/clever-f.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'folke/which-key.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-surround'
"Calculate average sum etc
Plug 'drxcc/vim-vmath'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-signify'
Plug 'folke/todo-comments.nvim'
Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
Plug 'sharkdp/bat'
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
"easily display help files
Plug 'lvim-tech/lvim-helper'
Plug 'norcalli/nvim-colorizer.lua'
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
Plug 'RRethy/nvim-treesitter-textsubjects'
Plug 'p00f/nvim-ts-rainbow'
Plug 'nvim-treesitter/playground'
Plug 'romgrk/nvim-treesitter-context'

call plug#end()
"}}}

"{{{============================================================== Plugin Settings

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
highlight GreenFunction guifg=#8ABB26 cterm=bold



highlight LspDiagnosticsDefaultError ctermbg=none guibg=none ctermfg=167 guifg=#FB4934
highlight LspDiagnosticsDefaultHint ctermbg=none guibg=none ctermfg=109 guifg=#519ABA
highlight LspDiagnosticsDefaultWarning ctermbg=none guibg=none ctermfg=208 guifg=#FE8019
highlight LspDiagnosticsDefaultInformation ctermbg=none guibg=none ctermfg=214 guifg=#FABD2F

highlight VimCommand ctermfg=12 guifg=#B30B00
highlight VimVar guifg=#009999
highlight VimString guifg=#207245
highlight VimAttrib guifg=#207245
highlight VimOption guifg=#9ABB26
highlight VimIsCommand guifg=#FE8019
highlight VimUsrCmd guifg=#FE8019

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
set formatoptions-=o
"}}}
