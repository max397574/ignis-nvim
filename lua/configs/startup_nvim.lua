-- local settings = {
--   header = {
--     type = "text",
--     content = require("startup.buildingblocks.headers").neovim_logo(),
--     align = "center",
--   },
--   body = {
--     type = "oldfiles",
--     -- content = require("startup.buildingblocks.functions").oldfiles(10),
--     -- content = { "" },
--     -- command = [[
--     -- nnoremap <silent>I :e ~/.config/nvim_config/init.lua<CR>
--     -- nnoremap <silent>p :e ~/.config/nvim_config/lua/plugins.lua<CR>
--     -- ]],
--   },
--   footer = {
--     type = "text",
--     content = require("startup.buildingblocks.functions").packer_plugins(),
--     align = "center",
--   },
--   options = {
--     empty_lines_between_mappings = true,
--     mapping_keys = true,
--     padding = {
--       header_body = 2,
--       body_footer = 0,
--     },
--   },
-- }
-- local settings = require "startup.themes.startify"
-- local settings = require "startup.themes.default"
local settings = require("startup.themes.evil")
-- settings.footer = {
--   type = "text",
--   content = function()
--     local clock = " " .. os.date "%H:%M"
--     local date = " " .. os.date "%d-%m-%y"
--     return { clock, date }
--   end,
-- }
-- settings.header.highlight = "Boolean"
-- settings.header.content = {
--   " ⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
--   "⠀⠀⠀⠀ ⢫⠉⠒⠲⠤⣀⡄ ⠀⠀ ⠀ ⠀ ⠀⠀ ⠀ ⠀ ⠀ ⠀ ⠀ ⠀",
--   "⠀⠀⠀ ⠀⠀⢇⠀⠀⡀⠀⠈⠙⠒⠤⣄⡀⠀ ⠀ ⠀⠀⠀⠀ ⠀ ⠀⠀⠀ ⠀⠀",
--   "⠀⠀  ⠀ ⠈⣆⠀⢀⠠⠐⠀⢀⠀⠀⠈⠑⠢⢄⡀  ⠀ ⠀ ⠀  ⠀ ⠀⠀",
--   "⠀⠀ ⠀⠀⠀⠀⠘⡄⠀⠀⠀⢀⠀⠀⠄⠁⠀⡀⠀⠈⠓⠤⡀⠀⠀⠀⠀⠀ ⠀⠀ ⠀",
--   "⠀⠀⠀ ⠀  ⠀⠸⡀⠀⠁⠀⠀⣄⣀⠴⠤⠖⡒⢓⢒⢒⠪⠵⢤⡁⠀ ⠀  ⠀⠀",
--   "⠀⠀ ⠀ ⠀⠀⠀⠀⠣⠴⡗⡋⠍⣂⣂⣅⠅⠅⡂⠅⡂⡂⡬⢐⢁⠊⢦⠀ ⠀⠀⠀⠀",
--   "⠀⠀  ⠀⠀  ⠀⠀⠀⢰⢨⣭⣂⣂⣢⢈⢂⠂⢅⢂⠦⡃⡂⡂⢅⠩⣇⠀⠀⠀ ⠀",
--   "⠀⠀⠀⠀⠀  ⠀ ⠐⢨⠊⠜⢽⠬⠵⠯⡃⡂⡑⡐⠌⡂⡂⠢⠨⢐⢐⢸⠀⠀ ⠀⠀",
--   "⠀⠀  ⠀⠀⠀⠀⠀⡔⠅⢅⢑⢐⠨⢐⠡⢐⢐⠐⠄⢅⠦⡚⢬⠨⢐⢐⢸⠀⠀  ⠀",
--   "⠀⠀  ⠀ ⠀⣡⠎⡂⢅⡂⡂⠢⡈⠢⠨⠐⠄⢅⡑⠌⣢⢹⢸⠨⠐⢄⡏⠀⠀ ⠀⠀",
--   "⠀⠀⠀⠀⠀ ⠐⢇⣂⣂⡥⡚⢄⢑⠨⠨⠨⠨⠨⡀⡓⡅⠌⠭⠾⢈⠌⢜⡆⠀⠀   ",
--   "⠀⠀  ⠀⠀ ⠀⠀⡠⡚⠔⣐⢐⠨⠨⠨⡈⡂⡂⡂⣺⢈⢂⡕⡐⠨⢐⡇⠀ ⠀⠀⠀",
--   "⠀⠀⠀⠀⠀ ⠀⠀⠈⣷⢒⢓⢚⢂⠊⢌⢐⢐⢐⠰⡒⡑⡐⠄⡗⢄⠑⠄⣇⠀⠀  ⠀",
--   "⠀⠀ ⠀ ⠀⠀ ⠀⢈⡯⠩⠐⢄⢑⢐⢐⠐⠌⡂⡂⡂⣂⡥⢃⠂⠅⠅⢼⠀⠀⠀⠀⠀",
--   "⠀⠀  ⠀⠀ ⢀⠞⠡⠨⠨⠨⢐⢐⠐⢄⣅⠥⠖⡒⠩⡁⣂⠅⠌⠌⠌⢼⠀⠀  ⠀",
--   "⠀⠀⠀⠀⠀ ⠀⠈⠺⢬⣨⣨⣨⡰⠖⠉⠁⠸⡨⢐⢈⢂⠢⡜⠨⠨⠨⠨⢸⠀⠀⠀ ⠀",
--   "⠀⠀⠀   ⠀ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢐⢐⠴⡊⠌⠌⠈⡈⠈⠈⠁⠀  ⠀",
--   "⠀⠀ ⠀⠀⠀ ⠀ ⠀  ⠀ ⠀ ⠀  ⠀  ⠀⠀ ⠀   ⠀ ⠀⠀⠀",
-- }
-- settings.parts = { "body", "header" }
settings.header.content = {
  "⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
  "⠀⠀⠀⠀⠀⢫⠉⠒⠲⠤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⢇⠀⠀⠀⠀⠈⠙⠒⠤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠈⣆⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠢⢄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠘⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠓⠤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠸⡀⠀⠀⠀⠀⣀⣀⠤⠤⠖⠒⠒⠒⠒⠊⠵⢤⡀⠀⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠣⠴⡖⠋⠉⣀⣀⣀⠀⠀⠀⠀⠀⠀⡠⠀⠀⠈⢦⠀⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⢈⣭⣀⣀⣀⠀⠀⠀⠀⢀⠤⠃⠀⠀⠀⠈⣇⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠊⠘⢽⠬⠥⠯⠃⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⡔⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠤⠒⢤⠀⠀⠀⢸⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⣀⠎⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠈⢂⢹⢸⠀⠀⠀⡏⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⢇⣀⣀⡠⡘⠀⠀⠀⠀⠀⠀⠀⠀⠑⡄⠈⠩⠼⠀⠀⠜⡆⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠞⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠀⠀⡄⠀⠀⠀⡇⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠈⢷⠒⠒⠚⠂⠀⠀⠀⠀⠀⠠⠒⠁⠀⠀⡇⠀⠀⠀⢇⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢈⡯⠉⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⢀⡠⠃⠀⠀⠀⢸⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⢀⠞⠁⠀⠀⠀⠀⠀⠀⢀⣀⠤⠔⠒⠉⠁⢀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠈⠲⢤⣀⣀⣀⡠⠖⠉⠁⠸⡀⠀⠀⠀⠀⡜⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⢀⠤⠊⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀",
  "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ",
}

-- settings.header.content = require("startup.utils").get_oldfiles(10)

return settings
