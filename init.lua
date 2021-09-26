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

require "options"
require "plugins"
require "mappings"
require "autocommands"
require "utils"
-- some stuff which hasn't been converted to lua yet
vim.cmd "source ~/.config/nvim/random.vim"

vim.cmd[[colorscheme galaxy]]

if vim.g.galaxy_dynamic then
  local time = os.date "*t"
  if time.hour >= 8 and time.hour < 18 then
    vim.cmd [[
    colorscheme galaxy_light
    ]]
  else
    vim.cmd [[
    colorscheme galaxy
  highlight Normal guibg = none]]
    require "colors.fixed_highlights"
  end
end
