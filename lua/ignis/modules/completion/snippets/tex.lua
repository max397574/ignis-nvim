local ls = require("luasnip")
local parse = ls.parser.parse_snippet
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local c = ls.choice_node

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
ls.snippets["tex"] = {
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
}
