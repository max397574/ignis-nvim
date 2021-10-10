vim.g.nvim_tree_ignore = { ".git", "node_modules" }
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_auto_ignore_ft = { "dashboard", "startify" }
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_lsp_diagnostics = 1
require("nvim-tree").setup {
  auto_open = 1,
  auto_close = 1,
  follow = 1,
  disable_netrw = 0,
}
require("nvim-tree.events").on_nvim_tree_ready(function()
  vim.cmd "NvimTreeRefresh"
end)
