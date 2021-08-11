"line number where cursor is has different color
highlight CursorLineNr term=bold ctermfg=214 gui=bold guifg=#FABD2F guibg=none ctermbg=none
highlight CursorLine ctermbg=237 guibg=#3C3836
highlight LineNr ctermfg=243 guifg=#7C6F64

highlight StatusLine cterm=reverse ctermfg=239 ctermbg=223 gui=reverse guifg=#504945 guibg=#EBDBB2

"the search results
highlight       Search    ctermfg=White  ctermbg=Black  cterm=bold
"the first search result
highlight    IncSearch    ctermfg=White  ctermbg=grey   cterm=bold

highlight markdownItalic gui=italic

"{{{ Syntax Highlights
highlight GreenString guifg=#207245
highlight BlueOperator guifg=#3572A5
highlight BlueNumber guifg=#519ABA
highlight RedConditional guifg=#B30B00
highlight YellowVariable ctermfg=214 guifg=#FABD2F
highlight PurpleBoolean guifg=#6600CC
highlight LightBlueConstant guifg=#009999
highlight RedLoops guifg=#CC0000
highlight GreenFunction guifg=#8ABB26 cterm=bold
"1}}}

highlight diffAdded guifg=#8ABB26 cterm=bold
highlight gitDiff guifg=#FFFFFF

highlight preProc guifg=#4090FF
highlight fugitiveHunk guifg=#FFFFFF

highlight SignColumn ctermbg=none guibg=none

"{{{ Signify
highlight SignifyLineChange ctermfg=108 ctermbg=none guifg=#FE8019 guibg=none
highlight SignifySignChange ctermfg=108 ctermbg=none guifg=#FE8019 guibg=none
highlight SignifyLineAdd ctermfg=142 ctermbg=none guifg=#B8BB26 guibg=none
highlight SignifySignAdd ctermfg=142 ctermbg=none guifg=#B8BB26 guibg=none
highlight SignifyLineDelete guifg=#D82B26 guibg=none
highlight SignifySignDelete guifg=#D82B26 guibg=none
"1}}}

"{{{ Lsp
highlight LspDiagnosticsDefaultError ctermbg=none guibg=none ctermfg=167 guifg=#FB4934
highlight LspDiagnosticsDefaultHint ctermbg=none guibg=none ctermfg=109 guifg=#519ABA
highlight LspDiagnosticsDefaultWarning ctermbg=none guibg=none ctermfg=208 guifg=#FE8019
highlight LspDiagnosticsDefaultInformation ctermbg=none guibg=none ctermfg=214 guifg=#FABD2F
"1}}}

"{{{ Vim Highlighting
highlight VimCommand ctermfg=12 guifg=#B30B00
highlight VimVar guifg=#009999
highlight VimString guifg=#207245
highlight VimAttrib guifg=#207245
highlight vimHiAttrib guifg=#207245
highlight VimOption guifg=#9ABB26
highlight VimIsCommand guifg=#FE8019
highlight VimUsrCmd guifg=#FE8019
highlight vimHiGroup guifg=#316AD0
highlight vimGroup guifg=#316AD0
highlight vimHiGuiFgBg ctermfg=214 gui=bold guifg=#FABD2F
highlight vimHiCtermFgBg ctermfg=214 guifg=#FABD2F
highlight vimHiCTerm ctermfg=214 guifg=#FABD2F
highlight vimHiTerm ctermfg=214 guifg=#FABD2F
highlight vimFgBgAttrib ctermfg=108 guifg=#8EC07C
"1}}}

highlight ItalicRed term=italic ctermfg=12 gui=italic guifg=#b30b00
highlight Folded term=bold cterm=italic ctermfg=white gui=italic guifg=white
highlight Folded guibg=none ctermbg=none

"{{{ transparent background
highlight  Normal   guibg=none
highlight  Normal   ctermbg=none
highlight NonText   ctermbg=none
highlight NonText   guibg=none
highlight! EndOfBuffer ctermbg=none ctermfg=none guibg=none guifg=none
"1}}}

"comments are important :)
highlight Comment term=bold cterm=italic ctermfg=white gui=italic guifg=white
highlight WhiteOnRed ctermbg=red guibg=red ctermfg=white guifg=white
