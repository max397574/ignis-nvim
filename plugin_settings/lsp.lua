vim.api.nvim_exec(
[[
call plug#begin('~/.vim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
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

require'lspconfig'.pyright.setup{
  flags = {
    debounce_text_changes = 500,
  }
}

require'lspconfig'.sumneko_lua.setup(luadev)

require'lspinstall'.setup() -- important

require'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
    },
  },
}

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
  require'lspconfig'[server].setup{}
end
