vim.cmd([[
        syntax off
        filetype off
        filetype plugin indent off
]])
-- require("colors").init(vim.g.forced_theme)
vim.opt.shadafile = "NONE"
vim.g.start_time = vim.fn.reltime()

-- vim.opt.loadplugins = false -- toggle comment for max speed

-- disable builtin plugins for faster startuptime
vim.g.loaded_python3_provider = 1
vim.g.loaded_python_provider = 1
vim.g.loaded_node_provider = 1
vim.g.loaded_ruby_provider = 1
vim.g.loaded_perl_provider = 1

vim.g.loaded_2html_plugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tutor = 1
vim.g.loaded_rplugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_syntax = 1
vim.g.loaded_synmenu = 1
vim.g.loaded_optwin = 1
vim.g.loaded_compiler = 1
vim.g.loaded_bugreport = 1
vim.g.loaded_ftplugin = 1
vim.g.did_load_ftplugin = 1
vim.g.did_indent_on = 1

-- use lua filetype detection
-- vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0
-- set this early because the other mappings are created with this
vim.g.mapleader = " "

-- set cursor to last position of a file
vim.api.nvim_create_autocmd({ "BufRead" }, {
    pattern = "*",
    callback = function()
        require("ignis.utils").last_place()
    end,
})
vim.api.nvim_create_autocmd({ "VimEnter" }, {
    pattern = "*",
    callback = function()
        require("ignis.modules.ui.dashboard").display()
    end,
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*",
    callback = function()
        require("filetype").resolve()
    end,
})
require("impatient").enable_profile()
vim.g.forced_theme = "everforest"
local module_loader = require("ignis.utils").load_module
module_loader("ignis", "core")

vim.defer_fn(function()
    require("ignis.modules")

    vim.cmd("doautocmd ColorScheme")
    vim.opt.shadafile = ""
    vim.cmd([[
        runtime! plugin/**/*.vim
        runtime! plugin/**/*.lua
    ]])
    vim.cmd([[
        rshada!
        doautocmd BufRead
        syntax on
        filetype on
        filetype plugin indent on
        PackerLoad nvim-treesitter
        ]])

    vim.defer_fn(function()
        vim.cmd([[
            PackerLoad which-key.nvim
            PackerLoad nvim-lspconfig
            PackerLoad lightspeed.nvim
            silent! bufdo e
            ]])
    end, 5)
    require("ignis.after")
end, 1)
