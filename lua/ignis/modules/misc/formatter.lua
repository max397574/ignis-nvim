require("formatter").setup({
    filetype = {
        lua = {
            function()
                return {
                    exe = "stylua",
                    args = {
                        "--search-parent-directories",
                        "-",
                    },
                    stdin = true,
                }
            end,
        },
    },
})
local group = vim.api.nvim_create_augroup("Formatter", {})
vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function()
        -- vim.defer_fn(function()
        vim.cmd([[FormatWrite]])
        -- end, 10)
    end,
    group = group,
})
