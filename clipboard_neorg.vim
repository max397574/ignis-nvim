nnoremap silent <C-p> :call NeorgClipboardImage()<CR>
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

function! NeorgClipboardImage() abort
  " Create `img` directory if it doesn't exist
  let img_dir = getcwd() . '/imgs'
  if !isdirectory(img_dir)
    silent call mkdir(img_dir)
  endif

  " First find out what filename to use
  let index = 1
  let file_path = img_dir . "/image" . index . ".png"
  while filereadable(file_path)
    let index = index + 1
    let file_path = img_dir . "/image" . index . ".png"
  endwhile

  let clip_command = 'osascript'
  let clip_command .= ' -e "set png_data to the clipboard as «class PNGf»"'
  let clip_command .= ' -e "set referenceNumber to open for access POSIX path of'
  let clip_command .= ' (POSIX file \"' . file_path . '\") with write permission"'
  let clip_command .= ' -e "write png_data to referenceNumber"'

  let pwd = execute("pwd")
  silent call system(clip_command)
  if v:shell_error == 1
    normal! p
    echoerr "Error: Missing Image in Clipboard"
  else
    let caption = getline('.')
    execute "normal! ddo" .
    \"{file://".pwd."/imgs/image" . index . ".png}[".caption."]\r"
    execute "normal! ki\b"
  endif
endfunction
