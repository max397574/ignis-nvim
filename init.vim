filetype plugin indent on
filetype plugin on
set termguicolors
set expandtab
set foldmethod=indent
set tabstop=8
set cmdheight=2
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
Plug 'preservim/nerdcommenter'
Plug 'preservim/tagbar'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-signify'
Plug 'nvim-telescope/telescope-media-files.nvim'
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sharkdp/bat'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end()

".............................................................. LSPConfig
lua << EOF
--require'lspconfig'.pyright.setup{}
--require'lspconfig'.pyls.setup{}
--require'lspinstall'.setup() -- important

--local servers = require'lspinstall'.installed_servers()
--for _, server in pairs(servers) do
--  require'lspconfig'[server].setup{}
--end
EOF

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



"the search results
highlight       Search    ctermfg=White  ctermbg=Black  cterm=bold
"the first search result
highlight    IncSearch    ctermfg=White  ctermbg=grey   cterm=bold


"Square up visual selections...
set virtualedit=block

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
