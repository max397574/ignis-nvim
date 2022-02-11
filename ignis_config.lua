local config = {
    ignis = {
        colorscheme = function()
            local theme
            local time = os.date("*t")
            if time.hour < 7 or time.hour >= 21 then
                theme = "tokyodark"
            elseif time.hour < 8 or time.hour >= 19 then
                theme = "kanagawa"
            elseif time.hour < 10 or time.hour >= 17 then
                theme = "onedark"
            else
                theme = "everforest"
                -- theme = "tokyodark"
            end
            require("colors").init(theme)
            local old_scheme = require("custom.db").get_scheme()
            if theme ~= old_scheme then
                RELOAD("colorscheme_switcher")
                require("colorscheme_switcher").new_scheme()
                vim.defer_fn(function()
                    require("colorscheme_switcher").new_scheme()
                end, 1000)
            end
        end,
    },
}
return config
