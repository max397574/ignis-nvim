"settings for which-key plugin
call plug#begin('~/.vim/plugged')
Plug 'folke/which-key.nvim'
call plug#end()

lua << EOF

--{{{............................................................. Settings
require("which-key").setup {
    {
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        spelling = {
          enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
        presets = {
          operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
          motions = true, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
      -- add operators that will trigger motion and text object completion
      -- to enable all native operators, set the preset / operators plugin above
      operators = { gc = "Comments" },
      key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<CR>"] = "RET",
        -- ["<tab>"] = "TAB",
      },
      icons = {
        breadcrumb = "¬ª", -- symbol used in the command line area that shows your active key combo
        separator = "‚ûú", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
      },
      window = {
        border = "none", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
      },
      ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
      show_help = true, -- show help message on the command line when the popup is visible
      triggers = "auto", -- automatically setup triggers
      -- triggers = {"<leader>"} -- or specify a list manually
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
      },
    }
  }

--1}}}

--{{{............................................................. Lables
local wk = require("which-key")
wk.register({
  ts = {
    name = "telescope",
    ff = { "Find Files" },
    ts = { "TreeSitter" },
    ht = { "Help Tags" },
  },
  md = {
    name = "markdown",
    h = {
      name = "headings",
      ["1"] = { "Heading 1" },
      ["2"] = { "Heading 2" },
      ["3"] = { "Heading 3" },
    },
    pw = { "preview in browser" },
    a = { "add a link" },
    hr = { "add horizontal rule" },
    l = {
	name = "list",
	u = { "unordered list" },
	o = { "ordered list" },
	t = { "task list" },
    },
  },
  hp = { "Help Files" },
  d = { "Move Current line down" },
  u = { "Move Current line up" },
  tb = { "Toggle Tagbar" },
  o = { "Add empty line below" },
  O = { "Add empty line above" },
  df = { "Write distraction free" },
  w = { "Write current file" },
  ['"'] = { "Surround inner word with quotes" },
  ev = { "Edit init.vim in split" },
  t = {
      r = {
	  name = "Trouble",
	  t = { "Toggle" },
	  td = { "Todo" },
	  l = {
	      name = "Lsp",
	      d = { "Diagnostics" },

	      },
	  },
      },
  s = {
      name = "Substitue and Spelling",
      ["1"] = {"Substitue on current and next line"},
      ["2"] = {"Substitue on current and next 2 lines"},
      ["3"] = {"Substitue on current and next 3 lines"},
      ["4"] = {"Substitue on current and next 4 lines"},
      ["5"] = {"Substitue on current and next 5 lines"},
      ["6"] = {"Substitue on current and next 6 lines"},
      ["7"] = {"Substitue on current and next 7 lines"},
      ["8"] = {"Substitue on current and next 8 lines"},
      ["9"] = {"Substitue on current and next 9 lines"},
      s = {"Substitue on current line"},
      G = {"Substitue to the end of the file"},
      },
  }, { prefix = "<leader>", mode = "n" })

local wk = require("which-key")
wk.register({
  md = {
    name = "markdown",
    it = { "italic" },
    bd = { "bold" },
    },

}, { prefix = "<leader>", mode = "v" })
--1}}}

EOF
