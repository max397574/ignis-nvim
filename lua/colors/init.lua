-- code from https://github.com/NvChad/NvChad
local colors = {}

-- if theme given, load given theme if given, otherwise nvchad_theme
colors.init = function(theme)
    -- set the global theme, used at various places like theme switcher, highlights
    if not theme then
        if vim.g.colors_name then
            theme = vim.g.colors_name
        end
    end
    vim.g.nvchad_theme = theme
    vim.g.colors_name = theme

    local base16 = require("base16")

    -- first load the base16 theme
    base16(base16.themes(theme), true)
    -- base16_custom(base16.themes(theme), true)

    -- unload to force reload
    package.loaded["colors.highlights" or false] = nil
    -- then load the highlights
    package.loaded["colors.highlights"] = nil
    package.loaded["colors.custom"] = nil
    require("colors.highlights")
    require("colors.custom")
    -- RELOAD("colors.highlights")
    -- RELOAD("colors.custom")
    -- vim.cmd([[PackerLoad bufferline.nvim]])
    -- vim.cmd([[PackerLoad indent-blankline.nvim]])
    -- vim.cmd([[PackerLoad staline.nvim]])
end

-- returns a table of colors for givem or current theme
colors.get = function(theme)
    if not theme then
        theme = vim.g.colors_name
    end
    local path = "lua/hl_themes/" .. theme .. ".lua"
    local files = vim.api.nvim_get_runtime_file(path, true)
    local color_table
    if #files == 0 then
        error("lua/hl_themes/" .. theme .. ".lua" .. " not found")
    elseif #files == 1 then
        color_table = dofile(files[1])
    else
        local nvim_base_pattern = "nvim-base16.lua/lua/hl_themes"
        local valid_file = false
        for _, file in ipairs(files) do
            if not file:find(nvim_base_pattern) then
                color_table = dofile(file)
                valid_file = true
            end
        end
        if not valid_file then
            -- multiple files but in startup repo shouldn't happen so just use first one
            color_table = dofile(files[1])
        end
    end
    return color_table
end

return colors
