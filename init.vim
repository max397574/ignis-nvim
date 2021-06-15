filetype plugin indent on
filetype plugin on
set termguicolors
set expandtab
set foldmethod=indent
set tabstop=8
set cmdheight=2
"highlight characters in the 80th column
au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>80v', -1)
set nowrap
set softtabstop=4
set shiftwidth=4
set hidden
set timeoutlen=300
set autoindent
set incsearch
set nohlsearch
set hlsearch
highlight clear Search

set inccommand=nosplit

set number
set signcolumn=yes
set cursorline
set relativenumber

set undodir=~/.vim/undodir
set undofile

set scrolloff=8


function! MyFoldText()
    let line = getline(v:foldstart)
    let folded_line_num = v:foldend - v:foldstart
    let line_text = substitute(line, '^"{\+', '', 'g')
    let fillcharcount = &textwidth - len(line_text) - len(folded_line_num)
    return '+'. repeat('-', 4) . line_text . repeat('.', fillcharcount) . ' (' . folded_line_num . ' L)'
endfunction
set foldtext=MyFoldText()

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'

Plug 'jiangmiao/auto-pairs'

Plug 'zirrostig/vim-schlepp'

Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'voldikss/vim-floaterm'

Plug 'Yggdroot/indentLine'

"Plug 'neovim/nvim-lspconfig'
"Plug 'kabouzeid/nvim-lspinstall'

Plug 'sirver/UltiSnips'
Plug 'tpope/vim-surround'
Plug 'honza/vim-snippets'
Plug 'tami5/sql.nvim'
Plug 'yamatsum/nvim-cursorline'
Plug 'preservim/nerdcommenter'
Plug 'vim-test/vim-test'
Plug 'preservim/tagbar'
Plug 'ThePrimeagen/vim-be-good'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-signify'
Plug 'nvim-telescope/telescope-media-files.nvim'
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
Plug 'junegunn/fzf.vim'
Plug 'sharkdp/bat'
Plug 'nvim-lua/popup.nvim'
Plug 'luochen1990/rainbow'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-sources'
Plug 'ryanoasis/vim-devicons'
Plug 'folke/lsp-colors.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }
Plug 'folke/trouble.nvim'

call plug#end()

".............................................................. LSPConfig
"lua << EOF
"require'lspconfig'.pyright.setup{}
"require'lspconfig'.pyls.setup{}
"require'lspinstall'.setup() -- important

"local servers = require'lspinstall'.installed_servers()
"for _, server in pairs(servers) do
  "require'lspconfig'[server].setup{}
"end
"EOF

"".............................................................. Trouble.nvim
"lua << EOF
  "require("trouble").setup {
  "position = "bottom", -- position of the list can be: bottom, top, left, right
    "height = 10, -- height of the trouble list when position is top or bottom
    "width = 50, -- width of the list when position is left or right
    "icons = true, -- use devicons for filenames
    "mode = "lsp_workspace_diagnostics", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
    "fold_open = "", -- icon used for open folds
    "fold_closed = "", -- icon used for closed folds
    "action_keys = { -- key mappings for actions in the trouble list
        "-- map to {} to remove a mapping, for example:
        "-- close = {},
        "close = "q", -- close the list
        "cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        "refresh = "r", -- manually refresh
        "jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
        "open_split = { "<c-x>" }, -- open buffer in new split
        "open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        "open_tab = { "<c-t>" }, -- open buffer in new tab
        "jump_close = {"o"}, -- jump to the diagnostic and close the list
        "toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        "toggle_preview = "P", -- toggle auto_preview
        "hover = "K", -- opens a small poup with the full multiline message
        "preview = "p", -- preview the diagnostic location
        "close_folds = {"zM", "zm"}, -- close all folds
        "open_folds = {"zR", "zr"}, -- open all folds
        "toggle_fold = {"zA", "za"}, -- toggle fold of current file
        "previous = "k", -- preview item
        "next = "j" -- next item
    "},
    "indent_lines = true, -- add an indent guide below the fold icons
    "auto_open = false, -- automatically open the list when you have diagnostics
    "auto_close = false, -- automatically close the list when you have no diagnostics
    "auto_preview = true, -- automatyically preview the location of the diagnostic. <esc> to close preview and go back to last window
    "auto_fold = false, -- automatically fold a file trouble list at creation
    "signs = {
        "-- icons / text used for a diagnostic
        "error = "",
        "warning = "",
        "hint = "",
        "information = "",
        "other = "﫠"
    "},
    "use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
  "}
"EOF



".............................................................. Telescope
lua << EOF

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_position = "bottom",
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "vertical",
    layout_defaults = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    shorten_path = true,
    winblend = 0,
    width = 0.75,
    preview_cutoff = 120,
    results_height = 1,
    results_width = 0.8,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}
EOF



".............................................................. NERDTree
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

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


" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif


".............................................................. Ultest
let test#python#pytest#options = "--color=yes"
let g:ultest_icons=1

let test#javascript#jest#options = "--color=always"
let g:ultest_use_pty = 1

".............................................................. SnipRun
nnoremap <leader>sr :SnipRun<CR>
nnoremap <leader>sc :SnipClose<CR>
vmap r <Plug>SnipRun


augroup filetypes
    autocmd!
    autocmd BufNewFile,BufRead,BufWinEnter *.html syntax on
    "class with filename and class main
    autocmd BufNewFile *.java
      \ exe "normal Opublic class " . expand('%:t:r') . "{\npublic static void main(String[] args) {\n}\n}\<Esc>2G"

augroup END

let g:rainbow_active = 1

"the search results
highlight       Search    ctermfg=White  ctermbg=Black  cterm=bold
"the first search result
highlight    IncSearch    ctermfg=White  ctermbg=grey   cterm=bold

nnoremap nh :nohlsearch<CR>

"Square up visual selections...
set virtualedit=block


augroup Activate
    autocmd!
    au VimEnter * inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
augroup END

augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END


ab    retrun  return
ab     pritn  print
ab       teh  the
ab      liek  like
ab  liekwise  likewise
ab      Pelr  Perl
ab      pelr  perl
ab      moer  more
ab  previosu  previous
ab    lenght  length

let g:NERDCreateDefaultMappings = 1

let mapleader = ' '
inoremap jj <ESC>
nnoremap S  :%s//g<LEFT><LEFT>
xnoremap S  :s//g<LEFT><LEFT>
"Visual Block mode is far more useful that Visual mode (so swap the commands)...
nnoremap v <C-V>
nnoremap <C-V> v
xnoremap v <C-V>
xnoremap <C-V> v
xnoremap <BS> x

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

nnoremap <Leader>ut :UndotreeToggle<CR>

xmap <up>    <Plug>SchleppUp
xmap <down>  <Plug>SchleppDown
xmap <left>  <Plug>SchleppLeft
xmap <right> <Plug>SchleppRight
xmap D       <Plug>SchleppDupLeft
xmap <C-D>   <Plug>SchleppDupLeft

nnoremap <leader>ff <cmd>Telescope find_files<cr>
" Change an option

" When in Normal mode, paste over the current line...
nnoremap  <C-P> 0d$"*p

" When in Visual mode, paste over the selected region...
xnoremap  <C-P> "*pgv


"use <leader>yy to copy to system clipboard
nnoremap <Leader>yy "+y

nnoremap fzf :Files<CR>


" Shift-Tab in visual mode to number lines...
xnoremap <S-TAB> :s/\%V/0<C-V><TAB>/<CR>gvg<C-A>gv:retab<ESC>gvI<C-G>u<ESC>gv/ <CR>:s/\%V /./<CR>

let g:VM_maps = {}
let g:VM_maps["Add Cursor Down"]    = '<Leader>cd'   " new cursor down
let g:VM_maps["Add Cursor Up"]      = '<Leader>cu'   " new cursor up
let g:VM_maps['Find Under']         = '<Leader>fu'

"toggle floating Terminal
nnoremap <silent> <Leader>t   :FloatermToggle<CR>
"toggle floating Terminal in terminal-mode
tnoremap <silent> <Leader>t   <C-\><C-n>:FloatermToggle<CR>

nnoremap <Leader>tb :TagbarToggle<CR>

nnoremap <Leader>nt :NERDTreeToggle<CR>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

colorscheme Gruvbox

highlight Comment term=bold cterm=italic ctermfg=white gui=italic guifg=white


"line number where cursor is has different color
highlight CursorLineNr term=bold ctermfg=11 gui=bold guifg=Yellow


highlight Normal guibg=none


highlight NonText guibg=none


highlight Normal ctermbg=none


highlight NonText ctermbg=none

highlight Normal guibg=NONE ctermbg=NONE



set background=dark

"comments are important :)
highlight Comment term=bold cterm=italic ctermfg=white gui=italic guifg=white

hi Normal guibg=NONE ctermbg=NONE

let g:indentLine_setColors = 0
let g:indentLine_char = '┆'


inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

