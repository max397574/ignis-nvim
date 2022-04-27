local sql = require("sqlite.db")
local tbl = require("sqlite.tbl")

local db = sql:open(vim.fn.stdpath("data") .. "/databases/colorscheme.db") -- open in memory

local ts_tbl = tbl("ts_tbl", {
    key = { "text", primary = true, required = true, default = "none" },
    layout = "text",
}, db)

local heirline_tbl = tbl("ts_tbl", {
    key = { "text", primary = true, required = true, default = "none" },
    theme = "text",
}, db)

local cs_tbl = tbl("cs_tbl", {
    key = { "text", primary = true, required = true, default = "none" },
    name = "text",
}, db)

local M = {}
-- ts_tbl.tele = {}
-- cs_tbl.scheme = {}
-- heirline_tbl.heirline = {}

function M.set_db()
    cs_tbl.scheme.name = vim.g.colors_name
end

-- BUG: Completely broken
function M.change_ts_layout(layout)
    ts_tbl.tele = {}
    ts_tbl.tele.layout = layout
    RELOAD("ignis.modules.files.telescope")
    -- require("colors").init()
    RELOAD("colors.highlights")
    require("colors.highlights")
end

function M.get_ts_layout()
    return "custom_bottom_no_borders"
    -- return "float_all_borders"
    -- return "float_prompt_border"
end

function M.get_scheme()
    return cs_tbl.scheme.name
end

function M.change_heirline_theme(theme)
    heirline_tbl.heirline.theme = theme
    RELOAD("ignis.modules.ui.heirline")
    require("ignis.modules.ui.heirline")
    -- require("colors").init()
    -- RELOAD("colors.highlights")
    require("colors.highlights")
end

function M.get_heirline_theme()
    return heirline_tbl.heirline.theme
end

return M
