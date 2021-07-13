call plug#begin('~/.vim/plugged')
Plug 'folke/twilight.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()
lua << EOF
  require("twilight").setup {
    dimming = {
      alpha = 0.25, -- amount of dimming
      color = { "Normal", "#ffffff" },
    },
    context = 15, -- amount of lines we will try to show around the current line
    expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
      "function",
      "method",
      "table",
      "if_statement",
    },
    exclude = {}, -- exclude these filetypes
  }
EOF
