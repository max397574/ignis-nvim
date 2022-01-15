local colors = {}

local function highlight(group, guifg, guibg, attr, guisp)
    local parts = { group }
    if guifg then
        table.insert(parts, "guifg=#" .. guifg)
    end
    if guibg then
        table.insert(parts, "guibg=#" .. guibg)
    end
    if attr then
        table.insert(parts, "gui=" .. attr)
    end
    if guisp then
        table.insert(parts, "guisp=#" .. guisp)
    end

    -- nvim.ex.highlight(parts)
    vim.api.nvim_command("highlight " .. table.concat(parts, " "))
end

-- if theme given, load given theme if given, otherwise nvchad_theme
colors.init = function(theme)
    -- if not theme then
    --   theme = "onedark"
    -- end

    -- set the global theme, used at various places like theme switcher, highlights
    vim.g.nvchad_theme = theme
    vim.g.colors_name = theme

    local base16 = require("base16")
    local base16_custom = require("base16_custom")

    -- first load the base16 theme
    base16(base16.themes(theme), true)
    base16_custom(base16.themes(theme), true)

    -- unload to force reload
    package.loaded["colors.highlights" or false] = nil
    -- then load the highlights
    require("colors.highlights")
end

-- returns a table of colors for givem or current theme
colors.get = function(theme)
    if not theme then
        theme = vim.g.nvchad_theme
    end

    return require("hl_themes." .. theme)
end

return colors
