local util = require "utils"
local luasnip = require "luasnip"

luasnip.config.set_config {
  history = true,
  -- Update more often, :h events for more info.
  updateevents = "TextChanged,TextChangedI",
}

require("luasnip/loaders/from_vscode").load()

local ls = require "luasnip"
local parse = ls.parser.parse_snippet

local high = [[
${1:HighlightGroup} = { fg = "${2}", bg = "${3}" },${0}
]]

local module_snippet = [[
local ${1:M} = {}
${0}
return $1
]]

local map_cmd = [[
  <cmd>${0}<CR>
]]

local public_string = [[
public String ${1:function_name}(${2:parameters}) {
  ${0}
}
]]

local public_void = [[
public void ${1:function_name}(${2:parameters}) {
  ${0}
}
]]

local gitcommit_fix = [[
fix(${1:scope}): ${2:title}

${0}
]]

local gitcommit_cleanup = [[
cleanup(${1:scope}): ${2:title}

${0}
]]
local gitcommit_revert = [[
revert: ${2:header of reverted commit}

This reverts commit ${0:<hash>}
]]
local gitcommit_feat = [[
feat(${1:scope}): ${2:title}

${0}
]]
local gitcommit_docs = [[
docs(${1:scope}): ${2:title}

${0}
]]
local gitcommit_refactor = [[
refactor(${1:scope}): ${2:title}

${0}
]]

local tex_begin = [[
\\begin{$1}
	$0
\\end{$1}
]]

local tex_arrow = [[
$\implies$
]]

local tex_paragraph = [[
\paragraph{$1}
]]

local tex_template = [[
\documentclass[a4paper,12pt]{article}

\usepackage{textcomp}
\usepackage[german]{babel}
\usepackage{amsmath, amssymb}
\usepackage{graphicx}
\usepackage{tikz}

\begin{document}
$0
\end{document}
]]

local tex_section = [[
\section{$1}
]]

local tex_subsection = [[
\subsection{$1}
]]

local tex_enumerate = [[
\begin{enumerate}
	\item $0
\end{enumerate}
]]

local tex_item = [[
\item 
]]

local tex_bold = [[
\textbf{$1}
]]

local tex_itemize = [[
\begin{itemize}
	\item $0
\end{itemize}
]]

ls.snippets = {
  lua = {
    parse({ trig = "high", wordTrig = true }, high),
    parse({ trig = "M", wordTrig = true }, module_snippet),
    parse({ trig = "cmd", wordTrig = true }, map_cmd),
  },
  tex = {
    parse({ trig = "beg", wordTrig = true }, tex_begin),
    parse({ trig = "item", wordTrig = true }, tex_itemize),
    parse({ trig = "bd", wordTrig = true }, tex_bold),
    parse({ trig = "it", wordTrig = true }, tex_item),
    parse({ trig = "sec", wordTrig = true }, tex_section),
    parse({ trig = "enum", wordTrig = true }, tex_enumerate),
    parse({ trig = "subsec", wordTrig = true }, tex_subsection),
    parse({ trig = "para", wordTrig = true }, tex_paragraph),
    parse({ trig = "->" }, tex_arrow),
    parse({ trig = "template", wordTrig = true }, tex_template),
  },
  java = {
    parse({ trig = "pus", wordTrig = true }, public_string),
    parse({ trig = "puv", wordTrig = true }, public_void),
  },
  gitcommit = {
    parse({ trig = "docs", wordTrig = true }, gitcommit_docs),
    parse({ trig = "feat", wordTrig = true }, gitcommit_feat),
    parse({ trig = "refactor", wordTrig = true }, gitcommit_refactor),
    parse({ trig = "revert", wordTrig = true }, gitcommit_revert),
    parse({ trig = "cleanup", wordTrig = true }, gitcommit_cleanup),
    parse({ trig = "fix", wordTrig = true }, gitcommit_fix),
  },
}
