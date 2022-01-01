local map = vim.api.nvim_set_keymap
local nore_silent = { noremap = true, silent = true }
local nore = { noremap = true }
local wk = require("which-key")

wk.register({
  e = {
    name = "+Explore",
    f = { "<cmd>lua require'lir.float'.init()<CR>", "Float" },
    l = { "<cmd>PackerLoad lir.nvim<CR><cmd>lua require'lir'.init()<CR>", "Lir" },
    s = { "<cmd>SymbolsOutline<CR>", "Symbols Outline" },
  },
  -- == Git ==
  g = {
    name = "+Git",
    s = { "<cmd>G<CR>", "Status" },
    p = { "<cmd>Git push<CR>", "Push" },
    d = { "<cmd>lua require('configs.telescope').git_diff()<CR>", "Diff" },
    l = { "<cmd>Telescope git_commits<CR>", "Log" },
    c = { "<cmd>Git commit<CR>", "Commit" },
    a = { "<cmd>Git add %<CR>", "Add" },
    h = {
      name = "+Hunk",
      s = "Stage",
      u = "Undo stage",
      r = "Reset",
      R = "Reset buffer",
      p = "Preview",
      b = "Blame line",
    },
  },
  -- d = {
  --   name = "+Definition",
  --   p = { "<cmd>lua require'configs.lsp'.PeekDefinition()<CR>", "Peek" },
  -- },
  n = {
    name = "+Nvim-Tree",
    t = { "<cmd>NvimTreeToggle<CR>", "Toggle" },
    c = { "<cmd>NvimTreeClose<CR>", "Close" },
  },
  c = {
    name = "+Comment, Clipboard, Colors",
    b = {
      "<cmd>lua require('telescope').extensions.neoclip.default()<CR>",
      "Clipboard",
    },
    c = { "Toggle comment line" },
  },
  -- == Colors ==
  C = {
    name = "+Colors",
    n = {
      "<cmd>lua require'configs.telescope'.colorschemes()<CR>",
      "NvChad Base 16 Picker",
    },
    s = {
      "<cmd>Telescope highlights<CR>",
      "Search",
    },
  },
  r = "Run",
  -- == Markdown ==
  m = {
    name = "Markdown",
    d = {
      name = "Markdown",
      h = {
        name = "Heading, HR",
        ["1"] = { "<cmd>MdHeading1<CR>", "Heading 1" },
        ["2"] = { "<cmd>MdHeading2<CR>", "Heading 2" },
        ["3"] = { "<cmd>MdHeading3<CR>", "Heading 3" },
        ["r"] = { "<cmd>MdHorizontalRule<CR>", "Horizontal Rule" },
      },
      a = { "<cmd>MdLink<CR>", "Link" },
      l = {
        name = "List",
        u = { "<cmd>MdUnorderedList<CR>", "Unordered" },
        o = { "<cmd>MdOrderedList<CR>", "Ordered" },
        t = { "<cmd>MdTaskList<CR>", "Task" },
      },
    },
  },
  -- == Errors ==
  x = {
    name = "+Errors",
    x = { "<cmd>TroubleToggle<CR>", "Trouble" },
    w = { "<cmd>Trouble lsp_workspace_diagnostics<CR>", "Workspace Trouble" },
    d = { "<cmd>Trouble lsp_document_diagnostics<CR>", "Document Trouble" },
    t = { "<cmd>TodoTrouble<CR>", "Todo Trouble" },
    T = { "<cmd>TodoTelescope<CR>", "Todo Telescope" },
    l = { "<cmd>lopen<CR>", "Open Location List" },
    q = { "<cmd>copen<CR>", "Open Quickfix List" },
  },
  t = {
    name = "+Table, Tasks",
    m = { "<cmd>TableModeToggle<CR>", "Toggle Table Mode" },
    t = { "Tabelize" },
    v = { "<cmd>Neorg gtd views<CR>", "View Tasks" },
    c = { "<cmd>Neorg gtd capture<CR>", "Capture Taks" },
    e = { "<cmd>Neorg gtd edit<CR>", "Edit Task" },
  },
  l = {
    name = "+Last, Load",
    f = { "<cmd>so<CR>", "Load File" },
    s = {
      "<cmd>lua require('configs.telescope').grep_last_search()<CR>",
      "Grep Last Search",
    },
  },
  -- == Help ==
  ["h"] = {
    name = "+Help, Harpoon",
    t = { "<cmd>Telescope builtin<CR>", "Telescope" },
    c = { "<cmd>Telescope commands<CR>", "Commands" },
    h = { "<cmd>lua require'configs.telescope'.help_tags()<CR>", "Help Pages" },
    m = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
    k = { "<cmd>Telescope keymaps<CR>", "Key Maps" },
    -- s = { "<cmd>Telescope highlights<CR>", "Search Highlight Groups" },
    l = {
      [[<cmd>TSHighlightCapturesUnderCursor<CR>]],
      "Highlight Groups at cursor",
    },
    o = { "<cmd>Telescope vim_options<CR>", "Options" },
    f = { "<cmd>lua require'float_help'.float_help()<CR>", "Help Files" },
    p = {
      name = "+Harpoon",
      a = { "<cmd>lua require('harpoon.mark').add_file()<CR>", "Add File" },
      m = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Menu" },
      n = { "<cmd>lua require('harpoon.ui').nav_next()<CR>", "Next File" },
      p = { "<cmd>lua require('harpoon.ui').nav_prev()<CR>", "Previous File" },
      t = { "<cmd>Telescope harpoon marks<CR>", "Telescope" },
    },
  },
  u = { "<cmd>UndotreeToggle<CR>", "UndoTree" },
  --== Buffers ==
  b = {
    name = "+Buffer",
    ["b"] = { "<cmd>e #<CR>", "Switch to Other Buffer" },
    ["p"] = { "<cmd>BufferLineCyclePrev<CR>", "Previous Buffer" },
    ["["] = { "<cmd>BufferLineCyclePrev<CR>", "Previous Buffer" },
    ["n"] = { "<cmd>BufferLineCycleNext<CR>", "Next Buffer" },
    ["]"] = { "<cmd>BufferLineCycleNext<CR>", "Next Buffer" },
    ["d"] = { "<cmd>bd<CR>", "Delete Buffer" },
    ["g"] = { "<cmd>BufferLinePick<CR>", "Goto Buffer" },
  },
  --== Search ==
  s = {
    name = "+Search",
    a = { "<cmd>Telescope autocommands<CR>", "Auto Commands" },
    g = { "<cmd>lua require('configs.telescope').find_string()<CR>", "Grep" },
    b = { "<cmd>lua require('configs.telescope').curbuf()<CR>", "Buffer" },
    d = { "<cmd>Telescope lsp_document_diagnostics<CR>", "Diagnostics" },
    o = { "<cmd>Telescope buffers<CR>", "Open Buffers" },
    e = { "<cmd>lua require'telescope.builtin'.symbols{}<CR>", "Emojis" },
    l = { "<cmd>Telescope luasnip<CR>", "Luasnip" },
    y = {
      "<cmd>lua require('telescope').extensions.neoclip.default()<CR>",
      "Yanks"
    },
    s = {
      function()
        require("telescope.builtin").lsp_workspace_symbols()
      end,
      "Goto Symbol",
    },
    h = { "<cmd>Telescope command_history<CR>", "Command History" },
    m = { "<cmd>Telescope marks<CR>", "Jump to Mark" },
    c = {
      "<cmd>lua require'configs.telescope'.code_actions()<CR>",
      "Code Actions",
    },
    t = { "<cmd>TodoTelescope<CR>", "Todo Comments" },
  },
  --== Files ==
  F = {
    name = "+File",
    r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
    n = { "<cmd>enew<CR>", "New File" },
  },
  --== Find ==
  f = {
    name = "+Find",
    f = {
      [[<cmd>lua require'configs.telescope'.find_files()<CR>]],
      "File",
    },
    ["/"] = { "<cmd>Telescope grep_last_search<CR>", "Grep Last Search" },
    o = { "<cmd>Telescope oldfiles<CR>", "Oldfiles" },
    b = { "<cmd>Telescope buffers show_all_buffers=true<cr>", "Switch Buffer" },
    N = {
      "<cmd>lua require'configs.telescope'.search_config()<CR>",
      "Neovim Config",
    },
    h = { "<cmd>lua require'configs.telescope'.help_tags()<CR>", "Help Tags" },
    n = { "<cmd>lua require'configs.telescope'.find_notes()<CR>", "Notes" },
    B = { "<cmd>Telescope<CR>", "Builtin" },
    r = { "<cmd>Telescope registers<CR>", "Registers" },
    m = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
    a = { "<cmd>Telescope autocommands<CR>", "Autocommands" },
    O = { "<cmd>Telescope vim_options<CR>", "Vim Options" },
    c = { "<cmd>Telescope commands<CR>", "Commands" },
  },
  --== Insert ==
  i = {
    name = "+Insert",
    o = { "o<ESC>k", "Empty line below" },
    O = { "O<ESC>j", "Empty line above" },
    i = { "i <ESC>l", "Space before" },
    a = { "a <ESC>h", "Space after" },
    ["<CR>"] = { "i<CR><ESC>", "Linebreak at Cursor" },
  },
  a = { "<cmd>lua require('neogen').generate()<CR>", "Generate Annotations" },
  ["."] = {
    "<cmd>lua require('configs.telescope').file_browser()<CR>",
    "Browse Files",
  },
  ["/"] = {
    "<cmd>lua require('configs.telescope').find_string()<cr>",
    "Live Grep",
  },
  [":"] = { "<cmd>Telescope command_history<cr>", "Command History" },
  q = {
    name = "+Quickfix",
    n = { "<cmd>cnext<CR>", "Next Entry" },
    p = { "<cmd>cprevious<CR>", "Previous Entry" },
  },
  j = { ":m .+1<CR>==", "Move Current line down" },
  k = { ":m .-2<CR>==", "Move Current line up" },
  y = { '"+y', "Yank to clipboard" },
  p = { '"0p', "Paste last yanked text" },
  P = { '"0P', "Paste last yanked text" },
  --== Window ==
  w = {
    name = "+Window",
    ["w"] = { "<C-W>p", "other-window" },
    ["d"] = { "<C-W>c", "delete-window" },
    ["-"] = { "<C-W>s", "split-window-below" },
    ["|"] = { "<C-W>v", "split-window-right" },
    ["2"] = { "<C-W>v", "layout-double-columns" },
    ["h"] = { "<C-W>h", "window-left" },
    ["j"] = { "<C-W>j", "window-below" },
    ["l"] = { "<C-W>l", "window-right" },
    ["k"] = { "<C-W>k", "window-up" },
    ["H"] = { "<C-W>5<", "expand-window-left" },
    ["J"] = { ":resize +5<CR>", "expand-window-below" },
    ["L"] = { "<C-W>5>", "expand-window-right" },
    ["K"] = { ":resize -5<CR>", "expand-window-up" },
    ["="] = { "<C-W>=", "balance-window" },
    ["s"] = { "<C-W>s", "split-window-below" },
    ["v"] = { "<C-W>v", "split-window-right" },
  },
  v = {
    name = "+View",
    l = { "<cmd>lua require'utils'.LatexPreview()<CR>", "Latex" },
    m = { "<cmd>lua require'utils'.MarkdownPreview()<CR>", "Markdown" },
    -- c = {"<cmd>ColorizerAttachToBuffer<CR>", "Colorizer"},
    c = { "<cmd>PackerLoad nvim-colorizer.lua<CR>", "Colorizer" },
  },
}, {
  prefix = "<leader>",
  mode = "n",
})
wk.register({
  R = {
    name = "+Refactor",
    t = { "" },
  },
}, {
  prefix = "<leader>",
  mode = "n",
})

-- Windows
-- =======
-- easy split navigation
map("n", "<c-j>", ":wincmd j<CR>", nore_silent)
map("n", "<c-h>", ":wincmd h<CR>", nore_silent)
map("n", "<c-k>", ":wincmd k<CR>", nore_silent)
map("n", "<c-l>", ":wincmd l<CR>", nore_silent)
-- move windows with arrows
map("n", "<down>", ":wincmd J<CR>", nore_silent)
map("n", "<left>", ":wincmd H<CR>", nore_silent)
map("n", "<up>", ":wincmd K<CR>", nore_silent)
map("n", "<right>", ":wincmd L<CR>", nore_silent)

map("n", "°", ":normal! zO<CR>", nore_silent)

-- Telescope
-- =========
map("n", "<C-s>", ":lua require('configs.telescope').curbuf()<CR>", nore_silent)

-- Simple Commands (Improvements of commands)
-- ==========================================

-- highlight search result and center cursor
map("n", "n", "nzzzv", nore_silent)
map("n", "N", "Nzzzv", nore_silent)

-- reselect selection after shifting
map("x", "<", "<gv", nore)
map("x", ">", ">gv", nore)

-- move lines up and down in insert mode
map("i", "<C-j>", "<ESC>:m .+1<CR>==i<RIGHT>", nore)
map("i", "<C-k>", "<ESC>:m .-2<CR>==i<RIGHT>", nore)

-- remove highlighting from search
map("n", "nh", ":nohlsearch<CR>", nore_silent)
map("n", "<ESC>", "<cmd>nohl<CR>", nore_silent)
-- easier escape
map("v", "jk", "<ESC>", nore)

-- paste over selected text without overwriting yank register
map("v", "<leader>p", '"_dP', nore)

-- execute macro q
map("n", "Q", "@q", nore)

-- alt-r to see registers
map(
  "n",
  "®",
  "<cmd>lua require('which-key').show('@', {mode='n',auto=true})<CR>",
  nore_silent
)

-- move visual blocks up and down
map("v", "J", ":m '>+1<CR>gv=gv", nore_silent)
map("v", "K", ": m'<-2<CR>gv=gv", nore_silent)

-- don't move cursor down when joining lines
map("n", "J", "mzJ`z", nore)
map("x", "<BS>", "x", nore)

-- substitute on visual selection
map("v", "<leader>s", ":s///g<LEFT><LEFT><LEFT>", nore)

-- Random
-- ======

-- move right in insert mode
map("i", "  ", "<RIGHT>", nore)

-- better undo
map("i", ",", ",<c-g>u", nore)
map("i", "!", "!<c-g>u", nore)
map("i", ".", ".<c-g>u", nore)
map("i", " ", " <c-g>u", nore)
map("i", "?", "?<c-g>u", nore)
map("i", "_", "_<c-g>u", nore)
map("i", "<CR>", "<CR><c-g>u", nore)

-- Close toggleterm
map("t", "<c-t>", "<cmd>ToggleTerm<CR>", nore_silent)
map("t", "<c-g>", "<cmd>ToggleTerm<CR>", nore_silent)

-- lsp
map("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", nore_silent)

-- help from ts with textobjects
map("o", "m", ":<C-U>lua require('tsht').nodes()<CR>", { silent = true })
map("v", "m", ":<C-U>lua require('tsht').nodes()<CR>", nore_silent)

-- open helpfile of word under cursor
map(
  "n",
  "<C-f>",
  ':lua vim.cmd(":vert :h "..vim.fn.expand("<cword>"))<CR>',
  nore_silent
)

-- jump to mark m
map("n", "M", "`m", nore_silent)

-- append comma and semicolon
map("n", ",,", "<cmd>lua require'utils'.append_comma()<CR>", nore_silent)
map("n", ";;", "<cmd>lua require'utils'.append_semicolon()<CR>", nore_silent)

-- change case of cword
map("n", "<C-U>", "b~", nore_silent)
map("i", "<C-U>", "<ESC>b~A", nore_silent)

map("v", "<leader>n", ":norm ", nore_silent)

-- luasnip
map(
  "i",
  "<leader><tab>",
  "<cmd>lua require('luasnip').expand_or_jump()<CR>",
  nore_silent
)
-- add j and k with count to jumplist
map(
  "n",
  "j",
  [[(v:count > 1 ? "m'" . v:count : '') . 'j']],
  { noremap = true, expr = true }
)
map(
  "n",
  "k",
  [[(v:count > 1 ? "m'" . v:count : '') . 'k']],
  { noremap = true, expr = true }
)

map("n", "<Leader>?", ":TodoQuickFix<CR>", nore)

-- Refactor.nvim

local opts = { noremap = true, silent = true, expr = false }

map(
  "n",
  "<leader>Rp",
  ":lua require('refactoring').debug.printf({below = false})<CR>",
  { noremap = true }
)

-- Print var: this remap should be made in visual mode
map(
  "v",
  "<leader>Rv",
  ":lua require('refactoring').debug.print_var({})<CR>",
  { noremap = true }
)

-- Cleanup function: this remap should be made in normal mode
map(
  "n",
  "<leader>Rc",
  ":lua require('refactoring').debug.cleanup({})<CR>",
  { noremap = true }
)

-- Remap to open the Telescope refactoring menu in visual mode
map(
  "v",
  "<Leader>Rt",
  [[ <Esc><Cmd>lua require"configs.refactor".refactors()<CR>]],
  opts
)
map(
  "v",
  "<Leader>Re",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
  opts
)
map(
  "v",
  "<Leader>Rf",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
  opts
)
map(
  "v",
  "<Leader>Rv",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
  opts
)

map(
  "v",
  "<Leader>Ri",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
  opts
)
