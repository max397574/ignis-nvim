require("conmenu").setup()
function ShowHarpoonMenu()
    local marks = require("harpoon").get_mark_config().marks
    local marksCount = table.maxn(marks)
    -- Default entries, that are always shown
    local menuEntries = {
        { "Show all", ':lua require("harpoon.ui").toggle_quick_menu()' },
        { "Add current File", ':lua require("harpoon.mark").add_file()' },
    }
    -- Add divider if we have marks
    if marksCount > 0 then
        table.insert(menuEntries, {
            "────────────────────────────",
        })
    end

    -- Prepare navigation marks
    for i, v in ipairs(marks) do
        -- Get just the filename from entire path
        local file = string.match("/" .. v.filename, ".*/(.*)$")
        -- Add menu entry
        table.insert(menuEntries, {
            i .. " " .. file,
            "lua require('harpoon.ui').nav_file(" .. i .. ")",
        })
    end
    -- Show menu
    require("conmenu").openCustom(menuEntries)
end

vim.g["conmenu#available_bindings"] = "1234567890qwertyuiopasdfghlzxcvbnm"

vim.g["conmenu#default_menu"] = {
    {
        "﩯Buffer",
        {
            { "Switch to Other Buffer", "<cmd>e #<CR>" },
            { "Previous Buffer", "<cmd>BufferLineCyclePrev<CR>" },
            { "Previous Buffer", "<cmd>BufferLineCyclePrev<CR>" },
            { "Next Buffer", "<cmd>BufferLineCycleNext<CR>" },
        },
    },
}
