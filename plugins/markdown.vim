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

function! MdLink()
    normal! i[text](link)
    normal! 7h
    normal! viw
endfunction

function! MdHorizontalRule()
    normal! o---
    normal! j
endfunction
