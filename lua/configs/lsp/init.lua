vim.cmd [[au CursorHold  * lua vim.diagnostic.show_position_diagnostics()]]

require "configs.lsp.kind"

require("lspinstall").setup()

local function lsp_highlight_document(client)
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

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local opts = { noremap = true, silent = true }
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
  lsp_highlight_document(client)
end

local lspconfig = require "lspconfig"
local configs = require "lspconfig/configs"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

if not lspconfig.emmet_ls then
  configs.emmet_ls = {
    default_config = {
      cmd = { "emmet-ls", "--stdio" },
      filetypes = { "html", "css" },
      root_dir = function(fname)
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
    on_attach = on_attach,
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
    underline = true,
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
  Error = " ",
  Warning = " ",
  Hint = "",
  Information = "",
  other = "﫠",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
