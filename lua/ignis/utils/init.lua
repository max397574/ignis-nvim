local utils = {}

local log = require("ignis.external.log")
local fmt = string.format

--- Loads the specified modules
---@param folder string The folder which contains the module files (e.g. `ignis`)
---@param modules table|string The modules to load (e.g. `{ "utils", "ui" }`)
utils.load_module = function(folder, modules)
    local paths = {}
    if type(modules) == "string" then
        paths[1] = fmt("%s.%s", folder, modules)
    elseif type(modules) == "table" then
        for _, module in ipairs(modules) do
            table.insert(paths, fmt("%s.%s", folder, module))
        end
    else
        log.error("Invalid value for `modules`")
    end
    for _, path in ipairs(paths) do
        local ok, err = pcall(require, path)
        if not ok then
            log.error(fmt("Error loading module '%s'!", path))
        else
            log.debug("Loaded module '%s'", path)
        end
    end
end

utils.get_colorscheme = function()
    local theme
    local time = os.date("*t")
    if time.hour < 7 or time.hour >= 21 then
        theme = "tokyodark"
    elseif time.hour < 8 or time.hour >= 19 then
        theme = "kanagawa"
    elseif time.hour < 10 or time.hour >= 17 then
        theme = "onedark"
    else
        theme = "everforest"
        -- theme = "tokyodark"
    end
    return theme
end

utils.set_colorscheme = function(colorscheme)
    if colorscheme then
        vim.cmd("colorscheme " .. colorscheme)
    end
    local theme = utils.get_colorscheme()
    vim.g.colors_name = theme
    require("colors").init(theme)
    -- local old_scheme = require("custom.db").get_scheme()
    -- if theme ~= old_scheme then
    --     RELOAD("colorscheme_switcher")
    --     require("colorscheme_switcher").new_scheme()
    --     vim.defer_fn(function()
    --         require("colorscheme_switcher").new_scheme()
    --     end, 1000)
    -- end
end

function utils.system_separator()
    return package.config:sub(1, 1)
end

return utils
