local sql = require("sqlite.db")

local db = sql:open(vim.fn.stdpath("data") .. "/databases/colorscheme.db") -- open in memory

local cs_tbl = db:tbl("colorscheme", { name = "text" })

local M = {}

function M.set_db()
    cs_tbl:drop() -- clear table
    cs_tbl:insert({ name = vim.g.colors_name })
end

function M.get_scheme()
    local tbl = cs_tbl:get()
    return tbl[1]["name"]
end

return M
