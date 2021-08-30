local signs = { Error = "", Warning = "", Hint = "", Information = "" }

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  local numhl = "LspDiagnosticsDefault" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = numhl })
end
