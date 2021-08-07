" move throught completitions with tab
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" add j and k with count to jumplis
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
