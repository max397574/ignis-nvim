local u = require("ignis.utils")
local aucmd = vim.api.nvim_create_autocmd

local ft_aucmd = function(pattern, ft)
    aucmd({ "BufRead", "BufEnter", "BufNewFile" }, {
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
    desc = "Draw netrw icons",
    group = netrw,
})
aucmd({ "TextChanged" }, {
    pattern = "*",
    callback = function()
        require("ignis.core.settings.netrw").draw_icons()
    end,
    desc = "Draw netrw icons",
    group = netrw,
})
aucmd({ "Filetype" }, {
    pattern = "netrw",
    callback = function()
        require("ignis.core.settings.netrw").set_maps()
    end,
    desc = "Define netrw mappings",
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
    desc = "Map q to close buffer",
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
    desc = "Highlight yanked text",
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
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
    desc = "Set filetype to tex",
})
-- u.create_augroup({
--     "TextChanged, BufChangedI, BufWinEnter * let w:m1=matchadd('Search', '\\%81v.\\%>80v', -1)",
-- }, "column_limit")

aucmd("VimLeavePre", {
    callback = function()
        require("custom.db").set_db()
    end,
    desc = "Set colorscheme in db",
})

aucmd("BufEnter", { pattern = "cfg.json", command = "set ft=jsonc" })

local timer = nil
local called_by_func = false
local function make_second_lowercase()
    if timer and (not vim.loop.is_closing(timer)) then
        pcall(vim.loop.timer_stop, timer)
        pcall(vim.loop.close, timer)
        called_by_func = false
        timer = nil
    end
    if vim.v.char and vim.v.char ~= " " then
        return
    end
    if called_by_func then
        return
    end
    if vim.fn.mode() ~= "i" then
        return
    end
    timer = vim.defer_fn(function()
        called_by_func = true
        vim.api.nvim_input("<esc>bl")
        vim.defer_fn(function()
            if vim.tbl_contains({ 1, 2, 0 }, #vim.fn.expand("<cword>")) then
                vim.api.nvim_input("hela")
                return
            end
            vim.api.nvim_input("gulhela")
            timer = nil
            called_by_func = false
        end, 1)
    end, 200)

    print(vim.v.char)
end

-- aucmd("InsertCharPre", {
--     pattern = { "*.tex", "*.norg" },
--     callback = function()
--         make_second_lowercase()
--     end,
-- })

aucmd({ "BufEnter", "BufReadPost" }, {
    callback = function()
        require("custom.refactor").find_else()
    end,
    desc = "Set sign on lines with else",
})
local in_mathzone = require("ignis.utils").in_mathzone

aucmd("CursorHold", {
    pattern = "*.tex",
    callback = function()
        if in_mathzone() then
            require("nabla").popup()
        end
    end,
    desc = "Open nabla",
})

aucmd("User", {
    pattern = "PackerCompileDone",
    callback = function()
        vim.api.nvim_chan_send(
            vim.v.stderr,
            "\027]99;i=1:d=0;Packer.nvim\027\\"
        )
        vim.api.nvim_chan_send(
            vim.v.stderr,
            "\027]99;i=1:d=1:p=body;Compile finished\027\\"
        )
    end,
    desc = "Send desktop notification",
})

aucmd("DiagnosticChanged", {
    once = true,
    callback = function()
        vim.api.nvim_chan_send(vim.v.stderr, "\027]99;i=1:d=0;Lsp\027\\")
        vim.api.nvim_chan_send(
            vim.v.stderr,
            "\027]99;i=1:d=1:p=body;Finished Loading\027\\"
        )
    end,
    desc = "Send desktop notification",
})

aucmd("User", {
    once = true,
    callback = function()
        vim.api.nvim_chan_send(vim.v.stderr, "\027]99;i=1:d=0;Neorg\027\\")
        vim.api.nvim_chan_send(
            vim.v.stderr,
            "\027]99;i=1:d=1:p=body;Finished Loading\027\\"
        )
    end,
    pattern = "NeorgStarted",
    desc = "Send desktop notification",
})
