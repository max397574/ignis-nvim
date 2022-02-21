local extras = {}

extras.ts_theme_chooser = function()
    local themes = {
        {
            "custom_bottom_no_borders",
            "Custom Bottom Layout Strategy Without borders",
        },
        { "float_all_borders", "Float With All Borders" },
        { "float_prompt_border", "Float With Prompt Border Only" },
    }
    ---@type selection_popup
    local selection = require("selection_popup").new_selection(
        "telescope_theme_switcher",
        {}
    )
    selection:title("Telescope Theme Selector"):blank(2)
    for i, theme in ipairs(themes) do
        local f = require("selection_popup").create_flag(i)
        if not f then
            selection:text("Too much projects to display...")
            break
        end
        selection:flag(f, theme[2], {
            callback = function()
                require("custom.db").change_ts_layout(theme[1])
                selection:destroy()
            end,
        })
    end
end

return extras
