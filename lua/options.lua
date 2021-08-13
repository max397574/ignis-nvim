local opt = vim.opt

opt.runtimepath = opt.runtimepath + '~/.config/nvim/queries'

opt.pumblend = 18
opt.background = "dark"
opt.cmdheight = 1
opt.virtualedit="block"
opt.expandtab = true
opt.softtabstop = 4
opt.shiftwidth = 4
opt.inccommand = "split"
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
opt.mouse="nv"

opt.foldlevel = 0
opt.joinspaces = false
opt.completeopt = "menuone,noselect"
opt.signcolumn = "yes"
opt.termguicolors = true
opt.conceallevel = 0

opt.foldmethod="expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

opt.undodir = vim.fn.expand('~') .. '/.vim/undodir'
opt.undofile = true

opt.joinspaces = false
opt.fillchars = { eob = "~" }
