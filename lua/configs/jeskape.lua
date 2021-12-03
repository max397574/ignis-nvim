require("jeskape").setup({
  mappings = {
    ["c"] = {
      ["c"] = "<cmd>lua require'utils'.append_comma()<CR>",
    },
    j = {
      k = "<esc>",
      j = "<esc>o",
    },
  },
})
