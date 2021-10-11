local opt = vim.opt
local g = vim.g

-- colorscheme settings
g.onedark_style = "deep"
g.tokyonight_style = "storm"
g.tokyodark_transparent_background = true
g.galaxy_transparancy = false
g.galaxy_dynamic = false
g.galaxy_light = false

opt.shortmess:append "c"
opt.iskeyword:append "-"
opt.pumblend = 18
opt.formatoptions:remove { "c", "r", "o" }
opt.background = "dark" -- dark background
opt.cmdheight = 1 -- height of cmd line
opt.virtualedit = "block" -- allow visual mode to go over end of lines
opt.expandtab = true -- expand tabs to spaces
opt.softtabstop = 4
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

-- opt.foldlevel = 100
opt.foldlevel = 0
opt.joinspaces = false
opt.completeopt = "menuone,noselect"
opt.signcolumn = "yes:3" -- always signcolumn, 3 wide
opt.termguicolors = true
opt.conceallevel = 0

opt.list = true --show some hidden characters
opt.listchars = {
  tab = "> ",
  nbsp = "␣",
  trail = "•",
}

opt.foldmethod = "indent" -- use treesitter for folding
opt.foldexpr = "nvim_treesitter#foldexpr()"

opt.undodir = vim.fn.expand "~" .. "/.vim/undodir" -- directory to save undofiles
opt.undofile = true

opt.fillchars = { eob = " " } -- no fillchars at end of buffer

-- UltiSnips
g.UltiSnipsExpandTrigger = "<leader><tab>"
g.UltiSnipsJumpForwardTrigger = "<leader><tab>"
g.UltiSnipsSnippetDirectories = { "UltiSnips", "my_snippets" }

g.table_mode_corner = "|" -- Tablemode

g.did_load_filetypes = 1 -- use filetype.nvim instead

-- builtin plugins
g.loaded_gzip = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_matchit = 1
g.loaded_man = 1
g.loaded_remote_plugins = 1

g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_2html_plugin = 1

g.loaded_logiPat = 1
g.loaded_rrhelper = 1

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_netrwSettings = 1
g.loaded_netrwFileHandlers = 1
