"============================================================== Sets


let mapleader = ' '
filetype plugin on
filetype plugin indent on
set cmdheight=2
set termguicolors
"highlight characters in the 80th column
au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>80v', -1)
"don't wrap lines when they are longer than screenwidth
set nowrap
set softtabstop=4
set shiftwidth=4
set updatetime=2000
set hidden
"time between characters of commands (ms)
set timeoutlen=300
"indent new line (<CR>) when current line is indented
set autoindent
"highlight search results
set incsearch
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
set list
set listchars+=tab:>-,lead:.,trail:.


". . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .Folding

"use TreeSitter for folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

"function for custom fold text
function! MyFoldText()
    let line = getline(v:foldstart)
    let folded_line_num = v:foldend - v:foldstart
    let line_text = substitute(line, '^"{\+', '', 'g')
    let fillcharcount = &textwidth - len(line_text) - len(folded_line_num)
    return '+'. repeat('-', 4) . line_text . repeat('.', fillcharcount) . ' (' . folded_line_num . ' L)'
endfunction
"use the text of the function above
set foldtext=MyFoldText()


"============================================================== Source

source ~/.config/nvim/spelling.vim


"============================================================== Plugins

call plug#begin('~/.vim/plugged')
"a colorscheme
Plug 'morhetz/gruvbox'
"a colorscheme
Plug 'eddyekofo94/gruvbox-flat.nvim'
"a colorscheme
Plug 'folke/tokyonight.nvim'
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
"easier configuration for nvim-lsp
"Plug 'neovim/nvim-lspconfig'
"easy add new LS for nvim-lsp
"Plug 'kabouzeid/nvim-lspinstall'
Plug 'sirver/UltiSnips'
"easily add and change surrondings
Plug 'tpope/vim-surround'
"snippets for ultisnips
Plug 'honza/vim-snippets'
"sql support for nvim
Plug 'tami5/sql.nvim'
"highlight word under cursor everywhere
Plug 'yamatsum/nvim-cursorline'
"easily comment out code
Plug 'preservim/nerdcommenter'
"Easily test code
Plug 'vim-test/vim-test'
"display structure of file (variables,functions etc)
Plug 'preservim/tagbar'
"game to practice movements
Plug 'ThePrimeagen/vim-be-good'
"show last changes in list and last change in signcolumn
Plug 'mbbill/undotree'
"Show git symbols in signcolumn
Plug 'mhinz/vim-signify'
"A File Explorer
"Show git status of files in nerdtree
"the icons for nerdtree
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons'
"a file explorer
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"fzf vim integration
Plug 'junegunn/fzf.vim'
Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
Plug 'sharkdp/bat'
"expand html 'snippets'
Plug 'mattn/emmet-vim'
"telescope dependency
Plug 'nvim-lua/popup.nvim'
"color nested brackets in different colors
Plug 'luochen1990/rainbow'
"telescope dependency
Plug 'nvim-lua/plenary.nvim'
"a file explorer
Plug 'nvim-telescope/telescope.nvim'
"completition
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"more sources for the coc completition
Plug 'neoclide/coc-sources'
"more icons
Plug 'ryanoasis/vim-devicons'
"better colors for lsp
"Plug 'folke/lsp-colors.nvim'
"even more icons
Plug 'kyazdani42/nvim-web-devicons'
"test code from inside nvim
Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }
"list and display lsp diagnostic
Plug 'folke/trouble.nvim'
". . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  TreeSitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'

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


".............................................................. Trouble.nvim

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


".............................................................. TreeSitter

lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = 'maintained',
    highlight = {
        enable = true,
        --disable = { "c", "rust" },  -- list of language that will be disabled
        --custom_captures = {
        -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
        --["foo.bar"] = "Identifier",
        --},
    },
    refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = false },
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "grr",
            },
        },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition = "gnd",
                list_definitions = "gnD",
                list_definitions_toc = "gO",
                goto_next_usage = "<leader>n",
                goto_previous_usage = "<leader>p",
            },
        },
    },
    textobjects = {
        select = {
            enable = false,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",

                -- Or you can define your own textobjects like this
                --["iF"] = {
                --python = "(function_definition) @function",
                --cpp = "(function_definition) @function",
                --c = "(function_definition) @function",
                --java = "(method_declaration) @function",
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
        move = {
            enable = false,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer",
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer",
            },
            goto_previous_start = {
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer",
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer",
            },
        },
    },
  
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
        },
    },
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = {"BufWrite", "CursorHold"},
    },
    incremental_selection = {
        enable = false,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    indent = {
        enable = true
    }
}
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

"<leader>ff to use Telescope to Find Files
nnoremap <leader>ff <cmd>Telescope find_files<cr>


".............................................................. NERDTree

"Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

"Start NERDTree when Vim starts with a directory argument.
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


"Start NERDTree when Vim is started without file arguments.
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
vmap <leader>sr <Plug>SnipRun


".............................................................. Emmet

let g:user_emmet_leader_key='<leader>e'


".............................................................. VisualMulti

let g:VM_maps = {}
let g:VM_maps["Add Cursor Down"]    = '<Leader>cd'   " new cursor down
let g:VM_maps["Add Cursor Up"]      = '<Leader>cu'   " new cursor up
let g:VM_maps['Find Under']         = '<Leader>fu'


".............................................................. Floaterm

"toggle floating Terminal
nnoremap <silent> <Leader>t   :FloatermToggle<CR>
"toggle floating Terminal in terminal-mode
tnoremap <silent> <Leader>t   <C-\><C-n>:FloatermToggle<CR>


".............................................................. Schlepp

"Move visual selected blocks with arrow keys
xmap <up>    <Plug>SchleppUp
xmap <down>  <Plug>SchleppDown
xmap <left>  <Plug>SchleppLeft
xmap <right> <Plug>SchleppRight
"use D to move a copy of a visual selected block
xmap D       <Plug>SchleppDupLeft


".............................................................. CoC.nvim

"Use <CR> to confirm selection
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


".............................................................. NERDCommenter

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


".............................................................. IndentLine

let g:indentLine_setColors = 0
let g:indentLine_char = '┆'

".............................................................. Vim-Sourround

"mapping to add surrounding with vim-surround
"around inner W
nmap <leader>sW ysiW
"around inner w
nmap <leader>sw ysiw


"============================================================== Autocommands

augroup filetypes
    autocmd!
    autocmd BufNewFile,BufRead,BufWinEnter *.html syntax on
    autocmd BufNewFile,BufRead,BufWinEnter *.vim set foldmethod=indent
    "class with filename and class main
    autocmd BufNewFile *.java
      \ exe "normal Opublic class " . expand('%:t:r') . "{\npublic static void main(String[] args) {\n}\n}\<Esc>2G"

augroup END


augroup Activate
    autocmd!
    "use <Tab> to go through list of completitions
    au VimEnter * inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
augroup END


augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END


"============================================================== Mappings

"remove highlights after a search
nnoremap nh :nohlsearch<CR>
inoremap jj <ESC>
"shortcut for a often used command
nnoremap S  :%s///g<LEFT><LEFT><LEFT>
"Swap commands for visual and visual block mode
nnoremap v <C-V>
nnoremap <C-V> v
xnoremap v <C-V>
xnoremap <C-V> v
"use delete to delete visual selected text
xnoremap <BS> x

"move line one line down
nnoremap <leader>d ddp
"move line one line up
nnoremap <leader>u ddkP
"delete line in insert mode
inoremap <leader>dd <ESC>ddi
"surround inner word with double quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"toggle the undotree
nnoremap <Leader>ut :UndotreeToggle<CR>
"paste over the current line with <C-P> in normal mode
nnoremap  <C-P> 0d$"*p
"paste over the visual selected block with <C-P> in visual mode
xnoremap  <C-P> "*pgv
"use <leader>yy with a text object to copy to system clipboard
nnoremap <Leader>yy "+y
"use fzf to search files with fuzzy finder
nnoremap fzf :Files<CR>
"edit init.vim in split
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
"Shift-Tab in visual mode to number lines (numbered list)
xnoremap <S-TAB> :s/\%V/0<C-V><TAB>/<CR>gvg<C-A>gv:retab<ESC>gvI<C-G>u<ESC>gv/ <CR>:s/\%V /./<CR>
"use leader with o/O to insert empty lines below/above
"remove potential command indicators
nnoremap <leader>o o<ESC>xk
nnoremap <leader>O O<ESC>xj
"convert current word to uppercase
inoremap <c-u> <esc>viwU<esc>i
nnoremap <c-u> viwU<esc>
"source init.vim
nnoremap <leader>sv :source $MYVIMRC<cr>
"toggle the tagbar
nnoremap <Leader>tb :TagbarToggle<CR>
"toggle the nerdtree
nnoremap <Leader>nt :NERDTreeToggle<CR>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

". . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  Force to use mappings

inoremap <up> <nop>
inoremap <right> <nop>
inoremap <left> <nop>
inoremap <down> <nop>
inoremap <esc> <nop>
nnoremap <right> <nop>
nnoremap <left> <nop>


"============================================================== Highlights


"line number where cursor is has different color
highlight CursorLineNr term=bold ctermfg=11 gui=bold guifg=Yellow

"the search results
highlight       Search    ctermfg=White  ctermbg=Black  cterm=bold
"the first search result
highlight    IncSearch    ctermfg=White  ctermbg=grey   cterm=bold

set background=dark

colorscheme gruvbox

"transparent background
highlight  Normal   guibg=none
highlight  Normal   ctermbg=none
highlight NonText   ctermbg=none
highlight NonText   guibg=none
hi! EndOfBuffer ctermbg=none ctermfg=none guibg=none guifg=none

"comments are important :)
highlight Comment term=bold cterm=italic ctermfg=white gui=italic guifg=white



"============================================================== Misc

"Square up visual selections...
set virtualedit=block
