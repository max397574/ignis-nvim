local config = {}

local utils = require("ignis.utils")

config.config = { nvim = {}, ignis = {
    colorscheme = "onedark",
} }

local ok, conf = pcall(
    dofile,
    vim.fn.stdpath("config") .. utils.system_separator() .. "ignis_config.lua"
)
if ok then
    -- config.config = conf
    config.config = vim.tbl_deep_extend("force", config.config, conf)
end

return config
