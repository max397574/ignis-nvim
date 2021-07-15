
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

source ~/.config/nvim/mapping.vim
source ~/.config/nvim/spelling.vim
source ~/.config/nvim/plugin_settings/which_key.vim
source ~/.config/nvim/plugin_settings/markdown_preview.vim
source ~/.config/nvim/plugin_settings/tablemode.vim
source ~/.config/nvim/plugin_settings/goyo.vim
source ~/.config/nvim/plugin_settings/lvim_helper.vim
source ~/.config/nvim/plugin_settings/lsp.vim
source ~/.config/nvim/plugin_settings/dashboard.vim
source ~/.config/nvim/plugin_settings/limelight.vim
source ~/.config/nvim/plugin_settings/indentline.vim
source ~/.config/nvim/plugin_settings/twilight.vim
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
Plug 'max397574/nvim-whid'
"use f after f{char} to jump to next occurence
Plug 'folke/zen-mode.nvim'
Plug 'rhysd/clever-f.vim'
Plug 'folke/twilight.nvim'
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
Plug 'junegunn/goyo.vim'
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

call plug#end()
"}}}

"{{{============================================================== Plugin Settings

"{{{.............................................................. TreeSitter

"{{{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  LocalParser
lua <<EOF
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.vim = {
  install_info = {
    url = "~/tree-sitter-viml", -- local path or git repo
    files = {"src/parser.c", "src/scanner.c"},
    filetype = "vim",
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
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true
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
    "class with filename and class main
    autocmd BufNewFile *.java
      \ exe "normal Opublic class " . expand('%:t:r') . "{\npublic static void main(String[] args) {\n}\n}\<Esc>"

augroup END
"2}}}

"{{{.............................................................. TabCompletition

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
