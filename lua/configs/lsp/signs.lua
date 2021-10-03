vim.cmd [[
  highlight LspDiagnosticsLineNrError guifg=#FF0000
  highlight LspDiagnosticsLineNrWarning guifg=#FFA500
  highlight LspDiagnosticsLineNrInformation guifg=#EDB200
  highlight LspDiagnosticsLineNrHint guifg=#3793BA

  sign define DiagnosticSignError text= texthl=LspDiagnosticsSignError linehl= numhl=LspDiagnosticsLineNrError
  sign define DiagnosticSignWarn text= texthl=LspDiagnosticsSignWarning linehl= numhl=LspDiagnosticsLineNrWarning
  sign define DiagnosticSignInfo text= texthl=LspDiagnosticsSignInformation linehl= numhl=LspDiagnosticsLineNrInformation
  sign define DiagnosticSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=LspDiagnosticsSignHint
]]
