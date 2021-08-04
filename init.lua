vim.g.mapleader = " "

require("config_files.options")
require("plugins")
vim.cmd("colorscheme gruvbox")
vim.cmd("source ~/.config/nvim/tablemode.vim")
vim.cmd("source ~/.config/nvim/mapping.vim")
require("mappings")
vim.cmd("source ~/.config/nvim/autocmds.vim")
vim.cmd("source ~/.config/nvim/highlights.vim")

vim.cmd([[
  source ~/.config/nvim/plugins/markdown.vim
  source ~/.config/nvim/plugins/simplefunctions.vim
]])
