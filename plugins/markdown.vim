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

function! MdHorizontalRule()
    normal! o---
    normal! j
endfunction
