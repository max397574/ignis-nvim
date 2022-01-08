vim.bo.shiftwidth = 2
vim.o.conceallevel = 2
vim.bo.commentstring = "#%s"

local wk = require("which-key")

wk.register({
  t = {
    name = "+Tasks",
    d = { "Done" },
    u = { "Undone" },
    p = { "Pending" },
    i = { "Important" },
    h = { "On Hold" },
    c = { "Cancelled" },
    r = { "Recurring" },
  },
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
    name = "+Gtd",
    c = "Capture",
    e = "Edit",
    v = "Views",
  },
  n = {
    name = "+New Note",
    n = "New Note",
  },
  l = { "<cmd>Telescope neorg insert_link<CR>", "Insert Link" },
}, {
  prefix = "<leader>o",
  mode = "n",
})

vim.cmd([[source ~/.config/nvim_config/clipboard_neorg.vim]])