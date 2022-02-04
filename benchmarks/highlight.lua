require("plenary/benchmark")("vim.api.nvim_set_hl vs vim.cmd", {
    warmup = 220,
    runs = 500,
    fun = {
        {
            "nvim_set_hl",
            function()
                vim.api.nvim_set_hl(
                    0,
                    "Normal",
                    { fg = "#1e222a", bg = "#1e222a" }
                )
            end,
        },
        {
            "vim.cmd",
            function()
                vim.cmd([[highlight! Normal guifg=#1e222a, guibg=#1e222a]])
            end,
        },
    },
})
