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

local has_treesitter, ts = pcall(require, "vim.treesitter")
local _, query = pcall(require, "vim.treesitter.query")

local MATH_ENVIRONMENTS = {
    displaymath = true,
    eqnarray = true,
    equation = true,
    math = true,
    array = true,
}
local MATH_NODES = {
    displayed_equation = true,
    inline_formula = true,
}

local function get_node_at_cursor()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local cursor_range = { cursor[1] - 1, cursor[2] }
    local buf = vim.api.nvim_get_current_buf()
    local ok, parser = pcall(ts.get_parser, buf, "latex")
    if not ok or not parser then
        return
    end
    local root_tree = parser:parse()[1]
    local root = root_tree and root_tree:root()

    if not root then
        return
    end

    return root:named_descendant_for_range(
        cursor_range[1],
        cursor_range[2],
        cursor_range[1],
        cursor_range[2]
    )
end

local function in_comment()
    if has_treesitter then
        local node = get_node_at_cursor()
        while node do
            if node:type() == "comment" then
                return true
            end
            node = node:parent()
        end
        return false
    end
end

local function in_mathzone()
    if has_treesitter then
        local buf = vim.api.nvim_get_current_buf()
        local node = get_node_at_cursor()
        while node do
            if MATH_NODES[node:type()] then
                return true
            end
            if node:type() == "environment" then
                local begin = node:child(0)
                local names = begin and begin:field("name")

                if
                    names
                    and names[1]
                    and MATH_ENVIRONMENTS[query.get_node_text(names[1], buf):gsub(
                        "[%s*]",
                        ""
                    )]
                then
                    return true
                end
            end
            node = node:parent()
        end
        return false
    end
end

ls.autosnippets = {
    tex = {
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
    },
}
