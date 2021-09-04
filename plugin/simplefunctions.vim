" highlight group of text under cursor
function! SynGroup()                                                            
    let l:s = synID(line('.'), col('.'), 1)                                       
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

" write latex file, create pdf and open in preview
function! LatexPreview()
    write
    silent !pdflatex %; open %:t:r.pdf
endfunction
