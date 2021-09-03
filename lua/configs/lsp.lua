vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true, -- this
  update_in_insert = false,
  virtual_text = true,
  severity_sort = true,
})

local signs = { Error = "", Warning = "", Hint = "", Information = "" }

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  local numhl = "LspDiagnosticsDefault" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = numhl })
end
