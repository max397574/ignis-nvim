local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local types = require("luasnip.util.types")
local util = require("luasnip.util.util")
local fmt = require("luasnip.extras.fmt").fmt

local parse = ls.parser.parse_snippet
local time = [[

local start = os.clock()
print(os.clock()-start.."s")
]]

local high = [[
${1:HighlightGroup} = { fg = "${2}", bg = "${3}" },${0}]]

local module_snippet = [[
local ${1:M} = {}
${0}
return $1]]

local loc_func = [[
local function ${1:name}(${2})
    ${0}
end
]]

local inspect_snippet = [[
print("${1:variable}:")
dump($1)]]

local map_cmd = [[<cmd>${0}<CR>]]

local it
it = function()
    return sn(nil, {
        c(1, {
            t({ "" }),
            sn(nil, {
                t({ "", "" }),
                t('\tit("'),
                i(1),
                t('",function()'),
                t({ "", "" }),
                t("\t\t"),
                c(2, {
                    t("assert.equals"),
                    t("assert.same"),
                    t("assert.is_true"),
                    t("assert.is_nil"),
                    t("assert.is_table"),
                }),
                t("("),
                i(3),
                t(")"),
                t({ "", "" }),
                t("\tend)"),
                t({ "", "" }),
                d(4, it, {}),
            }),
        }),
    })
end

local describe = function()
    return sn(nil, {
        t('describe("'),
        i(1),
        t('",function()'),
        d(2, it, {}),
        t({ "", "" }),
        t("end)"),
    })
end

ls.add_snippets("lua", {
    parse({ trig = "high" }, high),
    parse({ trig = "time" }, time),
    parse({ trig = "M" }, module_snippet),
    parse({ trig = "lf" }, loc_func),
    parse({ trig = "cmd" }, map_cmd),
    parse({ trig = "inspect" }, inspect_snippet),
    s("test_desc", {
        c(1, {
            d(1, describe, {}),
            sn(nil, {
                t({ "---@diagnostic disable: undefined-global", "" }),
                d(1, describe, {}),
            }),
        }),
    }),
})
