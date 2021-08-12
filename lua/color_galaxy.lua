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
  UsualHihglights = {
    -- Normal           = { bg = back },
    NonText             = { bg = back },
    LineNr              = { fg = c.background_two },
    SignColumn          = { bg = nil },
    CursorLine          = { bg = c.background_one },
    CursorLineNr        = { fg = c.yellow_one, bold = true },
    StatusLine          = { fg = c.white_two, bg = c.background_three },
    Search              = { fg = c.black_two, bg =c.yellow_one, bold = true },
    IncSearch           = { fg = c.black_two, bg =c.orange_one, bold = true},
    MarkdownItalic      = { italic = true },
    MarkdownBold        = { bold = true },
    Folded              = { fg = c.white, bold = true, italic = true },
    Visual              = { reverse = true },
    EndOfBuffer         = { bg = back },
    Comment             = { fg = c.white, bold = true, italic = true },
    preProc             = { fg = c.blue_four },
    fugitiveHunk        = { fg = c.white },
  },
  Diff = {
    diffAdded           = { fg = c.green_two, bold = true },
    diffRemoved         = { fg = c.red_one, bold = true },
    gitDiff             = { fg = c.white },
  },
  TSHighlights = {
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
    LspDiagnosticsDefaultError = { bg = nil, fg = c.red_four },
    LspDiagnosticsDefaultHint = { bg = nil, fg = c.blue_two },
    LspDiagnosticsDefaultWarning = { bg = nil, fg = c.orange_one },
    LspDiagnosticsDefaultInformation = { bg = nil, fg = c.yellow_one },
  },
}

local Plugins = {
  signify = {
    SignifyLineChange   = { bg = nil, fg = c.orange_one },
    SignifySignChange   = { bg = nil, fg = c.orange_one },
    SignifyLineAdd      = { bg = nil, fg = c.green_three },
    SignifySignAdd      = { bg = nil, fg = c.green_three },
    SignifyLineDelete   = { bg = nil, fg = c.red_three },
    SignifySignDelete   = { bg = nil, fg = c.red_three },
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

    vim.cmd [[au BufEnter,FileType * :lua require"color_galaxy".Lang_high(vim.bo.ft)]]
    vim.api.nvim__set_hl_ns(ns)
end

return M
