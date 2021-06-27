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
