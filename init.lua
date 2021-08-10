--[[
                    $$$$$$\   $$$$$$\  $$$$$$$$\ $$$$$$$\  $$$$$$$$\ $$\   $$\
                   $$ ___$$\ $$  __$$\ \____$$  |$$  ____| \____$$  |$$ |  $$ |
   $$$$$$\$$$$\    \_/   $$ |$$ /  $$ |    $$  / $$ |          $$  / $$ |  $$ |
   $$  _$$  _$$\     $$$$$ / \$$$$$$$ |   $$  /  $$$$$$$\     $$  /  $$$$$$$$ |
   $$ / $$ / $$ |    \___$$\  \____$$ |  $$  /   \_____$$\   $$  /   \_____$$ |
   $$ | $$ | $$ |  $$\   $$ |$$\   $$ | $$  /    $$\   $$ | $$  /          $$ |
   $$ | $$ | $$ |  \$$$$$$  |\$$$$$$  |$$  /     \$$$$$$  |$$  /           $$ |
   \__| \__| \__|   \______/  \______/ \__/       \______/ \__/            \__|
]] --


-- set this early because the other mappings are created with this
vim.g.mapleader = " "

-- all the vim settings
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
