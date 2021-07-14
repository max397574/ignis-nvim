function! RangeSubstitue(range)
    execute 'nnoremap <leader>s' . a:range . ' V' . a:range . ':s/\%V//g<LEFT><LEFT><LEFT>'
endfunction
