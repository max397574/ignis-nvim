vim.api.nvim_exec([[
call plug#begin('~/.vim/plugged')
Plug 'norcalli/nvim-colorizer.lua'
call plug#end()
]],
true)
require'colorizer'.setup()
