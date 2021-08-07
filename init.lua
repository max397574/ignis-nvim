vim.g.mapleader = " "

require("config_files.options")
require("plugins")
vim.cmd("colorscheme gruvbox")
require("mappings")
require("autocommands")
vim.cmd("source ~/.config/nvim/random.vim")
vim.cmd("source ~/.config/nvim/highlights.vim")

vim.cmd([[
  source ~/.config/nvim/plugins/markdown.vim
  source ~/.config/nvim/plugins/simplefunctions.vim
]])
