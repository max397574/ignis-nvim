function! MdHeading1()
    normal! yypVr=
endfunction

function! MdHeading2()
    normal! yypVr-
endfunction

function! MdHeading3()
    normal! 0i### 
endfunction

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

function! MdUnorderedList()
    normal! 3o* List Item
    normal! 2k
endfunction

function! MdOrderedList()
    normal! i1. List Item
    normal! o2. List Item
    normal! o3. List Item
endfunction

function! MdHorizontalRule()
    normal! o---
    normal! j
endfunction
