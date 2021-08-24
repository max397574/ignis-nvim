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
require("bufferline").setup({
  options = {
    custom_areas = {
      right = function()
        local result = {}
        local error = vim.lsp.diagnostic.get_count(0, [[Error]])
        local warning = vim.lsp.diagnostic.get_count(0, [[Warning]])
        local info = vim.lsp.diagnostic.get_count(0, [[Information]])
        local hint = vim.lsp.diagnostic.get_count(0, [[Hint]])

        if error ~= 0 then
          table.insert(result, { text = "  " .. error, guifg = "#EC5241" })
        end

        if warning ~= 0 then
          table.insert(result, { text = "  " .. warning, guifg = "#EFB839" })
        end

        if hint ~= 0 then
          table.insert(result, { text = "  " .. hint, guifg = "#A3BA5E" })
        end

        if info ~= 0 then
          table.insert(result, { text = "  " .. info, guifg = "#7EA9A7" })
        end
        return result
      end,
    },
  },
})

local time = os.date("*t")
if time.hour >= 8 and time.hour < 20 then
  vim.cmd([[
    highlight Normal guibg=#E6DAC8 guifg=#5E5C5B
  ]])
end
