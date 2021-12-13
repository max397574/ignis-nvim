vim.cmd([[
syntax off
filetype off
filetype plugin indent off
]])
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

vim.g.did_load_filetypes = 1

-- set this early because the other mappings are created with this
vim.g.mapleader = " "

-- vim.defer_fn(function() -- toggle comment for MIN STARTUP
require("impatient").enable_profile()
require("impatient")
require("plugins")
require("options")
require("packer_compiled")
require("autocommands")
require("utils")
vim.opt.shadafile = ""
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
  silent! bufdo e
  ]])
  require("after")
end, 0)
-- end, 0) -- toggle comment for MIN STARTUP

vim.cmd([[colorscheme onedark]])
