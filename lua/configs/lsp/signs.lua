local signs = {Error="", Warn="", Info="", Hint=""}
for sign, icon in pairs(signs) do
  vim.fn.sign_define("DiagnosticSign"..sign,{text = icon, texthl = "Diagnostic"..sign, linehl = false, numhl = "Diagnostic"..sign})
end
