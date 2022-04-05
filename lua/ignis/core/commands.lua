local add_cmd = vim.api.nvim_add_user_command

add_cmd("ViewColors", function()
    require("colors.color_viewer").view_colors()
end, {})

add_cmd("ReloadColors", function()
    require("colorscheme_switcher").new_scheme()
end, {})

add_cmd("BigScreen", function()
    require("colorscheme_switcher").big_screen()
end, {})

add_cmd("Tmp", function()
    require("ignis.extras").scratch_buf()
end, {})

add_cmd("CursorNodes", function()
    local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
    while node do
        dump(node:type())
        node = node:parent()
    end
end, {})
