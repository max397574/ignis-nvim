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
