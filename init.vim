
" /$$           /$$   /$$                /$$
"|__/          |__/  | $$               |__/
" /$$ /$$$$$$$  /$$ /$$$$$$   /$$    /$$ /$$ /$$$$$$/$$$$
"| $$| $$__  $$| $$|_  $$_/  |  $$  /$$/| $$| $$_  $$_  $$
"| $$| $$  \ $$| $$  | $$     \  $$/$$/ | $$| $$ \ $$ \ $$
"| $$| $$  | $$| $$  | $$ /$$  \  $$$/  | $$| $$ | $$ | $$
"| $$| $$  | $$| $$  |  $$$$//$$\  $/   | $$| $$ | $$ | $$
"|__/|__/  |__/|__/   \___/ |__/ \_/    |__/|__/ |__/ |__/

"{{{============================================================== Sets


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


"{{{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .Folding

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
source ~/.config/nvim/autoswap_mac.vim
"}}}

"{{{============================================================== Plugins

call plug#begin('~/.vim/plugged')
"a colorscheme
Plug 'morhetz/gruvbox'
"a colorscheme
Plug 'eddyekofo94/gruvbox-flat.nvim'
"a colorscheme
Plug 'folke/tokyonight.nvim'
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
"easier configuration for nvim-lsp
"Plug 'neovim/nvim-lspconfig'
"easy add new LS for nvim-lsp
"Plug 'kabouzeid/nvim-lspinstall'
"A startup screen
Plug 'glepnir/dashboard-nvim'
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
"easily display help files
Plug 'lvim-tech/lvim-helper'
"distraction free writing
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
". . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  TreeSitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'

call plug#end()
"}}}

"{{{============================================================== Plugin Settings
"{{{.............................................................. Which Key
lua << EOF
  require("which-key").setup {
    {
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        spelling = {
          enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
        presets = {
          operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
          motions = true, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
      -- add operators that will trigger motion and text object completion
      -- to enable all native operators, set the preset / operators plugin above
      operators = { gc = "Comments" },
      key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
      },
      icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
      },
      window = {
        border = "none", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
      },
      ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
      show_help = true, -- show help message on the command line when the popup is visible
      triggers = "auto", -- automatically setup triggers
      -- triggers = {"<leader>"} -- or specify a list manually
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
      },
    }
  }
EOF
"2}}}

"{{{.............................................................. LSPConfig

"lua << EOF
"require'lspconfig'.pyright.setup{}
"require'lspconfig'.pyls.setup{}
"require'lspinstall'.setup() -- important

"local servers = require'lspinstall'.installed_servers()
"for _, server in pairs(servers) do
  "require'lspconfig'[server].setup{}
"end
"EOF
"2}}}

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

"{{{.............................................................. TableMode
let g:table_mode_corner='|'
inoremap <leader>tm <ESC>:TableModeToggle<CR>i
function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'
"2}}}

"{{{.............................................................. Trouble.nvim

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

"{{{.............................................................. Goyo

function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
  " ...
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
"2}}}

"{{{.............................................................. TreeSitter

lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = 'maintained',
--{{{Highlighting
    highlight = {
        enable = true,
        --disable = { "c", "rust" },  -- list of language that will be disabled
        --custom_captures = {
        -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
        --["foo.bar"] = "Identifier",
        --},
    },
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
            goto_node = '<cr>',
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
        enable = true
    }
--3}}}
}
EOF
"2}}}

"{{{.............................................................. lvim-helper


lua <<EOF
local home = os.getenv('HOME')
require('lvim-helper').setup({
    files = {
	home .. "/.config/nvim/vimhelp/treesitter.md",
	home .. "/.config/nvim/vimhelp/vim_cheat_sheet_cursor_movement.md",
	home .. "/.config/nvim/vimhelp/personal_mappings.md",

    },
    width = 80,
    side = 'right',
    current_file = 1,
    winopts = {
        relativenumber = false,
        number = false,
        list = false,
        winfixwidth = true,
        winfixheight = true,
        foldenable = false,
        spell = false,
        signcolumn = 'no',
        foldmethod = 'manual',
        foldcolumn = '0',
        cursorcolumn = false,
        colorcolumn = '0',
        wrap = false,
        winhl = table.concat({'Normal:LvimHelperNormal'}, ',')
    },
    bufopts = {
        swapfile = false,
        buftype = 'nofile',
        modifiable = false,
        filetype = 'LvimHelper',
        bufhidden = 'hide'
    }
})
EOF
"2}}}

"{{{.............................................................. Telescope

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

nnoremap <leader>sr :SnipRun<CR>
nnoremap <leader>sc :SnipClose<CR>
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
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
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
"1}}}

"{{{============================================================== Autocommands

augroup filetypes
    autocmd!
    autocmd BufNewFile,BufRead,BufWinEnter *.html syntax on
    autocmd BufNewFile,BufRead,BufWinEnter *.txt setlocal wrap
    autocmd BufNewFile,BufRead,BufWinEnter *.vim set foldmethod=marker
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
"}}}

"{{{============================================================== Mappings
"{{{
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
"open help files
nnoremap <leader>hp :LvimHelper<CR>

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
"DistractionFree writing
nnoremap <leader>df :Goyo<CR>
"use vmath
vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap         ++  vip++
"}}}

"{{{. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .  Force to use mappings

inoremap <up> <nop>
inoremap <right> <nop>
inoremap <left> <nop>
inoremap <down> <nop>
inoremap <esc> <nop>
nnoremap <right> <nop>
nnoremap <left> <nop>
"2}}}
"}}}

"{{{============================================================== Highlights


"line number where cursor is has different color
highlight CursorLineNr term=bold ctermfg=11 gui=bold guifg=Yellow

"the search results
highlight       Search    ctermfg=White  ctermbg=Black  cterm=bold
"the first search result
highlight    IncSearch    ctermfg=White  ctermbg=grey   cterm=bold

set background=dark

colorscheme gruvbox

highlight Folded term=bold cterm=italic ctermfg=white gui=italic guifg=white

"transparent background
highlight  Normal   guibg=none
highlight  Normal   ctermbg=none
highlight NonText   ctermbg=none
highlight NonText   guibg=none
hi! EndOfBuffer ctermbg=none ctermfg=none guibg=none guifg=none

"comments are important :)
highlight Comment term=bold cterm=italic ctermfg=white gui=italic guifg=white
"}}}

"{{{============================================================== Misc

"Square up visual selections...
set virtualedit=block
"}}}
