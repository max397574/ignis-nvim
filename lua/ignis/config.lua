local config = {}
local log = require("ignis.external.log")

local system = require("ignis.utils.system")

-- default config
config.config = {
    nvim = {},
    ignis = {
        colorscheme = "onedark",
        modules = {
            ui = {
                heirline = true,
                bufferline = true,
            },
            misc = {
                neorg = true,
            },
        },
    },
    custom_plugins = {},
}

local ok, conf = xpcall(
    dofile,
    debug.traceback,
    system.ignis_config_dir .. "/ignis_config.lua"
)
if ok and conf then
    config.config = vim.tbl_deep_extend("force", config.config, conf)
else
    ok, conf = xpcall(
        dofile,
        debug.traceback,
        vim.fn.stdpath("config") .. system.separator .. "ignis_config.lua"
    )
    if ok and conf then
        config.config = vim.tbl_deep_extend("force", config.config, conf)
    else
        ok, conf = xpcall(require, debug.traceback, "ignis_config")
        if ok and conf then
            config.config = vim.tbl_deep_extend("force", config.config, conf)
        else
            log.error("Couldn't load custom config")
        end
    end
end

return config
