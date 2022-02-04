---@type nvim_config.utils
local u = require("utils")

vim.cmd([[autocmd! BufWinEnter COMMIT_EDITMSG set filetype=gitcommit]], false)
vim.cmd([[autocmd! BufWinEnter *.cpp set filetype=cpp]], false)

-- vim.cmd([[
--   au CmdLineEnter * set norelativenumber
--   au CmdLineLeave * set relativenumber
-- ]])
-- cmd [[autocmd! BufWritePost *.lua !stylua %]]

vim.cmd([[au BufReadPost * lua require"utils".last_place()]])

-- show cursor line only in active window
vim.cmd([[
  autocmd InsertLeave,WinEnter,CmdlineLeave * set cursorline
  autocmd InsertLeave,WinEnter * set cursorline
  autocmd InsertEnter,WinLeave,CmdlineEnter * set nocursorline
  autocmd InsertEnter,WinLeave * set nocursorline
]])

-- windows to close with "q"
vim.cmd(
    [[autocmd FileType help,startuptime,qf,lspinfo nnoremap <buffer><silent> q :close<CR>]]
)
vim.cmd([[autocmd FileType man nnoremap <buffer><silent> q :quit<CR>]])

vim.cmd([[au FocusGained * :checktime]])

u.create_augroup({
    "TextYankPost * silent! lua vim.highlight.on_yank{higroup='IncSearch',timeout=200}",
}, "highlight_yank")

vim.cmd([[
  augroup nvim-luadev
    autocmd!
    function! SetLuaDevOptions()
      nmap <buffer> <C-c><C-c> <Plug>(Luadev-RunLine)
      vmap <buffer> <C-c><C-c> <Plug>(Luadev-Run)
      nmap <buffer> <C-c><C-k> <Plug>(Luadev-RunWord)
      map  <buffer> <C-x><C-p> <Plug>(Luadev-Complete)
      set filetype=lua
    endfunction
    autocmd BufEnter \[nvim-lua\] call SetLuaDevOptions()
  augroup end
]])

u.create_augroup({
    "BufNewFile,BufRead,BufWinEnter *.{md,txt,tex,html,norg} set spell",
    "BufNewFile,BufRead,BufWinEnter *.{md,txt,tex,html,norg} set spelllang=de,en",
    "BufNewFile,BufRead,BufWinEnter *.lua set shiftwidth=4",
    "BufNewFile,BufRead,BufWinEnter *.lua set tabstop=2",
    "BufNewFile,BufRead,BufWinEnter *.{java,py} set tabstop=4",
    -- "BufNewFile,BufRead,BufWinEnter * set formatoptions-=o",
    "BufNewFile,BufRead,BufWinEnter *tex set filetype=tex",
}, "filetypes")

u.create_augroup({
    "TextChanged, BufChangedI, BufWinEnter * let w:m1=matchadd('Search', '\\%81v.\\%>80v', -1)",
}, "column_limit")

vim.cmd(
    "autocmd User TelescopeFindPre lua vim.opt.laststatus=0; vim.cmd[[autocmd BufWinLeave * ++once lua vim.opt.laststatus=2]]"
)

vim.cmd([[
    autocmd VimLeavePre * lua require"custom.db".set_db()
]])

vim.cmd([[autocmd BufEnter cfg.json set ft=jsonc]])
