-- vim.g.nvim_tree_ignore = { ".git", "node_modules" }
-- vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_auto_ignore_ft = {
    "dashboard",
    "startify",
    "startup",
}
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_git_hl = 1
-- vim.g.nvim_tree_lsp_diagnostics = 1
require("nvim-tree").setup({
    auto_open = 1,
    -- auto_close = 1,
    follow = 1,
    update_to_buf_dir = { enable = false },
    -- disable_netrw = 0,
})
