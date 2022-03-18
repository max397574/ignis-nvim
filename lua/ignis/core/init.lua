-- Loads all the core settings
local log = require("ignis.external.log")
log.debug("Loading core...")

require("ignis.utils.globals")

local loader = require("ignis.utils").load_module

loader(
    "ignis.core",
    { "ui", "settings", "settings.netrw", "autocommands", "commands" }
)

-- vim.defer_fn(function()
-- require("ignis.core.settings")
-- require("plugins")
-- require("packer_compiled")
-- vim.cmd([[
--         PackerLoad filetype.nvim
--     ]])
-- require("ignis.core.ui")
-- -- end, 1)
-- require("after")
