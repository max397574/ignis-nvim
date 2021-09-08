local wk = require "which-key"

wk.register({
  n = { "TreeSitter Next Usage" },
  p = { "TreeSitter Previous Usage" },
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
