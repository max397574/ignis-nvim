local colors = require("colors").get(
    vim.g.colors_name or require("ignis.utils").get_colorscheme()
)
local groups = require("bufferline.groups")

require("bufferline").setup({
    highlights = {
        background = {
            guifg = colors.grey_fg,
            guibg = colors.black2,
            -- guibg = colors.black,
        },

        -- buffers
        buffer_selected = {
            guifg = colors.white,
            guibg = colors.grey_fg,
            -- guibg = colors.black,
            gui = "bold,italic",
        },
        duplicate_selected = {
            guifg = colors.white,
            -- guibg = colors.black,
            guibg = colors.grey_fg,
            gui = "bold,italic",
        },
        duplicate_visible = {
            guifg = colors.white,
            guibg = colors.black2,
            gui = "bold,italic",
        },
        buffer_visible = {
            guifg = colors.white,
            -- guibg = colors.black2,
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
            guibg = colors.grey_fg,
        },
        fill = {
            guifg = colors.grey_fg,
            guibg = colors.darker_black,
        },
        indicator_selected = {
            guifg = colors.black2,
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
            guibg = colors.grey_fg,
        },

        -- separators
        separator = {
            -- guifg = colors.green,
            -- guifg = "",
            guifg = colors.darker_black,
            guibg = colors.black2,
        },
        separator_visible = {
            -- guifg = colors.green,
            guifg = colors.darker_black,
            guibg = colors.black2,
        },
        separator_selected = {
            -- guifg = colors.green,
            guifg = colors.darker_black,
            guibg = colors.grey_fg,
        },

        -- tabs
        tab = {
            guifg = colors.light_grey,
            guibg = colors.one_bg3,
        },
        duplicate = {
            guifg = colors.light_grey,
            guibg = colors.black2,
        },
        tab_selected = {
            guifg = colors.black2,
            guibg = colors.nord_blue,
        },
        tab_close = {
            guifg = colors.red,
            guibg = colors.darker_black,
        },
    },
    options = {
        separator_style = "slant",
        -- separator_style = "thick",
        -- separator_style = { "", "" },
        mode = "buffers",
        diagnostics = "nvim_diagnostic",
        always_show_bufferline = false,
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
                        guibg = colors.darker_black,
                    })
                end

                if count[2] ~= 0 then
                    table.insert(result, {
                        text = "  " .. count[2],
                        guifg = vim.g.terminal_color_3,
                        guibg = colors.darker_black,
                    })
                end

                if count[4] ~= 0 then
                    table.insert(result, {
                        text = "  " .. count[4],
                        guifg = vim.g.terminal_color_4,
                        guibg = colors.darker_black,
                    })
                end

                if count[3] ~= 0 then
                    table.insert(result, {
                        text = "  " .. count[3],
                        guifg = vim.g.terminal_color_6,
                        guibg = colors.darker_black,
                    })
                end
                return result
            end,
        },
        groups = {
            options = {
                toggle_hidden_on_enter = true,
            },
            items = {
                groups.builtin.ungrouped,
                {
                    highlight = { guisp = colors.pink, gui = "underline" },
                    name = "tests",
                    icon = "",
                    matcher = function(buf)
                        return buf.filename:match("_spec")
                            or buf.filename:match("test")
                    end,
                },
                {
                    highlight = {
                        guisp = colors.cyan,
                        gui = "underline",
                        guibg = colors.black2,
                    },
                    name = "docs",
                    matcher = function(buf)
                        for _, ext in ipairs({ "md", "txt", "org", "norg", "wiki" }) do
                            if ext == vim.fn.fnamemodify(buf.path, ":e") then
                                return true
                            end
                        end
                    end,
                },
            },
        },
    },
})
