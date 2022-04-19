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

ls.add_snippets("tex", {
    s("circuit", {
        t({ [[\begin{circuitikz}]], "" }),
        i(1),
        t({ "", [[\end{circuitikz}]] }),
    }),

    s("gate", {
        t([=[\node[]=]),
        c(1, {
            t("not"),
            t("and"),
            t("nand"),
            t("xor"),
            t("nor"),
            t("or"),
        }),
        t([[ port]]),
        c(2, {
            t(""),
            sn(nil, {
                t(", number inputs="),
                i(1),
            }),
        }),
        t([=[] (]=]),
        i(3, "name"),
        t([[) at (]]),
        i(4, "position"),
        t({ ") {};" }),
        i(0),
    }),

    s("label", {
        t([=[\node[]=]),
        c(1, {
            t("left"),
            t("right"),
            t("above"),
            t("below"),
        }),
        t([=[]]=]),
        t([[ at (]]),
        i(2, "position"),
        t({ [=[) {\(]=] }),
        i(3, "label"),
        t({ [=[\)};]=] }),
        i(0),
    }),
})
