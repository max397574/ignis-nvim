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

vim.cmd [[colorscheme galaxy]]

-- -- TODO: fix error that forces me to do this
vim.api.nvim_feedkeys(
  vim.api.nvim_replace_termcodes("<CR>", true, true, true),
  "n",
  false
)
