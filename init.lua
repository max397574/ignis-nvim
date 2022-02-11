vim.g.start_time = vim.fn.reltime()

local module_loader = require("ignis.utils").load_module
-- vim.g.did_indent_on = false

-- vim.cmd([[
-- " filetype off
-- filetype plugin indent off
-- filetype indent off
-- ]])
-- disable builtin plugins for faster startuptime
vim.g.loaded_gzip = false
-- vim.g.loaded_netrwPlugin = false
vim.g.loaded_tarPlugin = false
vim.g.loaded_zipPlugin = false
vim.g.loaded_2html_plugin = false
vim.g.loaded_remote_plugins = false
vim.g.loaded_tar = false
-- vim.opt.shadafile = "NONE"
-- vim.g.loaded_matchit = 1
-- vim.g.loaded_matchparen = 1

-- vim.g.do_filetype_lua = 0
-- vim.g.did_load_filetypes = 0
-- vim.g.did_load_ftdetect = 1

-- set this early because the other mappings are created with this
vim.g.mapleader = " "

vim.cmd([[au BufRead * lua require"utils".last_place()]])
require("impatient").enable_profile()
module_loader("ignis", "core")
-- require("packer_compiled")

vim.defer_fn(function()
    require("ignis.modules")

    vim.cmd("doautocmd ColorScheme")

    -- require("plugins")
    -- require("options")
    require("autocommands")
    -- require("utils")
    vim.cmd([[PackerLoad nvim-notify]])
    vim.opt.shadafile = ""
    vim.cmd("autocmd BufRead,BufNewFile *.norg setlocal filetype=norg")
    vim.cmd([[
        rshada!
        " doautocmd BufRead
        " filetype on
        " filetype plugin indent on
        ]])

    vim.defer_fn(function()
        vim.cmd([[
        PackerLoad impatient.nvim
        PackerLoad which-key.nvim
        PackerLoad nvim-lspconfig
        PackerLoad lightspeed.nvim
        " PackerLoad gitsigns.nvim
        silent! bufdo e
]])
    end, 5)
    require("after")
end, 1)
-- require("utils").set_colorscheme()
