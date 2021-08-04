call plug#begin('~/.vim/plugged')

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
