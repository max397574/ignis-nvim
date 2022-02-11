vim.cmd(
    [[hi StalineSeparator guifg=]] .. vim.g.color_base_01 .. [[ guibg=none]]
)
vim.cmd([[hi StalineEmpty guibg=none guifg=]] .. vim.g.color_base_01)
require("staline").setup({
    sections = {
        left = {
            " ",
            "file_name",
            { "StalineSeparator", "left_sep" },
            -- "left_sep",
            { "StylineEmpty", " " },
            { "StalineSeparator", "right_sep" },
            -- "right_sep",
            "branch",
            { "StalineSeparator", "left_sep" },
            -- "left_sep",
            { "StylineEmpty", " " },
            "-lsp",
        },

        mid = {
            { "StalineSeparator", "right_sep" },
            -- "right_sep",
            "mode",
            { "StalineSeparator", "left_sep" },
            -- "left_sep",
        },
        right = {
            { "StalineSeparator", "right_sep" },
            -- "right_sep",
            "line_column",
            "word_count",
        },
    },

    defaults = {
        bg = vim.g.color_base_01,
        -- bg = "none",
        left_separator = "",
        -- left_separator = "",
        right_separator = "",
        -- right_separator = "",
        true_colors = true,
        line_column = "[%l:%c] %p%% ",
        -- font_active = "bold"
    },
    mode_colors = {
        n = vim.g.terminal_color_1,
        i = vim.g.terminal_color_2,
        ic = vim.g.terminal_color_3,
        c = vim.g.terminal_color_4,
        v = vim.g.terminal_color_5,
    },
})
