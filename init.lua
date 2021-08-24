--[[
                    $$$$$$\   $$$$$$\  $$$$$$$$\ $$$$$$$\  $$$$$$$$\ $$\   $$\
                   $$ ___$$\ $$  __$$\ \____$$  |$$  ____| \____$$  |$$ |  $$ |
   $$$$$$\$$$$\    \_/   $$ |$$ /  $$ |    $$  / $$ |          $$  / $$ |  $$ |
   $$  _$$  _$$\     $$$$$ / \$$$$$$$ |   $$  /  $$$$$$$\     $$  /  $$$$$$$$ |
   $$ / $$ / $$ |    \___$$\  \____$$ |  $$  /   \_____$$\   $$  /   \_____$$ |
   $$ | $$ | $$ |  $$\   $$ |$$\   $$ | $$  /    $$\   $$ | $$  /          $$ |
   $$ | $$ | $$ |  \$$$$$$  |\$$$$$$  |$$  /     \$$$$$$  |$$  /           $$ |
   \__| \__| \__|   \______/  \______/ \__/       \______/ \__/            \__|
]]
--

-- set this early because the other mappings are created with this
vim.g.mapleader = " "

-- possible options galaxy, moonlight, gruvbox8, onedark, tokyonight, tokyodark
local color_choice = "galaxy"

require("options")
require("plugins")
require("mappings")
require("autocommands")
-- some stuff which hasn't been converted to lua yet
vim.cmd("source ~/.config/nvim/random.vim")

-- require "colors/themes".random()
vim.cmd("colorscheme " .. color_choice)
require("colors.fixed_highlights")
vim.cmd("highlight Normal guibg = none")

local time = os.date("*t")
if time.hour >= 8 and time.hour < 20 then
  vim.cmd([[
    highlight Normal guibg=#E6DAC8 guifg=#5E5C5B
  ]])
end
