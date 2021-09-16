vim.cmd [[au CursorHold  * lua vim.lsp.diagnostic.show_line_diagnostics({ focusable=false})]]
require("lspinstall").setup()
local function lsp_highlight_document(client)
  if client.resolved_capabilities.document_highlight == false then
    return -- we don't need further
  end
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

-- Refernce: https://github.com/kabouzeid/nvim-lspinstall/wiki
local lua_settings = {
  Lua = {
    diagnostics = {
      globals = { "vim" },
    },
  },
}

local lspconfig = require'lspconfig'
local configs = require'lspconfig/configs'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

if not lspconfig.emmet_ls then
  configs.emmet_ls = {
    default_config = {
      cmd = {'emmet-ls', '--stdio'};
      filetypes = {'html', 'css'};
      root_dir = function(fname)
        return vim.loop.cwd()
      end;
      settings = {};
    };
  }
end
lspconfig.emmet_ls.setup{ capabilities = capabilities; }

local function make_config()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return {
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 500,
    },
    on_attach = function(client)
      lsp_highlight_document(client)
    end,
  }
end

local function setup_servers()
  require("lspinstall").setup()
  local servers = require("lspinstall").installed_servers()
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
    underline = true, -- this
    update_in_insert = false,
    virtual_text = false,
    severity_sort = true,
  }
)

local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = border }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = border }
)

local signs = {
  Error = "",
  Warning = "",
  Hint = "",
  Information = "",
}

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  local numhl = "LspDiagnosticsDefault" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = numhl })
end
