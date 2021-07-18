vim.api.nvim_exec(
[[
call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'folke/lsp-colors.nvim'
Plug 'folke/trouble.nvim'
Plug 'folke/lua-dev.nvim'
call plug#end()
]],
true)

local luadev = require("lua-dev").setup({
  --lspconfig = {
    --cmd = {"lua-language-server"}
  --},
})

require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})

require'lspconfig'.pyright.setup{
  flags = {
    debounce_text_changes = 500,
  }
}

require'lspconfig'.sumneko_lua.setup(luadev)

require'lspinstall'.setup() -- important

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{}
end
