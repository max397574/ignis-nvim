
" /$$           /$$   /$$                /$$
"|__/          |__/  | $$               |__/
" /$$ /$$$$$$$  /$$ /$$$$$$   /$$    /$$ /$$ /$$$$$$/$$$$
"| $$| $$__  $$| $$|_  $$_/  |  $$  /$$/| $$| $$_  $$_  $$
"| $$| $$  \ $$| $$  | $$     \  $$/$$/ | $$| $$ \ $$ \ $$
"| $$| $$  | $$| $$  | $$ /$$  \  $$$/  | $$| $$ | $$ | $$
"| $$| $$  | $$| $$  |  $$$$//$$\  $/   | $$| $$ | $$ | $$
"|__/|__/  |__/|__/   \___/ |__/ \_/    |__/|__/ |__/ |__/
luafile ~/.config/nvim/future_init.lua


"{{{============================================================== Highlights

"line number where cursor is has different color
highlight CursorLineNr term=bold ctermfg=11 gui=bold guifg=Yellow

"the search results
highlight       Search    ctermfg=White  ctermbg=Black  cterm=bold
"the first search result
highlight    IncSearch    ctermfg=White  ctermbg=grey   cterm=bold

set background=dark

highlight GreenString guifg=#207245
highlight BlueOperator guifg=#3572A5
highlight BlueNumber guifg=#519ABA
highlight RedConditional guifg=#B30B00
highlight YellowVariable ctermfg=214 guifg=#FABD2F
highlight PurpleBoolean guifg=#6600CC
highlight LightBlueConstant guifg=#009999
highlight RedLoops guifg=#CC0000
highlight GreenFunction guifg=#8ABB26 cterm=bold



highlight LspDiagnosticsDefaultError ctermbg=none guibg=none ctermfg=167 guifg=#FB4934
highlight LspDiagnosticsDefaultHint ctermbg=none guibg=none ctermfg=109 guifg=#519ABA
highlight LspDiagnosticsDefaultWarning ctermbg=none guibg=none ctermfg=208 guifg=#FE8019
highlight LspDiagnosticsDefaultInformation ctermbg=none guibg=none ctermfg=214 guifg=#FABD2F

highlight VimCommand ctermfg=12 guifg=#B30B00
highlight VimVar guifg=#009999
highlight VimString guifg=#207245
highlight VimAttrib guifg=#207245
highlight VimOption guifg=#9ABB26
highlight VimIsCommand guifg=#FE8019
highlight VimUsrCmd guifg=#FE8019

highlight ItalicRed term=italic ctermfg=12 gui=italic guifg=#b30b00
highlight Folded term=bold cterm=italic ctermfg=white gui=italic guifg=white
highlight Folded guibg=none ctermbg=none

"transparent background
highlight  Normal   guibg=none
highlight  Normal   ctermbg=none
highlight NonText   ctermbg=none
highlight NonText   guibg=none
hi! EndOfBuffer ctermbg=none ctermfg=none guibg=none guifg=none

"comments are important :)
highlight Comment term=bold cterm=italic ctermfg=white gui=italic guifg=white
highlight WhiteOnRed ctermbg=red guibg=red ctermfg=white guifg=white

function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#\%('.@/.'\)'
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction
"}}}
