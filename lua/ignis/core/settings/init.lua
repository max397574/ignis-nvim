-- The default settings for ignis

local opt = vim.opt
local g = vim.g

opt.shortmess:append("c")
-- opt.iskeyword:remove("_")

opt.pumblend = 0
opt.formatoptions:remove({ "c", "r", "o" })
-- this executes `colorscheme` if vim.g.colors_name is set
-- opt.background = "dark" -- dark background
opt.cmdheight = 1 -- height of cmd line
opt.virtualedit = "block" -- allow visual mode to go over end of lines
opt.expandtab = true -- expand tabs to spaces
opt.softtabstop = 4
-- global statusline
opt.laststatus = 3
opt.shiftwidth = 4
opt.splitbelow = true
opt.splitright = true
opt.showmode = false -- don't show mode (I've lualine)
opt.relativenumber = true -- relative line numbers
opt.number = true -- show line number at cursor line
opt.scrolloff = 3 -- start scrolling 3 lines away from top/bottom
opt.cursorline = true -- highlight current line
opt.updatetime = 300 -- update CursorHold and save swap every 2000ms
opt.ignorecase = true -- ignore case for search
opt.smartcase = true -- don't ignore when upercase search
opt.hidden = true
opt.timeoutlen = 300 -- time between keystrokes of mappings
opt.compatible = false
opt.wrap = true -- wrap long lines
opt.breakindent = true
opt.showbreak = string.rep(" ", 3)
opt.linebreak = true
opt.autowrite = true -- enable auto write
opt.mouse = "nv" -- allow mouse in normal and visual mode

opt.foldlevel = 100
-- opt.foldlevel = 1
opt.joinspaces = false
opt.completeopt = "menuone,noselect"
opt.signcolumn = "yes:3" -- always signcolumn, 3 wide
opt.termguicolors = true
opt.conceallevel = 2

opt.lazyredraw = true -- Do not redraw screen while processing macros

opt.list = true --show some hidden characters
opt.listchars = {
    tab = "> ",
    nbsp = "␣",
    -- trail = "•",
}

opt.foldmethod = "expr" -- use treesitter for folding
opt.foldexpr = "nvim_treesitter#foldexpr()"

opt.undofile = true
opt.undodir = vim.fn.expand("~") .. "/.vim/undodir" -- directory to save undofiles

-- no chars at eob and cool window separator
opt.fillchars = {
    eob = " ",
    vert = "║",
    horiz = "═",
    horizup = "╩",
    horizdown = "╦",
    vertleft = "╣",
    vertright = "╠",
    verthoriz = "╬",
}

g.table_mode_corner = "|" -- Tablemode

g.symbols_outline = {
    highlight_hovered_item = false,
    width = 65,
}
