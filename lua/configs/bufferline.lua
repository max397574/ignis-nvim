local colors = require("colors").get(vim.g.colors_name)
require("bufferline").setup({
    highlights = {
        background = {
            guifg = colors.grey_fg,
            guibg = colors.black2,
        },

        -- buffers
        buffer_selected = {
            guifg = colors.white,
            guibg = colors.black,
            gui = "bold",
        },
        buffer_visible = {
            guifg = colors.light_grey,
            guibg = colors.black2,
        },

        -- for diagnostics = "nvim_lsp"
        error = {
            guifg = colors.light_grey,
            guibg = colors.black2,
        },
        error_diagnostic = {
            guifg = colors.light_grey,
            guibg = colors.black2,
        },

        -- close buttons
        close_button = {
            guifg = colors.light_grey,
            guibg = colors.black2,
        },
        close_button_visible = {
            guifg = colors.light_grey,
            guibg = colors.black2,
        },
        close_button_selected = {
            guifg = colors.red,
            guibg = colors.black,
        },
        fill = {
            guifg = colors.grey_fg,
            guibg = colors.black2,
        },
        indicator_selected = {
            guifg = colors.black,
            guibg = colors.black,
        },

        -- modified
        modified = {
            guifg = colors.red,
            guibg = colors.black2,
        },
        modified_visible = {
            guifg = colors.red,
            guibg = colors.black2,
        },
        modified_selected = {
            guifg = colors.green,
            guibg = colors.black,
        },

        -- separators
        separator = {
            guifg = colors.black2,
            guibg = colors.black2,
        },
        separator_visible = {
            guifg = colors.black2,
            guibg = colors.black2,
        },
        separator_selected = {
            guifg = colors.black2,
            guibg = colors.black2,
        },

        -- tabs
        tab = {
            guifg = colors.light_grey,
            guibg = colors.one_bg3,
        },
        tab_selected = {
            guifg = colors.black2,
            guibg = colors.nord_blue,
        },
        tab_close = {
            guifg = colors.red,
            guibg = colors.black,
        },
    },
    options = {
        diagnostics = "nvim_diagnostic",
        custom_areas = {
            right = function()
                local diagnostics = vim.diagnostic.get(0)
                local count = { 0, 0, 0, 0 }
                for _, diagnostic in ipairs(diagnostics) do
                    count[diagnostic.severity] = count[diagnostic.severity] + 1
                end
                local result = {}

                if count[1] ~= 0 then
                    table.insert(result, {
                        text = "  " .. count[1],
                        guifg = vim.g.terminal_color_9,
                        guibg = colors.black,
                    })
                end

                if count[2] ~= 0 then
                    table.insert(result, {
                        text = "  " .. count[2],
                        guifg = vim.g.terminal_color_3,
                        guibg = colors.black,
                    })
                end

                if count[4] ~= 0 then
                    table.insert(result, {
                        text = "  " .. count[4],
                        guifg = vim.g.terminal_color_4,
                        guibg = colors.black,
                    })
                end

                if count[3] ~= 0 then
                    table.insert(result, {
                        text = "  " .. count[3],
                        guifg = vim.g.terminal_color_6,
                        guibg = colors.black,
                    })
                end
                return result
            end,
        },
    },
})
