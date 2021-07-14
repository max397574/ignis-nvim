function! RangeSubstitue(range)
    execute 'nnoremap <leader>s' . a:range . ' V' . a:range . ':s/\%V//g<LEFT><LEFT><LEFT>'
endfunction

for amount in range(1,10)
    let area=amount . 'j'
    execute 'call RangeSubstitue(area)'
endfor

call RangeSubstitue('G')

vnoremap <leader>s :s/\%V//g<LEFT><LEFT><LEFT>
