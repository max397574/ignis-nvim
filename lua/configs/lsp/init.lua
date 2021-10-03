vim.cmd [[au CursorHold  * lua vim.diagnostic.show_position_diagnostics()]]

local attach = require "configs.lsp.on_attach"
require "configs.lsp.signs"
require "configs.lsp.border"

require("lspinstall").setup()


-- Refernce: https://github.com/kabouzeid/nvim-lspinstall/wiki
local lua_settings = {
  Lua = {
    diagnostics = {
      globals = { "vim" },
    },
  },
}


local lspconfig = require "lspconfig"
local configs = require "lspconfig/configs"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

if not lspconfig.emmet_ls then
  configs.emmet_ls = {
    default_config = {
      cmd = { "emmet-ls", "--stdio" },
      filetypes = { "html", "css" },
      root_dir = function()
        return vim.loop.cwd()
      end,
      settings = {},
    },
  }
end
lspconfig.emmet_ls.setup { capabilities = capabilities }

local function make_config()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 500,
    },
    on_attach = attach.on_attach,
  }
end

local function setup_servers()
  require("lspinstall").setup()
  local servers = require("lspinstall").installed_servers()
  table.insert(servers, "pyright")
  for _, server in pairs(servers) do
    local config = make_config()
    if server == "lua" then
      config.settings = lua_settings
    end
    require("lspconfig")[server].setup(config)
  end
end

setup_servers()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    update_in_insert = false,
    virtual_text = false,
    severity_sort = true,
  }
)
