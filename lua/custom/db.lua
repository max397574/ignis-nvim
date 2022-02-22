local sql = require("sqlite.db")

local db = sql:open(vim.fn.stdpath("data") .. "/databases/colorscheme.db") -- open in memory

local cs_tbl = db:tbl("colorscheme", { name = "text" })

local ts_tbl = db:tbl("confi", { layout = "bottom" })

local M = {}

function M.set_db()
    cs_tbl:drop() -- clear table
    cs_tbl:insert({ name = vim.g.colors_name })
end

function M.change_ts_layout(layout)
    ts_tbl:drop()
    ts_tbl:insert({ layout = layout })
    RELOAD("ignis.modules.files.telescope")
    -- require("colors").init()
    RELOAD("colors.highlights")
    require("colors.highlights")
end

function M.get_scheme()
    local tbl = cs_tbl:get()
    return tbl[1]["name"]
end

function M.get_ts_layout()
    local tbl = ts_tbl:get()
    return tbl[1]["layout"]
end

return M
