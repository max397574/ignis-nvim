local u = require("utils")

u.create_augroup({ "TextYankPost * silent! lua vim.highlight.on_yank{higroup='IncSearch',timeout=700}" },
"highlight_yank")

vim.cmd("let ErrorMsg='Duplicate edit session (readonly)'")
u.create_augroup({"SwapExists * let v:swapchoice = 'o'",
  "SwapExists * echomsg ErrorMsg",
  "SwapExists * echo 'Duplicate edit session (readonly)'",
  "SwapExists * echohl None",
  "SwapExists * sleep 2"},
  "NoSimultaneousEdits")

u.create_augroup({"BufNewFile,BufRead,BufWinEnter *.html syntax on",
"BufNewFile,BufRead,BufWinEnter *.{md,txt,html} set spell",
"BufNewFile,BufRead,BufWinEnter *.vim set foldmethod=marker",
"BufNewFile,BufRead,BufWinEnter *.lua set shiftwidth=2",
"BufNewFile,BufRead,BufWinEnter *.lua set tabstop=2",
"BufNewFile,BufRead,BufWinEnter *.{java,py} set tabstop=4",
"BufNewFile,BufRead,BufWinEnter * set formatoptions-=o",
"BufNewFile,BufRead,BufWinEnter *tex set filetype=tex"},
"filetypes")
