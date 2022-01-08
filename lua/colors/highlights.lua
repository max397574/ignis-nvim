local cmd = vim.cmd

local colors = require("colors").get()

local black = colors.black
local black2 = colors.black2
local blue = colors.blue
local darker_black = colors.darker_black
local folder_bg = colors.folder_bg
local green = colors.green
local grey = colors.grey
local grey_fg = colors.grey_fg
local line = colors.line
local nord_blue = colors.nord_blue
local one_bg = colors.one_bg
local one_bg2 = colors.one_bg2
local pmenu_bg = colors.pmenu_bg
local purple = colors.purple
local red = colors.red
local white = colors.white
local yellow = colors.yellow

local ui = {
  italic_comments = true,
  -- theme to be used, check available themes with `<leader> + t + h`
  theme = "onedark",
  -- toggle between two themes, see theme_toggler mappings
  theme_toggler = {
    "onedark",
    "gruvchad",
  },
  -- Enable this only if your terminal has the colorscheme set which nvchad uses
  -- For Ex : if you have onedark set in nvchad, set onedark's bg color on your terminal
  transparency = false,
}

-- Define bg color
-- @param group Group
-- @param color Color
local function bg(group, color)
  cmd("hi " .. group .. " guibg=" .. color)
end

-- Define fg color
-- @param group Group
-- @param color Color
local function fg(group, color)
  cmd("hi " .. group .. " guifg=" .. color)
end

-- Define bg and fg color
-- @param group Group
-- @param fgcol Fg Color
-- @param bgcol Bg Color
local function fg_bg(group, fgcol, bgcol)
  cmd("hi " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
end

-- Comments
if ui.italic_comments then
  fg("Comment", grey_fg .. " gui=italic")
else
  fg("Comment", grey_fg)
end

-- Disable cusror line
-- Line number
fg("cursorlinenr", white)

-- same it bg, so it doesn't appear
fg("EndOfBuffer", black)

-- For floating windows
bg("NormalFloat", black)

-- Pmenu
-- bg("Pmenu", one_bg)
bg("PmenuSbar", one_bg2)
bg("PmenuSel", blue)
bg("PmenuThumb", nord_blue)

-- misc
fg("LineNr", grey)
fg("NvimInternalError", red)
fg("VertSplit", one_bg2)

if ui.transparency then
  vim.cmd("hi clear CursorLine")
  bg("Normal", "NONE")
  bg("Folded", "NONE")
  fg("Folded", "NONE")
  fg("Comment", grey)
end

-- [[ Plugin Highlights

-- Dashboard
fg("DashboardCenter", grey_fg)
fg("DashboardFooter", grey_fg)
fg("DashboardHeader", grey_fg)
fg("DashboardShortcut", grey_fg)

-- Git signs
fg_bg("DiffAdd", nord_blue, "none")
fg_bg("DiffChange", grey_fg, "none")
fg_bg("DiffModified", nord_blue, "none")

-- Indent blankline plugin
fg("IndentBlanklineChar", line)

-- ]]

-- [[ LspDiagnostics

-- Errors
fg("LspDiagnosticsSignError", red)
fg("LspDiagnosticsSignWarning", yellow)
fg("LspDiagnosticsVirtualTextError", red)
fg("LspDiagnosticsVirtualTextWarning", yellow)

-- Info
fg("LspDiagnosticsSignInformation", green)
fg("LspDiagnosticsVirtualTextInformation", green)

-- Hints
fg("LspDiagnosticsSignHint", purple)
fg("LspDiagnosticsVirtualTextHint", purple)

-- ]]

-- NvimTree
fg("NvimTreeEmptyFolderName", blue)
fg("NvimTreeEndOfBuffer", darker_black)
fg("NvimTreeFolderIcon", folder_bg)
fg("NvimTreeFolderName", folder_bg)
fg("NvimTreeGitDirty", red)
fg("NvimTreeIndentMarker", one_bg2)
bg("NvimTreeNormal", darker_black)
fg("NvimTreeOpenedFolderName", blue)
fg("NvimTreeRootFolder", red .. " gui=underline") -- enable underline for root folder in nvim tree
fg_bg("NvimTreeStatuslineNc", darker_black, darker_black)
fg("NvimTreeVertSplit", darker_black)
bg("NvimTreeVertSplit", darker_black)
fg_bg("NvimTreeWindowPicker", red, black2)

fg_bg("TelescopeBorder", darker_black, darker_black)
fg_bg("TelescopePromptBorder", black2, black2)
fg_bg("TelescopePreviewBorder", darker_black, darker_black)
fg_bg("TelescopeResultsBorder", darker_black, darker_black)

fg_bg("TelescopePromptNormal", white, black2)
fg_bg("TelescopePromptPrefix", red, black2)

bg("TelescopeNormal", darker_black)
bg("TelescopePreviewNormal", darker_black)

fg_bg("TelescopePreviewTitle", black, green)
fg_bg("TelescopePromptTitle", black, red)
fg_bg("TelescopeResultsTitle", black, blue)
fg("TelescopeSelection", blue)
bg("TelescopeSelection", "#353b45")
bg("TelescopePreviewLine", "#353b45")

-- Disable some highlight in nvim tree if transparency enabled
if ui.transparency then
  bg("NvimTreeNormal", "NONE")
  bg("NvimTreeStatusLineNC", "NONE")
  bg("NvimTreeVertSplit", "NONE")
  fg("NvimTreeVertSplit", grey)
  bg("TelescopeNormal", "NONE")
  bg("TelescopePreviewNormal", "NONE")
end

bg("Search", yellow)
bg("IncSearch", red)

-- Telescope
fg("TelescopeBorder", folder_bg)
-- fg("TelescopePreviewBorder", folder_bg)
-- fg("TelescopePromptBorder", folder_bg)
-- fg("TelescopeResultsBorder", folder_bg)