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
    group = netrw,
})
aucmd({ "TextChanged" }, {
    pattern = "*",
    callback = function()
        require("ignis.core.settings.netrw").draw_icons()
    end,
    group = netrw,
})
aucmd({ "Filetype" }, {
    pattern = "netrw",
    callback = function()
        require("ignis.core.settings.netrw").set_maps()
    end,
    group = netrw,
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

aucmd(
    { "FileType" },
    { pattern = "man", command = "nnoremap <buffer><silent> q :quit<CR>" }
)

aucmd("FocusGained", { pattern = "*", command = "checktime" })

aucmd({ "TextYankPost" }, {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higrou = "IncSearch", timeout = 500 })
    end,
    group = vim.api.nvim_create_augroup("higlhight_yank", { clear = true }),
})

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

-- TODO:
aucmd({ "BufNewFile", "BufRead", "BufWinEnter" }, {
    pattern = "*.tex",
    callback = function()
        vim.bo.filetype = "tex"
    end,
})
-- u.create_augroup({
--     "TextChanged, BufChangedI, BufWinEnter * let w:m1=matchadd('Search', '\\%81v.\\%>80v', -1)",
-- }, "column_limit")

aucmd("VimLeavePre", {
    callback = function()
        require("custom.db").set_db()
    end,
})

aucmd("BufEnter", { pattern = "cfg.json", command = "set fg=jsonc" })

local called_func = false
local timer = nil
local space_used
local function reset_timer(text_changed)
    if timer and not vim.loop.is_closing(timer) then
        vim.loop.timer_stop(timer)
        vim.loop.close(timer)
        timer = nil
    end
    if called_func then
        return
    end
    if text_changed then
        if timer then
            vim.loop.timer_stop(timer)
            vim.loop.close(timer)
            timer = nil
        end
        return
    end
    if vim.v.char and vim.v.char ~= " " then
        space_used = false
        return
    end
    if vim.fn.mode() ~= "i" then
        return
    end
    if space_used then
        return
    end
    space_used = true
    timer = vim.defer_fn(function()
        called_func = true
        local function feed(keys)
            vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes(keys, true, true, true),
                "n",
                false
            )
        end

        if vim.tbl_contains({ 1, 2, 0 }, #vim.fn.expand("<cword>")) then
            return
        end

        feed("<esc>blgulhela")
        timer = nil
        called_func = false
    end, 100)
end

aucmd("InsertCharPre", {
    pattern = "*.tex",
    callback = function()
        reset_timer()
    end,
})

aucmd({ "BufEnter", "BufReadPost" }, {
    callback = function()
        require("custom.refactor").find_else()
    end,
})
local in_mathzone = require("ignis.utils").in_mathzone

aucmd("CursorHold", {
    pattern = "*.tex",
    callback = function()
        if in_mathzone() then
            require("nabla").popup()
        end
    end,
})
