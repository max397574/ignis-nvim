local wk = require("which-key")

require("which-key").setup({
  window = {
    border = "none", -- none, single, double, shadow
    margin = { 1, 0, 1, 0 },
    winblend = 20,
  },
})

wk.register({
  c = {
    name = "+Comment",
    c = "Current line",
    o = "Enter insert below",
    O = "Enter insert above",
    A = "Enter insert eol",
  },
  b = {
    name = "+Block Comment",
    c = "Current Line",
  },
  n = {
    name = "Goto Next, Incremental Selection, List",
    n = { "Incremental Selection" },
    d = { "Goto Definition" },
    D = { "List Definitions" },
    O = { "List Definitions TOC" },
    ["0"] = { "List Lsp Workspace" },
    f = "Start Outer Function",
    u = "Next Usage",
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
    u = { "Previous Usage" },
  },
}, {
  prefix = "g",
  mode = "n",
})
