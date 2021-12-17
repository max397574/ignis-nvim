local events = {}
local parse_json = function(json_data)
  for _, event in ipairs(json_data) do
    local action
    local icon
    local user = event["actor"]["display_login"]
    -- print("event:")
    -- dump(event)

    if event["payload"]["forkee"] then
    elseif event["payload"]["action"] == "started" then
      action = "starred"
      icon = " "
      local repo = event["repo"]["name"]
      -- table.insert(events, ("%s %s %s %s"):format(icon, user, action, repo))
      table.insert(events, ("%s %s"):format(icon, repo))
      -- table.insert(M.events, ("%s"):format(repo))
    else
    end
  end
end
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

-- local settings = require "startup.themes.dashboard"
-- local settings = require("startup.themes.evil")
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
-- settings.header.content = {
--   "⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
--   "⠀⠀⠀⠀⠀⢫⠉⠒⠲⠤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
--   "⠀⠀⠀⠀⠀⠀⢇⠀⠀⠀⠀⠈⠙⠒⠤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
--   "⠀⠀⠀⠀⠀⠀⠈⣆⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠢⢄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
--   "⠀⠀⠀⠀⠀⠀⠀⠘⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠓⠤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
--   "⠀⠀⠀⠀⠀⠀⠀⠀⠸⡀⠀⠀⠀⠀⣀⣀⠤⠤⠖⠒⠒⠒⠒⠊⠵⢤⡀⠀⠀⠀⠀⠀⠀⠀",
--   "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠣⠴⡖⠋⠉⣀⣀⣀⠀⠀⠀⠀⠀⠀⡠⠀⠀⠈⢦⠀⠀⠀⠀⠀⠀",
--   "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⢈⣭⣀⣀⣀⠀⠀⠀⠀⢀⠤⠃⠀⠀⠀⠈⣇⠀⠀⠀⠀⠀",
--   "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠊⠘⢽⠬⠥⠯⠃⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀",
--   "⠀⠀⠀⠀⠀⠀⠀⠀⠀⡔⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠤⠒⢤⠀⠀⠀⢸⠀⠀⠀⠀⠀",
--   "⠀⠀⠀⠀⠀⠀⠀⣀⠎⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠈⢂⢹⢸⠀⠀⠀⡏⠀⠀⠀⠀⠀",
--   "⠀⠀⠀⠀⠀⠀⠀⢇⣀⣀⡠⡘⠀⠀⠀⠀⠀⠀⠀⠀⠑⡄⠈⠩⠼⠀⠀⠜⡆⠀⠀⠀⠀⠀",
--   "⠀⠀⠀⠀⠀⠀⠀⠀⠀⡠⠞⠀⢀⠀⠀⠀⠀⠀⠀⠀⠀⣸⠀⠀⡄⠀⠀⠀⡇⠀⠀⠀⠀⠀",
--   "⠀⠀⠀⠀⠀⠀⠀⠀⠈⢷⠒⠒⠚⠂⠀⠀⠀⠀⠀⠠⠒⠁⠀⠀⡇⠀⠀⠀⢇⠀⠀⠀⠀⠀",
--   "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢈⡯⠉⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⢀⡠⠃⠀⠀⠀⢸⠀⠀⠀⠀⠀",
--   "⠀⠀⠀⠀⠀⠀⠀⢀⠞⠁⠀⠀⠀⠀⠀⠀⢀⣀⠤⠔⠒⠉⠁⢀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀",
--   "⠀⠀⠀⠀⠀⠀⠀⠈⠲⢤⣀⣀⣀⡠⠖⠉⠁⠸⡀⠀⠀⠀⠀⡜⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀",
--   "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⢀⠤⠊⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀",
--   "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ",
-- }

-- settings.header.content = {
--   "                              ",
--   "       ⢀⣠⣴⣶⣿⣿⣿⣿⣿⣿⣶⣦⣄⡀         ",
--   "     ⣠⣶⡿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣷⣄       ",
--   "   ⢀⣼⣿⣿   ⠙⠛⠛⠛⠛⠛⠛⠋⠁  ⢻⣿⣷⡀     ",
--   "  ⢀⣾⣿⣿⣿              ⢿⣿⣿⣿⡄    ",
--   "  ⣼⣿⣿⣿⠁              ⠈⢿⣿⣿⣷    ",
--   "  ⣿⣿⣿⡇                ⢸⣿⣿⣿    ",
--   "  ⣿⣿⣿⣧                ⣸⣿⣿⣿    ",
--   "  ⢻⣿⣿⣿⣧⡀            ⢀⣴⣿⣿⣿⡿    ",
--   "  ⠈⢿⣿⣛⠛⢿⣶⣤⣄⡀    ⢀⣠⣤⣶⣿⣿⣿⣿⣿⠃    ",
--   "   ⠈⢿⣿⣦⠈⠛⠻⠟⠃     ⣿⣿⣿⣿⣿⣿⡿⠁     ",
--   "     ⠙⢿⣷⣦⣤⣤⡄     ⣿⣿⣿⣿⡿⠋       ",
--   "       ⠈⠙⠻⠿⠁     ⠿⠿⠛⠁         ",
-- }

-- settings.options.after = function() print("noice") end

-- settings.header.content = require("startup.utils").get_oldfiles(10)

-- settings.body.content = require"github_nots".setup()

vim.g.startup_bookmarks = {
  ["Q"] = "~/.config/qtile/config.py",
  ["I"] = "~/.config/nvim/init.lua",
  ["F"] = "~/.config/fish/config.fish",
  ["K"] = "~/.config/kitty/kitty.conf",
  ["A"] = "~/.config/alacritty/alacritty.yml",
}

-- settings.body_2.type = "text"
-- settings.body_2.content = function()
--   local result
--   local username = "budswa"
--   local url = ("https://api.github.com/users/%s/events"):format(username)
--
--   require"plenary.job":new({ command = "curl", args = { url },on_exit = function(j, _)
--     result = j:result()
--   end, }):sync()
--     local json_data = vim.json.decode(table.concat(result, ""))
--   -- local json_data = vim.json.decode(sauce, "")
--   parse_json(json_data)
--
--   local nvim_plugins = {}
--
--   for i = 1, 10, 1 do
--     nvim_plugins[#nvim_plugins+1] = events[i]
--   end
--
--   table.insert(nvim_plugins,1,"")
--   table.insert(nvim_plugins,1,"Newest Neovim Plugins:")
--
--   return nvim_plugins
-- end

-- settings.parts = {
--   "header",
--   "header_2",
--   "body",
--   "footer",
--   "body_2",
--   "clock",
--   "footer_2",
-- }

local settings = require("startup.themes.evil")
-- local settings = require("startup.themes.dashboard")

return settings
