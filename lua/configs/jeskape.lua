require("jeskape").setup({
  mappings = {
    ["c"] = {
      ["c"] = "<c-o>:lua require'utils'.append_comma()<CR>",
    },
    j = {
      k = "<esc>",
      j = "<esc>o",
      l = "<c-o>:lua print('test')<CR>",
    },
  },
})
