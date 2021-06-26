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
