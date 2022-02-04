local cmd = vim.cmd

local colors = require("colors").get()

local black = colors.black
local black2 = colors.black2
local blue = colors.blue
local darker_black = colors.darker_black
local folder_bg = colors.folder_bg
local green = colors.green
local grey = colors.grey
local grey_fg = colors.grey_fg
local line = colors.line
local nord_blue = colors.nord_blue
local one_bg = colors.one_bg
local one_bg2 = colors.one_bg2
local pmenu_bg = colors.pmenu_bg
local purple = colors.purple
local red = colors.red
local white = colors.white
local yellow = colors.yellow
local orange = colors.orange

local theme = vim.g.colors_name

local path = "lua/custom_highlights/" .. theme .. ".lua"
local files = vim.api.nvim_get_runtime_file(path, true)
local highlights
if #files == 0 then
    highlights = {}
elseif #files == 1 then
    highlights = dofile(files[1])
else
    local nvim_base_pattern = "nvim-base16.lua/lua/custom_highlights"
    local valid_file = false
    for _, file in ipairs(files) do
        if not file:find(nvim_base_pattern) then
            highlights = dofile(file)
            valid_file = true
        end
    end
    if not valid_file then
        -- multiple files but in startup repo shouldn't happen so just use first one
        highlights = dofile(files[1])
    end
end

-- local highlights = require("custom_highlights." .. vim.g.colors_name)

for hl, attr in pairs(highlights) do
    vim.api.nvim_set_hl(0, hl, attr)
end
