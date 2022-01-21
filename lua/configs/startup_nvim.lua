local settings = require("startup.themes.evil")
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

settings.options.paddings = { 2, 1, 1, 1, 1, 1, 1 }

-- settings = require("startup.themes.dashboard")
--
-- settings.header.content = require"startup.headers".neovim_banner_header

-- settings.body = {
--     type = "oldfiles",
--     oldfiles_directory = false,
--     align = "center",
--     fold_section = false,
--     title = "Oldfiles",
--     margin = 5,
--     content = "",
--     highlight = "String",
--     default_color = "",
--     oldfiles_amount = 5,
-- }

-- settings = {
--     -- every line should be same width without escaped \
--     header = {
--         type = "text",
--         align = "center",
--         fold_section = false,
--         title = "Header",
--         margin = 5,
--         content = require("startup.headers").hydra_header,
--         highlight = "Statement",
--         default_color = "",
--         oldfiles_amount = 0,
--     },
--     header_2 = {
--         type = "text",
--         oldfiles_directory = false,
--         align = "center",
--         fold_section = false,
--         title = "Quote",
--         margin = 5,
--         content = require("startup.functions").quote(),
--         highlight = "Constant",
--         default_color = "",
--         oldfiles_amount = 0,
--     },
--
--     body = {
--         type = "oldfiles",
--         oldfiles_directory = false,
--         align = "center",
--         fold_section = false,
--         title = "Oldfiles",
--         margin = 5,
--         content = "",
--         highlight = "String",
--         default_color = "",
--         oldfiles_amount = 5,
--     },
--
--     clock = {
--         type = "text",
--         content = function()
--             local clock = " " .. os.date("%H:%M")
--             local date = " " .. os.date("%d-%m-%y")
--             return { clock, date }
--         end,
--         oldfiles_directory = false,
--         align = "center",
--         fold_section = false,
--         title = "",
--         margin = 5,
--         highlight = "TSString",
--         default_color = "#FFFFFF",
--         oldfiles_amount = 10,
--     },
--
--     footer_2 = {
--         type = "text",
--         content = require("startup.functions").packer_plugins(),
--         oldfiles_directory = false,
--         align = "center",
--         fold_section = false,
--         title = "",
--         margin = 5,
--         highlight = "TSString",
--         default_color = "#FFFFFF",
--         oldfiles_amount = 10,
--     },
--
--     options = {
--         after = function()
--             require("startup.utils").oldfiles_mappings()
--         end,
--         mapping_keys = true,
--         cursor_column = 0.5,
--         empty_lines_between_mappings = true,
--         disable_statuslines = true,
--         paddings = { 2, 2, 2, 2, 2, 2, 2 },
--     },
--     colors = {
--         background = "#1f2227",
--         folded_section = "#56b6c2",
--     },
--
--     mappings = {
--         open_file = "<CR>",
--     },
--
--     parts = {
--         "header",
--         "header_2",
--         "body",
--         "clock",
--         "footer_2",
--     },
-- }

-- require'startup'.setup(settings)

settings = require("startup.themes.evil")
return settings
