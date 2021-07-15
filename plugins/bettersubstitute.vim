vnoremap <leader>s :s/\%V//g<LEFT><LEFT><LEFT>
nmap <leader>ss 0v$ s
function! RangeSubstitue(range)
    "select range visually and use visuall mapping from above
    execute 'nmap <leader>s' . a:range . ' V' . a:range .  'j s'
endfunction

for amount in range(1,10)
    execute 'call RangeSubstitue(amount)'
endfor

call RangeSubstitue('G')

