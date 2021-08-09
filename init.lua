vim.g.mapleader = " "

require("options")
-- plugins (packer) and settings
require("plugins")
vim.cmd("colorscheme gruvbox")
-- all the mappings
require("mappings")
-- the autocommands
require("autocommands")
-- some stuff which hasn't been converted to lua yet
vim.cmd("source ~/.config/nvim/random.vim")
-- all highlights
vim.cmd("source ~/.config/nvim/highlights.vim")
-- file for testing some configurations
vim.cmd("source ~/.config/nvim/temporary.vim")

vim.cmd([[
  source ~/.config/nvim/plugins/markdown.vim
  source ~/.config/nvim/plugins/simplefunctions.vim
]])
