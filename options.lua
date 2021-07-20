local opt = vim.opt

opt.pumblend = 18
opt.cmdheight = 2
opt.wrap = false
opt.expandtab = true
opt.softtabstop = 4
opt.shiftwidth = 4
opt.inccommand = "split"
opt.relativenumber = true
opt.number = true
opt.scrolloff = 8
opt.cursorline = true
opt.updatetime = 2000
opt.ignorecase = true
opt.smartcase = true
opt.hidden = true
opt.timeoutlen = 300
opt.wrap = true
opt.breakindent = true
opt.showbreak = string.rep(" ", 3)
opt.linebreak = true

opt.foldlevel = 0
opt.joinspaces = false
opt.completeopt = "menuone,noselect"
opt.signcolumn = "yes"
opt.autoindent = true
opt.termguicolors = true
opt.conceallevel = 0

vim.api.nvim_exec([[
  set undodir=~/.vim/undodir
  set undofile
  "use TreeSitter for folding
  set foldmethod=expr
  set foldexpr=nvim_treesitter#foldexpr()
  "function for custom fold text
  function! MyFoldText()
      let line = getline(v:foldstart)
      let folded_line_num = v:foldend - v:foldstart
      let line_text = substitute(line, '^"{\+', '', 'g')
      let fillcharcount = &textwidth - len(line_text) + 2
      return '+'. line_text . repeat('.', fillcharcount) . ' (' . folded_line_num . ' L)'
  endfunction
  "use the text of the function above
  set foldtext=MyFoldText()
]],
true)

opt.formatoptions = opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2"

opt.joinspaces = false

opt.fillchars = { eob = "~" }
