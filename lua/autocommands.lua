local u = require "utils"

u.create_augroup({
  "TextYankPost * silent! lua vim.highlight.on_yank{higroup='IncSearch',timeout=700}",
}, "highlight_yank")

u.create_augroup({
  "BufNewFile,BufRead,BufWinEnter *.{md,txt,tex,html} set spell",
  "BufNewFile,BufRead,BufWinEnter *.{md,txt,tex,html} set spelllang+=de",
  "BufNewFile,BufRead,BufWinEnter *.lua set shiftwidth=2",
  "BufNewFile,BufRead,BufWinEnter *.lua set tabstop=2",
  "BufNewFile,BufRead,BufWinEnter *.{java,py} set tabstop=4",
  "BufNewFile,BufRead,BufWinEnter * set formatoptions-=o",
  "BufNewFile,BufRead,BufWinEnter *tex set filetype=tex",
}, "filetypes")

u.create_augroup({
  "TextChanged, BufChangedI, BufWinEnter * let w:m1=matchadd('Search', '\\%81v.\\%>80v', -1)",
}, "column_limit")
