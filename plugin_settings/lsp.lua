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
  lspconfig = {
      settings = {
	Lua = {
	  diagnostic = {
	    globals = { 'vim' },
	  },
	},
      },
    },
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
        globals = {'vim'},
      },
    },
  },
}

-- Refernce: https://github.com/kabouzeid/nvim-lspinstall/wiki
local lua_settings = {
  Lua = {
    diagnostics = {
      globals = {'vim'},
    },
  }
}

local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

local function setup_servers()
  require'lspinstall'.setup()

  -- get all installed servers
  local servers = require'lspinstall'.installed_servers()
  -- ... and add manually installed servers
  table.insert(servers, "clangd")
  table.insert(servers, "sourcekit")

  for _, server in pairs(servers) do
    local config = make_config()

    -- language specific config
    if server == "lua" then
      config.settings = lua_settings
    end

    require'lspconfig'[server].setup(config)
  end
end

setup_servers()
