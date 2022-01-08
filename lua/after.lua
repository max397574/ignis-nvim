vim.cmd([[hi CursorLineNr gui=none]])
vim.cmd([[hi packerSuccess guifg=#61afef gui=none]])
vim.cmd([[highlight link LspReferenceWrite Visual]])
vim.cmd([[highlight link LspReferenceRead Visual]])
vim.cmd([[highlight link LspReferenceText Visual]])
vim.cmd([[sunmap s]])
vim.cmd([[sunmap f]])
vim.cmd([[highlight NeorgLinkLocationURL gui=none]])
vim.cmd([[hi TelescopeBorder guifg=#252931 guibg=#252931  ]])
vim.cmd([[
  let g:seak_enabled = v:true
  cnoremap <C-j> <Cmd>call seak#select({ 'nohlsearch': v:true })<CR>
]])