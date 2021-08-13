M = {}
local ns = vim.api.nvim_create_namespace('color_galaxy')

local c = {
  black             = "#000000",
  black_two         = "#282828",
  white             = "#FFFFFF",
  white_two         = "#EBDBB2",

  green_one         = "#207245",
  green_two         = "#8ABB26",
  green_three       = "#B8BB26",
  green_four        = "#9ABB26",
  green_five        = "#8EC07C",

  blue_one          = "#3572A5",
  blue_two          = "#519ABA",
  blue_three        = "#009999",
  blue_four         = "#4090FF",
  blue_five         = "#316AD0",
  blue_six          = "#0048FF",

  purple_one        = "#6600CC",

  yellow_one        = "#FABD2F",

  red_one           = "#B30B00",
  red_two           = "#CC0000",
  red_three         = "#D82B26",
  red_four          = "#FB4934",

  orange_one        = "#FE8019",

  background_one    = "#3C3836",
  background_two    = "#7C6F64",
  background_three  = "#504945",

}

local back = nil

local Usual = {
  MarkdownHighlights = {
    markdownH1          = { fg = c.red_three, bold = true },
    markdownH2          = { fg = c.red_three, bold = true },
    markdownH3          = { fg = c.red_three, bold = true },
    markdownH4          = { fg = c.red_three, bold = true },
    markdownHeadingDelimiter = { fg = c.white_two },
    markdownListMarker = { fg = c.blue_three },
    markdownUnorderedListMarker = { fg = c.blue_three },
    markdownOrderedListMarker = { fg = c.blue_three },
    markdownItalic      = { italic = true },
    markdownBold        = { bold = true },
    markdownCodeDelimiter = { fg = c.orange_one },
    markdownCode        = { fg = c.green_two },
    markdownLinkText    = { fg = c.blue_six },
    markdownUrl         = { fg = c.red_three },
    markdownRule        = { fg = c.blue_four },
    markdownHeadingRule        = { fg = c.blue_four },
  },
  UsualHighlights = {
    Normal              = { bg = back },
    NormalFloat         = { bg = c.background_two, fg = c.white_two },
    Identifier          = { fg = c.green_two },
    Keyword             = { fg = c.red_one },
    FloatBorder         = { fg = c.blue_six, bg = c.background_one },
    NonText             = { bg = back },
    LineNr              = { fg = c.background_two },
    SignColumn          = { bg = nil },
    CursorLine          = { bg = c.background_one },
    CursorLineNr        = { fg = c.yellow_one, bold = true },
    StatusLine          = { fg = c.white_two, bg = c.background_three },
    StatusLineNC          = { fg = c.white_two, bg = c.background_three },
    Search              = { fg = c.black_two, bg =c.yellow_one, bold = true },
    IncSearch           = { fg = c.black_two, bg =c.orange_one, bold = true},
    Folded              = { fg = c.white, bold = true, italic = true },
    Visual              = { reverse = true },
    EndOfBuffer         = { bg = back },
    Comment             = { fg = c.white, bold = true, italic = true },
    preProc             = { fg = c.blue_four },
    Matchparen	        = { underline = true},
    Pmenu               = { fg = c.white_two, bg = c.background_two },
    Pmenusel            = { fg = c.black, bg = c.purple_one },
  },
  Help = {
    helpHyperTextEntry  = { fg = c.green_two },
    helpHyperTextJump   = { fg = c.blue_three },
    helpHeader          = { fg = c.red_three },
    helpOption          = { fg = c.blue_five },
    helpHeadline        = { fg = c.purple_one },
  },
  GitCommit = {
    gitcommitSummary    = { fg = c.orange_one },
    gitcommitSelectedType = { fg = c.green_four },
    gitcommitSelectedFile = { fg = c.red_three },
  },
  Diff = {
    diffAdded           = { fg = c.green_two, bold = true },
    diffRemoved         = { fg = c.red_one, bold = true },
    gitDiff             = { fg = c.white },
    diffLine            = { fg = c.blue_three },
  },
  TSHighlights = {
    NodeNumber          = { fg = c.blue_five },
    NodeOp              = { fg = c.red_four },
    TSVariable          = { fg = c.yellow_one },
    TSKeywordOperator   = { fg = c.red_one },
    TSConditional       = { fg = c.red_one },
    TSNumber            = { fg = c.blue_two },
    TSOperator          = { fg = c.blue_one },
    TSKeyword           = { fg = c.red_one, italic = true },
    TSString            = { fg = c.blue_three },
    TSConstant          = { fg = c.blue_three },
    TSProperty          = { fg = c.blue_three },
    TSField             = { fg = c.green_one },
    TSBoolean           = { fg = c.purple_one },
    TSRepeat            = { fg = c.red_two },
    TSKeywordFunction   = { fg = c.red_two },
    TSFunction          = { fg = c.green_two, bold = true },
  },

  LspRelated = {
    LspDiagnosticsDefaultError = { bg = back, fg = c.red_four },
    LspDiagnosticsDefaultHint = { bg = back, fg = c.blue_two },
    LspDiagnosticsDefaultWarning = { bg = back, fg = c.orange_one },
    LspDiagnosticsDefaultInformation = { bg = back, fg = c.yellow_one },
  },
}

local Plugins = {
  signify = {
    SignifyLineChange   = { bg = back, fg = c.orange_one },
    SignifySignChange   = { bg = back, fg = c.orange_one },
    SignifyLineAdd      = { bg = back, fg = c.green_three },
    SignifySignAdd      = { bg = back, fg = c.green_three },
    SignifyLineDelete   = { bg = back, fg = c.red_three },
    SignifySignDelete   = { bg = back, fg = c.red_three },
  },
  Fugitive = {
    fugitiveHunk        = { fg = c.white },
    fugitiveHeader      = { fg = c.orange_one },
    fugitiveSymbolicRef = { fg = c.blue_six },
    fugitiveUnstagedHeading = { fg = c.red_three },
    fugitiveStagedHeading = { fg = c.red_three },
    fugitiveUnstagedModifier = { fg = c.green_one },
    fugitiveStagedModifier = { fg = c.green_one },
    fugitiveHash        = { fg = c.blue_five },
    fugitiveHeading     = { fg = c.blue_six },
    fugitiveSection     = { fg = c.green_two },
    fugitiveUnstagedSection = { fg = c.green_two },
    fugitiveStagedSection = { fg = c.green_two },
    fugitiveCount       = { fg = c.red_two },
  },
}

local lang = {

}

local function add_highlight_table(tbl)
    for hl_grp, hl_value in pairs(tbl) do
	vim.api.nvim_set_hl(ns, hl_grp, hl_value)
    end
end

function M.Lang_high(ft)
    if vim.api.nvim_buf_is_valid(0) and vim.api.nvim_buf_is_loaded(0) then
	add_highlight_table(lang[ft] or {})
    end
end

function M.shine()
    vim.cmd 'highlight clear'
    if vim.fn.exists("syntax_on") then vim.cmd'syntax reset' end
    vim.g.colors_name = "noice"

    for _, tbl in pairs(Usual) do add_highlight_table(tbl) end
    for _, tbl in pairs(Plugins) do add_highlight_table(tbl) end

    local bg = back or "none"
    vim.cmd('hi Normal guibg='..bg..' guifg=#dddddd')

    vim.cmd [[au BufEnter,FileType * :lua require"colors.color_galaxy".Lang_high(vim.bo.ft)]]
    vim.api.nvim__set_hl_ns(ns)
end

return M