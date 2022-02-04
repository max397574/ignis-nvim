vim.cmd([[
syntax off
filetype off
filetype plugin indent off
]])
-- disable builtin plugins for faster startuptime
vim.g.loaded_gzip = false
vim.g.loaded_netrwPlugin = false
vim.g.loaded_tarPlugin = false
vim.g.loaded_zipPlugin = false
vim.g.loaded_2html_plugin = false
vim.g.loaded_remote_plugins = false
vim.g.loaded_tar = false
vim.opt.shadafile = "NONE"
-- vim.g.loaded_matchit = 1 -- toggle comment for MIN STARTUP
-- vim.g.loaded_matchparen = 1 -- toggle comment for MIN STARTUP

vim.g.do_filetype_lua = 0
vim.g.did_load_filetypes = 0
vim.g.did_load_ftdetect = 1

-- set this early because the other mappings are created with this
vim.g.mapleader = " "

-- vim.defer_fn(function() -- toggle comment for MIN STARTUP
require("impatient").enable_profile()
require("plugins")
require("packer_compiled")
require("options")
require("autocommands")
require("utils")
vim.cmd([[PackerLoad nvim-notify]])
vim.cmd([[PackerLoad filetype.nvim]])
vim.opt.shadafile = ""
vim.cmd("autocmd BufRead,BufNewFile *.norg setlocal filetype=norg")
vim.cmd([[
    PackerLoad startup.nvim
    rshada!
    doautocmd BufRead
    syntax on
    filetype on
    filetype plugin indent on
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
-- end, 1) -- toggle comment for MIN STARTUP

require("utils").set_colorscheme()
