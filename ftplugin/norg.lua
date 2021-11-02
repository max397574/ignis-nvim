vim.bo.shiftwidth = 2
vim.o.conceallevel = 2

local wk = require("which-key")

wk.register({
  t = {
    name = "+Tasks",
    d = { "Done" },
    u = { "Undone" },
    p = { "Pending" },
  }
}, {
  prefix = "g",
  mode = "n",
})

wk.register({
  m = {
    name = "+Mode",
    n = "Norg",
    h = "Traverse Heading",
  },
  t = {
    "+Gtd",
    c = "Capture",
    e = "Edit",
    v = "Views"

  },
  n = {
    name = "+New Note",
    n = "New Note",
  },
}, {
  prefix = "<leader>o",
  mode = "n",
})
