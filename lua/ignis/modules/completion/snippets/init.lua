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

require("luasnip/loaders/from_vscode").load()
require("configs.luasnip")

local parse = ls.parser.parse_snippet

local gitcommmit_stylua = [[chore: autoformat with stylua]]

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

local public_string = [[
public String ${1:function_name}(${2:parameters}) {
  ${0}
}]]

local public_void = [[
public void ${1:function_name}(${2:parameters}) {
  ${0}
}]]

local gitcommit_fix = [[
fix(${1:scope}): ${2:title}

${0}]]

local gitcommit_cleanup = [[
cleanup(${1:scope}): ${2:title}

${0}]]
local gitcommit_revert = [[
revert: ${2:header of reverted commit}

This reverts commit ${0:<hash>}]]

local gitcommit_feat = [[
feat(${1:scope}): ${2:title}

${0}]]
local gitcommit_docs = [[
docs(${1:scope}): ${2:title}

${0}]]

local gitcommit_refactor = [[
refactor(${1:scope}): ${2:title}

${0}]]

local tex_arrow = [[\$\implies\$]]

local tex_paragraph = [[
\paragraph{$1}]]

local tex_template = [[
\documentclass[a4paper,12pt]{article}
\usepackage[a4paper, margin=1in, total={20cm,27cm}]{geometry}
\usepackage{import}
\usepackage{pdfpages}
\usepackage{transparent}
\usepackage{xcolor}

\usepackage{textcomp}
\usepackage[german]{babel}
\usepackage{amsmath, amssymb}
\usepackage{graphicx}
\usepackage{tikz}
\usepackage{wrapfig}

\title{$1}
\author{$2}

\begin{document}
\maketitle
\tableofcontents

$0
\addcontentsline{toc}{section}{Unnumbered Section}
\end{document}]]

local tex_section = [[
\section{$1}]]

local tex_subsection = [[
\subsection{$1}]]

local tex_subsubsection = [[
\subsubsection{$1}]]

local tex_table = [[
\begin{center}
  \begin{tabular}{ c c c }
    cell1 & cell2 & cell3 \\\\
    \\hline
    cell4 & cell5 & cell6 \\\\
    \\hline
    cell7 & cell8 & cell9
  \end{tabular}
\end{center}]]

local tex_enumerate = [[
\begin{enumerate}
  \item $0
\end{enumerate}]]

local tex_description = [[
\begin{description}
  \item $0
\end{description}]]

local tex_item = [[
\item ]]

local tex_bold = [[
\textbf{$1}]]

local tex_itemize = [[
\begin{itemize}
	\item $0
\end{itemize}]]

local tex_begin = [[
\\begin{$1}
	$0
\\end{$1}]]

local rec_ls
rec_ls = function()
    return sn(nil, {
        c(1, {
            -- important!! Having the sn(...) as the first choice will cause infinite recursion.
            t({ "" }),
            -- The same dynamicNode as in the snippet (also note: self reference).
            sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
        }),
    })
end
local function jdocsnip(args, _, old_state)
    -- !!! old_state is used to preserve user-input here. DON'T DO IT THAT WAY!
    -- Using a restoreNode instead is much easier.
    -- View this only as an example on how old_state functions.
    local nodes = {
        t({ "/**", " * " }),
        i(1, "A short Description"),
        t({ "", "" }),
    }

    -- These will be merged with the snippet; that way, should the snippet be updated,
    -- some user input eg. text can be referred to in the new snippet.
    local param_nodes = {}

    if old_state then
        nodes[2] = i(1, old_state.descr:get_text())
    end
    param_nodes.descr = nodes[2]

    -- At least one param.
    if string.find(args[2][1], ", ") then
        vim.list_extend(nodes, { t({ " * ", "" }) })
    end

    local insert = 2
    for indx, arg in ipairs(vim.split(args[2][1], ", ", true)) do
        -- Get actual name parameter.
        arg = vim.split(arg, " ", true)[2]
        if arg then
            local inode
            -- if there was some text in this parameter, use it as static_text for this new snippet.
            if old_state and old_state[arg] then
                inode = i(insert, old_state["arg" .. arg]:get_text())
            else
                inode = i(insert)
            end
            vim.list_extend(
                nodes,
                { t({ " * @param " .. arg .. " " }), inode, t({ "", "" }) }
            )
            param_nodes["arg" .. arg] = inode

            insert = insert + 1
        end
    end

    if args[1][1] ~= "void" then
        local inode
        if old_state and old_state.ret then
            inode = i(insert, old_state.ret:get_text())
        else
            inode = i(insert)
        end

        vim.list_extend(
            nodes,
            { t({ " * ", " * @return " }), inode, t({ "", "" }) }
        )
        param_nodes.ret = inode
        insert = insert + 1
    end

    if vim.tbl_count(args[3]) ~= 1 then
        local exc = string.gsub(args[3][2], " throws ", "")
        local ins
        if old_state and old_state.ex then
            ins = i(insert, old_state.ex:get_text())
        else
            ins = i(insert)
        end
        vim.list_extend(
            nodes,
            { t({ " * ", " * @throws " .. exc .. " " }), ins, t({ "", "" }) }
        )
        param_nodes.ex = ins
        insert = insert + 1
    end

    vim.list_extend(nodes, { t({ " */" }) })

    local snip = sn(nil, nodes)
    -- Error on attempting overwrite.
    snip.old_state = param_nodes
    return snip
end

-- complicated function for dynamicNode.
local function cppdocsnip(args, _, old_state)
    dump(args)
    -- !!! old_state is used to preserve user-input here. DON'T DO IT THAT WAY!
    -- Using a restoreNode instead is much easier.
    -- View this only as an example on how old_state functions.
    local nodes = {
        t({ "/**", " * " }),
        i(1, "A short Description"),
        t({ "", "" }),
    }

    -- These will be merged with the snippet; that way, should the snippet be updated,
    -- some user input eg. text can be referred to in the new snippet.
    local param_nodes = {}

    if old_state then
        nodes[2] = i(1, old_state.descr:get_text())
    end
    param_nodes.descr = nodes[2]

    -- At least one param.
    if string.find(args[2][1], ", ") then
        vim.list_extend(nodes, { t({ " * ", "" }) })
    end

    local insert = 2
    for indx, arg in ipairs(vim.split(args[2][1], ", ", true)) do
        -- Get actual name parameter.
        arg = vim.split(arg, " ", true)[2]
        if arg then
            local inode
            -- if there was some text in this parameter, use it as static_text for this new snippet.
            if old_state and old_state[arg] then
                inode = i(insert, old_state["arg" .. arg]:get_text())
            else
                inode = i(insert)
            end
            vim.list_extend(
                nodes,
                { t({ " * @param " .. arg .. " " }), inode, t({ "", "" }) }
            )
            param_nodes["arg" .. arg] = inode

            insert = insert + 1
        end
    end

    if args[1][1] ~= "void" then
        local inode
        if old_state and old_state.ret then
            inode = i(insert, old_state.ret:get_text())
        else
            inode = i(insert)
        end

        vim.list_extend(
            nodes,
            { t({ " * ", " * @return " }), inode, t({ "", "" }) }
        )
        param_nodes.ret = inode
        insert = insert + 1
    end

    if vim.tbl_count(args[3]) ~= 1 then
        local exc = string.gsub(args[3][2], " throws ", "")
        local ins
        if old_state and old_state.ex then
            ins = i(insert, old_state.ex:get_text())
        else
            ins = i(insert)
        end
        vim.list_extend(
            nodes,
            { t({ " * ", " * @throws " .. exc .. " " }), ins, t({ "", "" }) }
        )
        param_nodes.ex = ins
        insert = insert + 1
    end

    vim.list_extend(nodes, { t({ " */" }) })

    local snip = sn(nil, nodes)
    -- Error on attempting overwrite.
    snip.old_state = param_nodes
    return snip
end

ls.snippets = {
    all = {
        s(
            "trig",
            c(1, {
                t("Ugh boring, a text node"),
                i(nil, "At least I can edit something now..."),
                f(function(args)
                    return "Still only counts as text!!"
                end, {}),
            })
        ),
    },
    lua = {
        parse({ trig = "high" }, high),
        parse({ trig = "time" }, time),
        parse({ trig = "M" }, module_snippet),
        parse({ trig = "lf" }, loc_func),
        parse({ trig = "cmd" }, map_cmd),
        parse({ trig = "inspect" }, inspect_snippet),
    },
    tex = {
        s("ls", {
            t({ "\\begin{itemize}", "\t\\item " }),
            i(1),
            d(2, rec_ls, {}),
            t({ "", "\\end{itemize}" }),
            i(0),
        }),
        parse({ trig = "beg" }, tex_begin),
        parse({ trig = "item" }, tex_itemize),
        parse({ trig = "table" }, tex_table),
        parse({ trig = "bd" }, tex_bold),
        parse({ trig = "it" }, tex_item),
        parse({ trig = "sec" }, tex_section),
        parse({ trig = "enum" }, tex_enumerate),
        parse({ trig = "desc" }, tex_description),
        parse({ trig = "ssec" }, tex_subsection),
        parse({ trig = "sssec" }, tex_subsubsection),
        parse({ trig = "para" }, tex_paragraph),
        parse({ trig = "->" }, tex_arrow),
        parse({ trig = "template" }, tex_template),
        s("ls", {
            t({ "\\begin{itemize}", "\t\\item " }),
            i(1),
            d(2, rec_ls, {}),
            t({ "", "\\end{itemize}" }),
            i(0),
        }),
    },
    java = {
        parse({ trig = "pus" }, public_string),
        parse({ trig = "puv" }, public_void),
        -- Very long example for a java class.
        s("fn", {
            d(6, jdocsnip, { 2, 4, 5 }),
            t({ "", "" }),
            c(1, {
                t("public "),
                t("private "),
            }),
            c(2, {
                t("void"),
                t("char"),
                t("int"),
                t("double"),
                t("boolean"),
                t("float"),
                i(nil, ""),
            }),
            t(" "),
            i(3, "myFunc"),
            t("("),
            i(4),
            t(")"),
            c(5, {
                t(""),
                sn(nil, {
                    t({ "", " throws " }),
                    i(1),
                }),
            }),
            t({ " {", "\t" }),
            i(0),
            t({ "", "}" }),
        }),
    },
    cpp = {
        s("fn", {
            d(4, cppdocsnip, { 1, 3, 3 }),
            t({ "", "" }),
            c(1, {
                t("void"),
                t("String"),
                t("char"),
                t("int"),
                t("double"),
                t("boolean"),
                i(nil, ""),
            }),
            t(" "),
            i(2, "myFunc"),
            t("("),
            i(3),
            t(")"),
            t({ " {", "\t" }),
            i(0),
            t({ "", "}" }),
        }),
    },
    gitcommit = {
        parse({ trig = "docs" }, gitcommit_docs),
        parse({ trig = "feat" }, gitcommit_feat),
        parse({ trig = "refactor" }, gitcommit_refactor),
        parse({ trig = "revert" }, gitcommit_revert),
        parse({ trig = "cleanup" }, gitcommit_cleanup),
        parse({ trig = "fix" }, gitcommit_fix),
        parse({ trig = "stylua" }, gitcommmit_stylua),
    },
    norg = {
        ls.parser.parse_snippet("ses", "- [ ] session $1 {$2} [$3->to]"),
        s("programmersay", {
            t({ "> Great programmer what can u teach me? " }),
            t({ "", "" }),
            t({ "@code comment" }),
            t({ "", "" }),
            f(function(args)
                local quotes = require("custom.quotes")
                math.randomseed(os.clock())
                local index = math.random() * #quotes
                local quote = quotes[math.floor(index) + 1]
                table.insert(quote, "")
                return quote
            end),
            t({ "" }),
            t({
                "      /",
                "     /",
                "    -",
                "   / \\",
                "   | |",
                "    -",
                "   /|\\",
                "  / | \\",
                "    |",
                "    |",
                "   / \\",
                "  /   \\",
                " /     \\",
                "",
            }),
            t({ "@end" }),
        }),
        s("cowsay", {
            t({ "> Senpai of the pool whats your wisdom ?" }),
            t({ "", "" }),
            t({ "@code comment" }),
            t({ "", "" }),
            f(function(args)
                local cow = io.popen("fortune | cowsay -f vader")
                local cow_text = cow:read("*a")
                cow:close()
                return vim.split(cow_text, "\n", true)
            end, {}),
            t({ "@end" }),
        }),

        s("weebsay", {
            t({ "> Senpai of the pool whats your wisdom ?" }),
            t({ "", "" }),
            t({ "@code comment" }),
            t({ "", "" }),
            f(function(args)
                local weeb = io.popen("weebsay")
                local weeb_text = weeb:read("*a")
                weeb:close()
                return vim.split(weeb_text, "\n", true)
            end, {}),
            t({ "@end" }),
        }),
        s("randomsay", {
            t({ "> Senpai of the pool whats your /Random/ wisdom ?" }),
            t({ "", "" }),
            t({ "@code comment" }),
            t({ "", "" }),
            f(function(args)
                local animal_list = {
                    "beavis.zen",
                    "default",
                    "head-in",
                    "milk",
                    "small",
                    "turkey",
                    "blowfish",
                    "dragon",
                    "hellokitty",
                    "moofasa",
                    "sodomized",
                    "turtle",
                    "bong",
                    "dragon-and-cow",
                    "kiss",
                    "moose",
                    "stegosaurus",
                    "tux",
                    "bud-frogs",
                    "elephant",
                    "kitty",
                    "mutilated",
                    "stimpy",
                    "udder",
                    "bunny",
                    "elephant-in-snake",
                    "koala",
                    "ren",
                    "surgery",
                    "vader",
                    "vader-koala",
                    "cower",
                    "flaming-sheep",
                    "luke-koala",
                    "sheep",
                    "skeleton",
                    "three-eyes",
                    "daemon",
                    "ghostbusters",
                    "meow",
                    "skeleton",
                    "three-eyes",
                }

                local cow_command = "fortune | cowsay -f "
                    .. animal_list[math.random(1, #animal_list)]
                local cow = io.popen(cow_command)
                local cow_text = cow:read("*a")
                cow:close()
                return vim.split(cow_text, "\n", true)
            end, {}),
            t({ "@end" }),
        }),
    },
}

require("ignis.modules.completion.snippets.tex_math")

require("luasnip/loaders/from_vscode").load({
    paths = { "~/.local/share/nvim/site/pack/packer/opt/friendly-snippets" },
})
