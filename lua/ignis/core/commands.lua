local add_cmd = vim.api.nvim_add_user_command

add_cmd("ViewColors", function()
    require("lua.colors.color_viewer").view_colors()
end, {})

add_cmd("ReloadColors", function()
    require("colorscheme_switcher").new_scheme()
end, {})

add_cmd("BigScreen", function()
    require("colorscheme_switcher").big_screen()
end, {})