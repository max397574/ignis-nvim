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

-- possible options color_galaxy, moonlight, gruvbox8, onedark, tokyonight tokyodark
local color_choice = "color_galaxy"

-- all the vim settings
require("options")
-- plugins (packer) and settings
require("plugins")
-- all the mappings
require("mappings")
-- the autocommands
require("autocommands")
-- some stuff which hasn't been converted to lua yet
vim.cmd("source ~/.config/nvim/random.vim")
-- all highlights

if color_choice == "color_galaxy" then
  require "colors.color_galaxy".shine()
  require "colors.vimcolors"
else
  vim.cmd("colorscheme " .. color_choice)
  require("colors.fixed_highlights")
end

vim.cmd("command -nargs=1 H vertical help")
