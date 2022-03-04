local u = require("ignis.utils")
local aucmd = vim.api.nvim_create_autocmd

local ft_aucmd = function(pattern, ft)
    aucmd({ "BufWinEnter" }, {
        pattern = pattern,
        command = [[set ft=]] .. ft,
        once = false,
    })
end

ft_aucmd("COMMIT_EDITMSG", "gitcommit")
ft_aucmd("*.cpp", "cpp")

aucmd({ "BufEnter", "BufWinEnter" }, {
    pattern = "neorg://*",
    command = [[set foldlevel=1000]],
})

aucmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.norg",
    command = "setlocal filetype=norg",
})

local netrw = vim.api.nvim_create_augroup("netrw", { clear = true })
aucmd({ "Filetype" }, {
    pattern = "netrw",
    callback = function()
        require("ignis.core.settings.netrw").draw_icons()
    end,
    group = "netrw",
})
aucmd({ "TextChanged" }, {
    pattern = "*",
    callback = function()
        require("ignis.core.settings.netrw").draw_icons()
    end,
    group = "netrw",
})
aucmd({ "Filetype" }, {
    pattern = "netrw",
    callback = function()
        require("ignis.core.settings.netrw").set_maps()
    end,
    group = "netrw",
})

-- show cursor line only in active window
aucmd(
    { "InsertLeave", "WinEnter", "CmdlineLeave" },
    { pattern = "*", command = "set cursorline" }
)
aucmd(
    { "InsertEnter", "WinLeave", "CmdlineEnter" },
    { pattern = "*", command = "set nocursorline" }
)

-- windows to close with "q"
aucmd({ "FileType" }, {
    pattern = { "help", "startuptime", "qf", "lspinfo" },
    callback = function()
        vim.keymap.set("n", "q", function()
            vim.cmd([[close]])
        end, {
            noremap = true,
            silent = true,
            buffer = true,
        })
    end,
})

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

-- vim.cmd(
--     "autocmd User TelescopeFindPre lua vim.opt.laststatus=0; vim.cmd[[autocmd BufWinLeave * ++once lua vim.opt.laststatus=2]]"
-- )

vim.cmd([[
    autocmd VimLeavePre * lua require"custom.db".set_db()
]])

vim.cmd([[autocmd BufEnter cfg.json set ft=jsonc]])
