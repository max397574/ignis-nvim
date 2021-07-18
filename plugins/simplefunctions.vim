function! Surrondiwquotes()
    normal! e
    normal! a"
    normal! hbi"
endfunction

function! MoveLineUp()
    normal! dd
    normal! kk
    normal! p
endfunction

function! MoveLineDown()
    normal! dd
    normal! p
endfunction

function! AddLineAbove()
    normal! O
    normal! xj
endfunction

function! AddLineBelow()
    normal! o
    normal! xk
endfunction

function! ConvertWordUppercase()
    normal! viwU
endfunction

function! SynGroup()                                                            
    let l:s = synID(line('.'), col('.'), 1)                                       
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
