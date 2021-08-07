local u = require("utils")

u.create_augroup({ "TextYankPost * silent! lua vim.highlight.on_yank{higroup='IncSearch', timeout=700}" }, "highlight_yank")
u.create_augroup({"StdinReadPre * let s:std_in=1","VimEnter * if argc() == 0 && !exists('s:std_in') | Sex | wincmd j | close | endif"}, "SexNoArgs")
