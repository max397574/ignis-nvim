vim.cmd([[PackerLoad lua-dev.nvim]])
vim.cmd([[hi DiagnosticHeader gui=bold,italic guifg=#56b6c2]])
vim.cmd(
  [[au CursorHold  * lua vim.diagnostic.open_float(0, { focusable = false,scope = "cursor",source = true,format = function(diagnostic) return require'configs.lsp'.parse_diagnostic(diagnostic) end, header = {"Cursor Diagnostics:","DiagnosticHeader"}, prefix = function(diagnostic,i,total) local icon, highlight if diagnostic.severity == 1 then icon = ""; highlight ="DiagnosticError" elseif diagnostic.severity == 2 then icon = ""; highlight ="DiagnosticWarn" elseif diagnostic.severity == 3 then icon = ""; highlight ="DiagnosticInfo" elseif diagnostic.severity == 4 then icon = ""; highlight ="DiagnosticHint" end return i.."/"..total.." "..icon.."  ",highlight end})]]
)
-- vim.cmd([[au CursorHold  * lua vim.diagnostic.open_float(0,{scope = "cursor"})]])

---@type nvim_config.utils
local util = require("utils")

local root_pattern = require("lspconfig.util").root_pattern

local lua_cmd = {
  vim.fn.expand("~") .. "/lua-language-server/bin/macOS/lua-language-server",
}

local lsp_conf = {}

function lsp_conf.parse_diagnostic(diagnostic)
  return diagnostic.message
end

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

local signs = { Error = "", Warn = "", Info = "", Hint = "" }
for sign, icon in pairs(signs) do
  vim.fn.sign_define("DiagnosticSign" .. sign, {
    text = icon,
    texthl = "Diagnostic" .. sign,
    linehl = false,
    numhl = "Diagnostic" .. sign,
  })
end
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
  vim.lsp.handlers.signature_help,
  { border = border }
)

local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

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

local function on_attach(client, bufnr)
  require("configs.lsp.on_attach").setup(client, bufnr)
end

local servers = {
  pyright = {},
  jedi_language_server = {},
  -- bashls = {},
  dockerls = {},
  tsserver = {},
  clangd = {},
  cssls = { cmd = { "css-languageserver", "--stdio" } },
  rnix = {},
  hls = {
    root_dir = root_pattern(
      ".git",
      "*.cabal",
      "stack.yaml",
      "cabal.project",
      "package.yaml",
      "hie.yaml"
    ),
  },
  texlab = require("configs.tex").config(),
  html = { cmd = { "html-languageserver", "--stdio" } },
  intelephense = {},
  -- efm = require("configs.lsp.efm").config,
  vimls = {},
  -- tailwindcss = {}, -- installed but not used too much cpu
}
local sumneko_lua_server = {
  on_attach = on_attach,
  cmd = lua_cmd,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        globals = { "vim", "dump", "hs", "lvim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("~/.config/nvim_config/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 1000,
      },
    },
  },
}

local luadev = require("lua-dev").setup({
  library = {
    vimruntime = true,
    types = true,
    plugins = false,
  },
  lspconfig = sumneko_lua_server,
})
lspconfig.sumneko_lua.setup(luadev)

for server, config in pairs(servers) do
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
    signs = true,
    underline = true,
    update_in_insert = false,
    virtual_text = false,
    severity_sort = true,
  }
)

configs.emmet_ls = {
  default_config = {
    cmd = { "ls_emmet", "--stdio" },
    filetypes = {
      "html",
      "css",
      "scss",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "haml",
      "xml",
      "xsl",
      "pug",
      "slim",
      "sass",
      "stylus",
      "less",
      "sss",
    },
    root_dir = function(fname)
      return vim.loop.cwd()
    end,
    settings = {},
  },
}

lspconfig.emmet_ls.setup({ capabilities = capabilities })

return lsp_conf
