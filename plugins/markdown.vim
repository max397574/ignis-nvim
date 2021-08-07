function! VisualItalic()
    normal! `<mm
    normal! `>
    normal! a*
    normal! `<
    normal! i*
    normal! `m
endfunction

function! VisualBold()
    normal! `<mm
    normal! `>
    normal! a**
    normal! `<
    normal! i**
    normal! `m
endfunction
