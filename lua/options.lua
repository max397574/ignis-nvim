local opt = vim.opt
local g = vim.g

-- colorscheme settings
g.onedark_style = "deep"
g.tokyonight_style = "day"
g.tokyodark_transparent_background = true

-- builtin plugins
g.loaded_gzip = false
g.loaded_matchit = false
g.loaded_netrwPlugin = false
g.loaded_tarPlugin = false
g.loaded_zipPlugin = false
g.loaded_man = false
g.loaded_2html_plugin = false
g.loaded_remote_plugins = false

opt.pumblend = 18
-- dark background
opt.background = "dark"
-- height of cmd line
opt.cmdheight = 1
-- allow visual mode to go over end of lines
opt.virtualedit = "block"
-- expand tabs to spaces
opt.expandtab = true
opt.softtabstop = 4
opt.shiftwidth = 4
-- show preview of commands in split
opt.inccommand = "split"
opt.splitbelow = true
opt.splitright = true
-- relative line numbers
opt.relativenumber = true
-- show line number at cursor line
opt.number = true
-- start scrolling 3 lines away from top/bottom
opt.scrolloff = 3
-- highlight current line
opt.cursorline = true
-- update every 2000ms
opt.updatetime = 2000
-- ignore case for search
opt.ignorecase = true
-- don't ignore when upercase search
opt.smartcase = true
opt.hidden = true
-- time between keystrokes of mappings
opt.timeoutlen = 300
opt.compatible = false
-- wrap long lines
opt.wrap = true
opt.breakindent = true
opt.showbreak = string.rep(" ", 3)
opt.linebreak = true
-- allow mouse in normal and visual mode
opt.mouse = "nv"

opt.foldlevel = 0
opt.joinspaces = false
opt.completeopt = "menuone,noselect"
-- always signcolumn, 3 wide
opt.signcolumn = "yes:3"
opt.termguicolors = true
opt.conceallevel = 0

-- use treesitter for folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

opt.undodir = vim.fn.expand("~") .. "/.vim/undodir"
opt.undofile = true

opt.joinspaces = false

-- no fillchars at end of buffer
opt.fillchars = { eob = " " }
