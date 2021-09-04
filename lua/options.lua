local opt = vim.opt
local g = vim.g

opt.runtimepath = opt.runtimepath + "~/.config/nvim/queries"

g.onedark_style = "deep"
g.tokyonight_style = "day"
g.tokyodark_transparent_background = true

g.loaded_gzip = false
g.loaded_matchit = false
g.loaded_netrwPlugin = false
g.loaded_tarPlugin = false
g.loaded_zipPlugin = false
g.loaded_man = false
g.loaded_2html_plugin = false
g.loaded_remote_plugins = false

opt.pumblend = 18
opt.background = "dark"
opt.cmdheight = 1
opt.virtualedit = "block"
opt.expandtab = true
opt.softtabstop = 4
opt.shiftwidth = 4
opt.inccommand = "split"
opt.splitbelow = true
opt.splitright = true
opt.relativenumber = true
opt.number = true
opt.scrolloff = 3
opt.cursorline = true
opt.updatetime = 2000
opt.ignorecase = true
opt.smartcase = true
opt.hidden = true
opt.timeoutlen = 300
opt.compatible = false
opt.wrap = true
opt.breakindent = true
opt.showbreak = string.rep(" ", 3)
opt.linebreak = true
opt.mouse = "nv"

opt.foldlevel = 0
opt.joinspaces = false
opt.completeopt = "menuone,noselect"
opt.signcolumn = "yes:3"
opt.termguicolors = true
opt.conceallevel = 0

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

opt.undodir = vim.fn.expand("~") .. "/.vim/undodir"
opt.undofile = true

opt.joinspaces = false
opt.fillchars = { eob = "~" }
