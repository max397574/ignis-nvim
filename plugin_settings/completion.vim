call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'nvim-lua/completion-nvim'
call plug#end()

lua require'lspconfig'.pyright.setup{on_attach=require'completion'.on_attach}
