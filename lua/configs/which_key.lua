local wk = require("which-key")

wk.register({
  l = {
    name = "LuaDev",
    d = {
      name = "LuaDev",
      r = { "Run" },
      l = { "Run Line" },
    },
  },
  g = {
    name = "Git",
    a = "Add",
    c = "Commit",
    d = "Diff",
    l = "Log",
    p = "Push",
    s = "Status",
  },
  j = { "Move Current line down" },
  k = { "Move Current line up" },
  o = { "Add empty line below" },
  O = { "Add empty line above" },
  i = { "Add space before" },
  a = { "Add space after" },
  n = { "TreeSitter Next Usage" },
  p = { "TreeSitter Previous Usage" },
  q = { "Edit Register(Macro) q" },
  y = { "Yank to Clipboard" },
  Y = { "Yank File to Clipboard" },
  e = {
    name = "Explore Files",
    s = "Explore in Split",
    f = "Explore Fullscreen",
  },
  d = {
    name = "Distraction Free",
    f = { "Distraction Free" },
  },
  t = {
    name = "Telescope, Trouble, Table Mode, TreeSitter",
    m = "Table Mode",
    t = "Tabelize",
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
}, {
  prefix = "<leader>",
  mode = "n",
})
wk.register({
  n = {
    name = "Goto Next, Incremental Selection, List",
    n = { "Incremental Selection" },
    d = { "Goto Definition" },
    D = { "List Definitions" },
    O = { "List Definitions TOC" },
    ["0"] = { "List Lsp Workspace" },
    f = "Start Outer Function",
    i = {
      name = "Inner",
      c = { "Start Call" },
      f = { "Start Function" },
      F = { "End Function" },
      C = { "End Call" },
    },
    F = { "End Outer Function" },
    p = { "Start Inner Parameter" },
    c = { "Start Outer Call" },
    P = { "End Inner Parameter" },
    C = { "End Outer Call" },
  },
  p = {
    name = "Goto Previous",
    f = "Start Outer Function",
    i = {
      name = "Inner",
      c = { "Start Call" },
      f = { "Start Function" },
      F = { "End Function" },
      C = { "End Call" },
    },
    F = { "End Outer Function" },
    p = { "Start Inner Parameter" },
    c = { "Start Outer Call" },
    P = { "End Inner Parameter" },
    C = { "End Outer Call" },
  },
}, {
  prefix = "g",
  mode = "n",
})
