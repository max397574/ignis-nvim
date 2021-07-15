vnoremap <leader>s :s/\%V//g<LEFT><LEFT><LEFT>

function! RangeSubstitue(range)
    "select range visually and use visuall mapping from above
    execute 'nmap <leader>s' . a:range . ' V' . a:range . ' s'
endfunction

for amount in range(1,10)
    let area=amount . 'j'
    execute 'call RangeSubstitue(area)'
endfor

call RangeSubstitue('G')

