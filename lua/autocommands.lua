local u = require("utils")

u.create_augroup("highlight_yank", { "TextYankPost * silent! lua vim.highlight.on_yank{higroup='IncSearch', timeout=700}" })
