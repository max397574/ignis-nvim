vim.cmd [[PackerLoad lua-dev.nvim]]
vim.cmd [[PackerLoad nvim-lspinstall]]
vim.cmd [[au CursorHold  * lua vim.diagnostic.show_position_diagnostics()]]
local util = require "utils"

local DATA_PATH = vim.fn.stdpath "data"

local lua_cmd = {
  DATA_PATH .. "/lspinstall/lua/sumneko-lua-language-server",
  "-E",
  DATA_PATH .. "/lspinstall/lua/main.lua",
}

local lsp_conf = {}

function lsp_conf.preview_location(location, context, before_context)
  -- location may be LocationLink or Location (more useful for the former)
  context = context or 15
  before_context = before_context or 0
  local uri = location.targetUri or location.uri
  if uri == nil then
    return
  end
  local bufnr = vim.uri_to_bufnr(uri)
  if not vim.api.nvim_buf_is_loaded(bufnr) then
    vim.fn.bufload(bufnr)
  end

  local range = location.targetRange or location.range
  local contents = vim.api.nvim_buf_get_lines(
    bufnr,
    range.start.line - before_context,
    range["end"].line + 1 + context,
    false
  )
  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
  return vim.lsp.util.open_floating_preview(
    contents,
    filetype,
    { border = "single" }
  )
end

function lsp_conf.preview_location_callback(_, result)
  local context = 15
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  if vim.tbl_islist(result) then
    lsp_conf.floating_buf, lsp_conf.floating_win = lsp_conf.preview_location(
      result[1],
      context
    )
  else
    lsp_conf.floating_buf, lsp_conf.floating_win = lsp_conf.preview_location(
      result,
      context
    )
  end
end

function lsp_conf.PeekDefinition()
  if vim.tbl_contains(vim.api.nvim_list_wins(), lsp_conf.floating_win) then
    vim.api.nvim_set_current_win(lsp_conf.floating_win)
  else
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(
      0,
      "textDocument/definition",
      params,
      lsp_conf.preview_location_callback
    )
  end
end

function lsp_conf.PeekTypeDefinition()
  if vim.tbl_contains(vim.api.nvim_list_wins(), lsp_conf.floating_win) then
    vim.api.nvim_set_current_win(lsp_conf.floating_win)
  else
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(
      0,
      "textDocument/typeDefinition",
      params,
      lsp_conf.preview_location_callback
    )
  end
end

function lsp_conf.PeekImplementation()
  if vim.tbl_contains(vim.api.nvim_list_wins(), lsp_conf.floating_win) then
    vim.api.nvim_set_current_win(lsp_conf.floating_win)
  else
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(
      0,
      "textDocument/implementation",
      params,
      lsp_conf.preview_location_callback
    )
  end
end

require "configs.lsp.signs"
require "configs.lsp.border"

local lspconfig = require "lspconfig"
local configs = require "lspconfig/configs"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport =
  true
capabilities.textDocument.completion.completionItem.tagSupport = {
  valueSet = { 1 },
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}
capabilities.textDocument.codeAction = {
  dynamicRegistration = false,
  codeActionLiteralSupport = {
    codeActionKind = {
      valueSet = {
        "",
        "quickfix",
        "refactor",
        "refactor.extract",
        "refactor.inline",
        "refactor.rewrite",
        "source",
        "source.organizeImports",
      },
    },
  },
}

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

local servers = {
  pyright = {},
  -- bashls = {},
  dockerls = {},
  tsserver = {},
  cssls = { cmd = { "css-languageserver", "--stdio" } },
  rnix = {},
  texlab = require("configs.tex").config(),
  html = { cmd = { "html-languageserver", "--stdio" } },
  intelephense = {},
  sumneko_lua = {
    cmd = lua_cmd,
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand "~/.config/nvim/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 1000,
        },
      },
    },
  },
  -- efm = require("config.lsp.efm").config,
  vimls = {},
  -- tailwindcss = {},
}

require("lspinstall").setup() -- important

local lspinstall_servers = require("lspinstall").installed_servers()
for _, server in pairs(lspinstall_servers) do
  if server ~= "lua" then
    require("lspconfig")[server].setup {}
  end
end

local function on_attach(client, bufnr)
  require("configs.lsp.on_attach").setup(client, bufnr)
end

local luadev = require("lua-dev").setup {
  lspconfig = servers.sumneko_lua,
}
-- lspconfig.sumneko_lua.setup(luadev)

for server, config in pairs(servers) do
  -- if server == "sumneko_lua" then
  --   break
  -- end
  lspconfig[server].setup(vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }, config))
  local cfg = lspconfig[server]
  if not (cfg and cfg.cmd and vim.fn.executable(cfg.cmd[1]) == 1) then
    util.error(server .. ": cmd not found: " .. vim.inspect(cfg.cmd))
  end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    update_in_insert = false,
    virtual_text = false,
    severity_sort = true,
  }
)
return lsp_conf
