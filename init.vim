
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
filetype plugin on
filetype plugin indent on
set conceallevel=0
"height of the commandline
set cmdheight=2
set termguicolors
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
"2}}}

"{{{.............................................................. Statusline
let g:currentmode={
       \ 'n'  : 'NORMAL ',
       \ 'v'  : 'VISUAL ',
       \ 'V'  : 'V·Line ',
       \ "\<C-V>" : 'V·Block ',
       \ 'i'  : 'INSERT ',
       \ 'R'  : 'R ',
       \ 'Rv' : 'V·Replace ',
       \ 'c'  : 'Command ',
       \}

set statusline=
set statusline+=\ \ 
set statusline+=%F
set statusline+=\ -\ 
set statusline+=%r
set statusline+=%y
set statusline+=\ -\ 
set statusline+=%m
set statusline+=%=
set statusline+=%4l
set statusline+=,
set statusline+=%c
set statusline+=\ -\ 
set statusline+=%p
set statusline+=%%
set statusline+=\ \ \ \ 

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

source ~/.config/nvim/spelling.vim
source ~/.config/nvim/plugin_settings/which_key.vim
source ~/.config/nvim/plugin_settings/markdown_preview.vim
source ~/.config/nvim/plugin_settings/tablemode.vim
source ~/.config/nvim/plugin_settings/goyo.vim
source ~/.config/nvim/plugin_settings/lvim_helper.vim
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

Plug 'tweekmonster/startuptime.vim'

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
"A startup screen
Plug 'glepnir/dashboard-nvim'
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
"A File Explorer
"Show git status of files in nerdtree
"the icons for nerdtree
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
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
"completition
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"more sources for the coc completition
Plug 'neoclide/coc-sources'
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
Plug 'junegunn/goyo.vim'

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

call plug#end()
"}}}

lua << EOF
require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})
EOF
lua << EOF
require'lspconfig'.pyright.setup{
  flags = {
    debounce_text_changes = 500,
  }
}
EOF
lua << EOF
require'lspinstall'.setup() -- important

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{}
end
EOF

"{{{============================================================== Plugin Settings

"{{{.............................................................. Dashboard

let g:dashboard_default_executive ='telescope'
let g:dashboard_custom_shortcut={
\ 'last_session'       : 'SPC s l',
\ 'find_history'       : 'SPC f h',
\ 'find_file'          : 'SPC f f',
\ 'new_file'           : 'SPC c n',
\ 'change_colorscheme' : 'SPC t c',
\ 'find_word'          : 'SPC f a',
\ 'book_marks'         : 'SPC f b',
\ }
"2}}}

"{{{.............................................................. Limelight

" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1
"2}}}

"{{{.............................................................. TreeSitter

"{{{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  LocalParser
lua <<EOF
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.vim = {
  install_info = {
    url = "~/tree-sitter-viml", -- local path or git repo
    files = {"src/parser.c", "src/scanner.c"}
  },
}
EOF
"3}}}

lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = 'maintained',
--{{{Highlighting
    highlight = {
        enable = true,
        --disable = { "c", "rust" },  -- list of language that will be disabled
        custom_captures = {
        -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
        --["foo.bar"] = "Identifier",
          ["variable"] = "GruvboxYellow",
          ["keyword.operator"] = "DevIconPdf",
	  ["conditional"] = "DevIconPdf",
          ["number"] = "DevIconJsx",
          ["float"] = "DevIconJsx",
          ["operator"] = "DevIconPy",
          ["keyword"] = "ItalicRed",
	  ["string"] = "DevIconXls",
        },
    },
-- so $VIMRUNTIME/syntax/hitest.vim to see colors
--3}}}
--{{{Refactor
    refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = false },
--{{{Smart Rename
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "grr",
            },
        },
--4}}}
--{{{Navigation
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
--4}}}
--3}}}
--{{{Textobjects
    textobjects = {
--{{{Select
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
--4}}}
--{{{Swap
        swap = {
            enable = true,
            swap_next = {
                ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>A"] = "@parameter.inner",
            },
        },
--4}}}
--{{{Move
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
--4}}}
    },
--3}}}
--{{{Playground
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
            goto_node = '<CR>',
            show_help = '?',
        },
    },
--3}}}
--{{{Query Linter
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = {"BufWrite", "CursorHold"},
    },
--3}}}
--{{{Incremental Selection
    incremental_selection = {
        enable = false,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
--3}}}
--{{{Indent
    indent = {
        enable = false
    }
--3}}}
}
EOF
"2}}}

"{{{.............................................................. Telescope

lua << EOF
require('telescope').setup{
  config = {
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
nnoremap <leader>ff <cmd>Telescope find_files<CR>
"2}}}

"{{{.............................................................. NERDTree

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
"2}}}

"{{{.............................................................. Ultest

let test#python#pytest#options = "--color=yes"
let g:ultest_icons=1

let test#javascript#jest#options = "--color=always"
let g:ultest_use_pty = 1
"2}}}

"{{{.............................................................. SnipRun

nnoremap <silent> <leader>sr :SnipRun<CR>
nnoremap <silent> <leader>sc :SnipClose<CR>
vmap <leader>sr <Plug>SnipRun
"2}}}

"{{{.............................................................. Emmet

let g:user_emmet_leader_key='<leader>e'
"2}}}

"{{{.............................................................. VisualMulti

let g:VM_maps = {}
let g:VM_maps["Add Cursor Down"]    = '<Leader>cd'   " new cursor down
let g:VM_maps["Add Cursor Up"]      = '<Leader>cu'   " new cursor up
let g:VM_maps['Find Under']         = '<Leader>fu'
"2}}}

"{{{.............................................................. Floaterm

"toggle floating Terminal
nnoremap <silent> <Leader>t   :FloatermToggle<CR>
"toggle floating Terminal in terminal-mode
tnoremap <silent> <Leader>t   <C-\><C-n>:FloatermToggle<CR>
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

"{{{.............................................................. CoC.nvim

"Use <CR> to confirm selection
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
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

"{{{.............................................................. IndentLine

let g:indentLine_setColors = 0
let g:indentLine_char = '⎸'
"2}}}

"{{{.............................................................. Vim-Sourround

"mapping to add surrounding with vim-surround
"around inner W
nmap <leader>sW ysiW
"around inner w
nmap <leader>sw ysiw
"2}}}

"{{{.............................................................. Tokyonight

let tokyonight_style="storm"
"2}}}

"1}}}

"{{{============================================================== Autocommands

au BufWinEnter *.{py,java,html,c,cpp,cs,vim} 
  \let w:m1=matchadd('Search', '\%<81v.\%>80v', -1)

"{{{.............................................................. Filetypes
augroup filetypes
    autocmd!
    autocmd BufNewFile,BufRead,BufWinEnter *.html syntax on
    autocmd BufNewFile,BufRead,BufWinEnter *.{md,txt,html} set spell
    autocmd BufNewFile,BufRead,BufWinEnter *.vim set foldmethod=marker
    autocmd BufNewFile,BufRead,BufWinEnter *.md set conceallevel=0
    "class with filename and class main
    autocmd BufNewFile *.java
      \ exe "normal Opublic class " . expand('%:t:r') . "{\npublic static void main(String[] args) {\n}\n}\<Esc>"

augroup END
"2}}}

"{{{.............................................................. TabCompletition
augroup tab_completition
    autocmd!
    "use <Tab> to go through list of completitions
    au VimEnter * inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
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

"}}}

"{{{============================================================== Mappings

"{{{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  Mappings
"write file
nnoremap <leader>w :w<CR>
"toggle trouble for lsp diagnostics
nnoremap <leader>xx :TroubleToggle<CR>
"make markdown headings out of current line
nnoremap <silent> <leader>mdh1 :call MdHeading1()<CR>
nnoremap <silent> <leader>mdh2 :call MdHeading2()<CR>
nnoremap <silent> <leader>mdh3 :call MdHeading3()<CR>
nnoremap <silent> <leader>mda :call MdLink()<CR>
nnoremap <silent> <leader>mdhr :call MdHorizontalRule()<CR>
inoremap <silent> <leader>mdhr <ESC>:call MdHorizontalRule()<CR>
nnoremap <silent> <leader>mdlu :call MdUnorderedList()<CR>
nnoremap <silent> <leader>mdlo :call MdOrderedList()<CR>
inoremap <silent> <leader>mdlu <ESC>:call MdUnorderedList()<CR>
inoremap <silent> <leader>mdlo <ESC>:call MdOrderedList()<CR>
nnoremap <silent> <leader>mdlt :call MdTaskList()<CR>
inoremap <silent> <leader>mdlt <ESC>:call MdTaskList()<CR>
"make visual selection italic in markdown
vnoremap <leader>mdit :call VisualItalic()<CR>
"make visual selection bold in markdown
vnoremap <leader>mdbd :call VisualBold()<CR>
"move line to top of a list
nnoremap <silent> <leader>mt :call MoveLineToTopOfList()<CR>
"fix last spelling error
nnoremap <silent> <leader>sp :call FixLastSpellingError()<CR>
"show list with fixes for spelling
nnoremap <leader>spl [sz=
"use function to mark next search result
nnoremap <silent> n   n:call HLNext(0.4)<CR>
nnoremap <silent> N   N:call HLNext(0.4)<CR>
"better digraphs
inoremap <expr>  <C-K>   BDG_GetDigraph()
"toggle lists (comma separated, bullet)
nmap <leader>tl  :call ListTrans_toggle_format()<CR>nh
vmap <leader>tl  :call ListTrans_toggle_format('visual')<CR>nh
"remove highlights after a search
nnoremap <silent> nh :nohlsearch<CR>
inoremap jj <ESC>
"shortcut for a often used command
nnoremap S  :%s///g<LEFT><LEFT><LEFT>
"Swap commands for visual and visual block mode
nnoremap v <C-V>
nnoremap <C-V> v
xnoremap v <C-V>
xnoremap <C-V> v
"swap , and ; because , is used much more often
nnoremap , ;
nnoremap ; ,
xnoremap , ;
xnoremap ; ,

"use delete to delete visual selected text
xnoremap <BS> x
"open help files
nnoremap <leader>hp :LvimHelper<CR>

"move line one line down
nnoremap <leader>d :call MoveLineDown()<CR>
"move line one line up
nnoremap <leader>u :call MoveLineUp()<CR>
"delete line in insert mode
inoremap <leader>dd <ESC>ddi
"surround inner word with double quotes
nnoremap <leader>" :call Surrondiwquotes()<CR>
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
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
"Shift-Tab in visual mode to number lines (numbered list)
xnoremap <S-TAB> :s/\%V/0<C-V><TAB>/<CR>gvg<C-A>gv:retab<ESC>gvI<C-G>u<ESC>gv/ <CR>:s/\%V /./<CR>
"use leader with o/O to insert empty lines below/above
"remove potential command indicators
nnoremap <leader>O :call AddLineAbove()<CR>
nnoremap <leader>o :call AddLineBelow()<CR>
"convert current word to uppercase
inoremap <c-u> <ESC> :call ConvertWordUppercase()<CR>i
nnoremap <c-u> :call ConvertWordUppercase()<CR>
"source init.vim
nnoremap <leader>sv :source ~/.config/nvim/init.vim<CR>
"toggle the tagbar
nnoremap <Leader>tb :TagbarToggle<CR>
"toggle the nerdtree
nnoremap <Leader>nt :NERDTreeToggle<CR>

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"DistractionFree writing
nnoremap <leader>df :Goyo<CR>
"use vmath
vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap         ++  vip++
"}}}

"{{{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  Force to use mappings

inoremap <esc> <nop>
nnoremap <right> <nop>
nnoremap <left> <nop>
"2}}}

"}}}

"{{{============================================================== Highlights

colorscheme gruvbox
"line number where cursor is has different color
highlight CursorLineNr term=bold ctermfg=11 gui=bold guifg=Yellow

"the search results
highlight       Search    ctermfg=White  ctermbg=Black  cterm=bold
"the first search result
highlight    IncSearch    ctermfg=White  ctermbg=grey   cterm=bold

set background=dark


highlight ItalicRed term=italic ctermfg=12 gui=italic guifg=#b30b00
highlight Folded term=bold cterm=italic ctermfg=white gui=italic guifg=white

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
