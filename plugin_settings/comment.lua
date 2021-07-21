vim.api.nvim_exec(
[[
call plug#begin('~/.vim/plugged')
Plug 'terrortylor/nvim-comment'
call plug#end()
]],
true)

require('nvim_comment').setup({
  -- Linters prefer comment and line to have a space in between markers
  marker_padding = true,
  -- should comment out empty or whitespace only lines
  comment_empty = false,
  -- Should key mappings be created
  create_mappings = true,
  -- Normal mode mapping left hand side
  line_mapping = "dont use this",
  -- Visual/Operator mapping left hand side
  operator_mapping = "<leader>cc"
})
