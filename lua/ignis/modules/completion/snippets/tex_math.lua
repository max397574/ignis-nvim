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

local in_mathzone = require("ignis.utils").in_mathzone

ls.add_snippets("tex", {
    s(
        "//",
        d(1, function()
            if not in_mathzone() then
                return sn(nil, { t({ "//" }) })
            else
                return sn(nil, {
                    t({ "\\frac{" }),
                    i(1),
                    t({ "}{" }),
                    i(2),
                    t({ "}" }),
                })
            end
        end)
    ),
    s(
        "->",
        f(function()
            if not in_mathzone() then
                return "->"
            end
            return "\\implies"
        end)
    ),
    s(
        { trig = "sr", wordTrig = false },
        f(function()
            if not in_mathzone() then
                return "sr"
            end
            return "^2"
        end)
    ),
    s(
        { trig = "cb", wordTrig = false },
        f(function()
            if not in_mathzone() then
                return "cb"
            end
            return "^3"
        end)
    ),
    s(
        { trig = "comp", wordTrig = false },
        f(function()
            if not in_mathzone() then
                return "comp"
            end
            return "^{c}"
        end)
    ),
    s(
        { trig = "ss", wordTrig = false },
        d(1, function()
            if not in_mathzone() then
                return sn(nil, { t({ "ss" }) })
            end
            return sn(nil, {
                t({ "^{" }),
                i(1),
                t({ "}" }),
                i(0),
            })
        end)
    ),
    s({ trig = "(%d+)/", regTrig = true }, {
        d(1, function(_, snip, _)
            return sn(
                nil,
                { t("\\frac{" .. snip.captures[1] .. "}{"), i(1), t("}") },
                i(0)
            )
        end),
    }, {
        condition = function(_, _, _)
            return in_mathzone()
        end,
    }),
    s({ trig = "(%u%u)vec", regTrig = true }, {
        d(1, function(_, snip, _)
            return sn(nil, { t("\\vec{" .. snip.captures[1] .. "}") }, i(0))
        end),
    }, {
        condition = function(_, _, _)
            return in_mathzone()
        end,
    }),
    s({ trig = "(%a)vec", regTrig = true }, {
        d(1, function(_, snip, _)
            return sn(nil, { t("\\vec{" .. snip.captures[1] .. "}") }, i(0))
        end),
    }, {
        condition = function(_, _, _)
            return in_mathzone()
        end,
    }),
    s({ trig = "(%a)hat", regTrig = true }, {
        d(1, function(_, snip, _)
            return sn(nil, { t("\\hat{" .. snip.captures[1] .. "}") }, i(0))
        end),
    }, {
        condition = function(_, _, _)
            return in_mathzone()
        end,
    }),
    s({ trig = "(%a)bar", regTrig = true }, {
        d(1, function(_, snip, _)
            return sn(nil, { t("\\bar{" .. snip.captures[1] .. "}") }, i(0))
        end),
    }, {
        condition = function(_, _, _)
            return in_mathzone()
        end,
    }),
    s({ trig = "vec" }, { t("\\vec{"), i(1), t("}"), i(0) }, {
        condition = function()
            return in_mathzone()
        end,
    }),
    s({ trig = "hat" }, { t("\\hat{"), i(1), t("}"), i(0) }, {
        condition = function()
            return in_mathzone()
        end,
    }),
    s({ trig = "bar" }, { t("\\bar{"), i(1), t("}"), i(0) }, {
        condition = function()
            return in_mathzone()
        end,
    }),
}, {
    type = "autosnippets",
})
