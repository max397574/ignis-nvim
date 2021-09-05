" move throught completitions with tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" add j and k with count to jumplis
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'

augroup random
    autocmd!
    au BufWinEnter *.{py,java,html,c,cpp,cs,vim} 
      \let w:m1=matchadd('Search', '\%<81v.\%>80v', -1)
augroup END

" Tablemode
let g:table_mode_corner='|'

function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()

" Tablemode
inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<CR><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<CR>' : '__'

" UltiSnips
let g:UltiSnipsExpandTrigger='<leader><tab>'
let g:UltiSnipsJumpForwardTrigger='<leader><tab>'
let g:UltiSnipsSnippetDirectories=["UltiSnips", "my_snippets"]
