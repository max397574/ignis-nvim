vnoremap <leader>s :s///g<LEFT><LEFT><LEFT>
nmap <leader>ss 0v$ s
function! RangeSubstitue(range)
    execute 'nmap <leader>s' . a:range . ' V' . a:range .  'j s'
endfunction

for amount in range(1,10)
    execute 'call RangeSubstitue(amount)'
endfor

call RangeSubstitue('G')

