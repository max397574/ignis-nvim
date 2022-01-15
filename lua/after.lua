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
" Overwrite / and ?.
nnoremap ? <Cmd>call searchx#start({ 'dir': 0 })<CR>
nnoremap / <Cmd>call searchx#start({ 'dir': 1 })<CR>
xnoremap ? <Cmd>call searchx#start({ 'dir': 0 })<CR>
xnoremap / <Cmd>call searchx#start({ 'dir': 1 })<CR>
cnoremap ; <Cmd>call searchx#select()<CR>

" Move to next/prev match.
nnoremap N <Cmd>call searchx#prev_dir()<CR>
nnoremap n <Cmd>call searchx#next_dir()<CR>
xnoremap N <Cmd>call searchx#prev_dir()<CR>
xnoremap n <Cmd>call searchx#next_dir()<CR>

let g:searchx = {}

" Auto jump if the recent input matches to any marker.
let g:searchx.auto_accept = v:true

" The scrolloff value for moving to next/prev.
let g:searchx.scrolloff = &scrolloff

" To enable scrolling animation.
let g:searchx.scrolltime = 500

" Marker characters.
let g:searchx.markers = split('ABCDEFGHIJKLMNOPQRSTUVWXYZ', '.\zs')

" Convert search pattern.
function g:searchx.convert(input) abort
  if a:input !~# '\k'
    return '\V' .. a:input
  endif
    return a:input[0] .. substitute(a:input[1:], '\\\@<! ', '.\\{-}', 'g')
endfunction
]])
