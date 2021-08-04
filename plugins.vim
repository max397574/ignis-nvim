call plug#begin('~/.vim/plugged')

Plug 'jiangmiao/auto-pairs'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'tpope/vim-surround'
"Calculate average sum etc
Plug 'drxcc/vim-vmath'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
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

let s:prefix = '~/.config/nvim/plugins'
for s:fname in glob(s:prefix . '/**/*.vim', 1, 1)
    execute 'source' s:fname
endfor

colorscheme gruvbox

lua << EOF
  require('vmath_nvim').setup{
    show_sum = true,
    show_average = true,
    show_count = true,
    show_lowest = true,
    show_highest = true,
    show_range = true,
    show_median = true,
    debug = false,
    registers = true,
  }
EOF
