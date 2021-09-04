local wk = require("which-key")

wk.register({
  f = {
    name = "Find",
    f = { "Files" },
    h = { "Help Tags" },
    b = { "Buffers" },
    o = { "OldFiles" },
    s = { "Lsp Symbols" },
    d = { "Directories (Zoxide)" },
    u = { "Under" },
  },
  l = {
    name = "LiveGrep, LuaDev",
    d = {
      name = "LuaDev",
      r = { "Run" },
      l = { "Run Line" },
    },
    g = "Live Grep",
  },
  tc = {
    name = "Telescope",
    t = {
      name = "TreeSitter, Todo",
      s = { "TreeSitter" },
      d = { "Todo" },
    },
    c = {
      name = "Command History",
      h = { "Command History" },
    },
    s = {
      name = "Search History, Symbols",
      h = { "Search History" },
      b = { "Symbols" },
    },
    g = {
      name = "Git",
      c = { "Commits" },
    },
    b = {
      name = "Builtin Pickers",
      i = { "Builtin Pickers" },
    },
  },
  m = {
    name = "Markdown",
    d = {
      name = "Markdown",
      h = {
        name = "Headings",
        ["1"] = { "Heading 1" },
        ["2"] = { "Heading 2" },
        ["3"] = { "Heading 3" },
      },
      pw = { "Preview in browser" },
      a = { "Add a link" },
      hr = { "Add horizontal rule" },
      l = {
        name = "List",
        u = { "Unordered list" },
        o = { "Ordered list" },
        t = { "Task list" },
      },
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
  h = {
    name = "Help Files",
    p = "Help Files",
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
  S = { "Substitute in whole File" },
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
  w = { "Write current file" },
  t = {
    name = "Telescope, Trouble, Table Mode, TreeSitter",
    m = "Table Mode",
    t = "Tabelize",
    s = {
      name = "TreeSitter",
      p = {
        name = "Playground Toggle",
        g = "Playground Toggle",
      },
    },
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
  u = {
    name = "UndoTree",
    t = "UndotreeToggle",
  },
  s = {
    name = "Substitue",
    s = { "Substitue on current line" },
    G = { "Substitue to the end of the file" },
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
