vim.g.start_time = vim.fn.reltime()

local module_loader = require("ignis.utils").load_module

-- disable builtin plugins for faster startuptime
vim.g.loaded_gzip = false
vim.g.loaded_tarPlugin = false
vim.g.loaded_zipPlugin = false
vim.g.loaded_2html_plugin = false
vim.g.loaded_remote_plugins = false
vim.g.loaded_tar = false

-- use lua filetype detection
vim.g.do_filetype_lua = 1
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
vim.g.forced_theme = "everforest"
require("impatient").enable_profile()
module_loader("ignis", "core")

vim.defer_fn(function()
    require("ignis.modules")

    vim.cmd("doautocmd ColorScheme")

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
