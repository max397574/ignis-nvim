local add_cmd = vim.api.nvim_create_user_command

add_cmd("ViewColors", function()
    require("colors.color_viewer").view_colors()
end, {
    desc = "View colors from `hl_themes`",
})

add_cmd("ReloadColors", function()
    require("colorscheme_switcher").new_scheme()
end, {
    desc = "Reload colors",
})

add_cmd("BigScreen", function()
    require("colorscheme_switcher").big_screen()
end, {
    desc = "Switch to bigger screen",
})

local function filetypes()
    return {
        "lua",
        "rust",
        "python",
        "c",
        "cpp",
        -- "java",
        "javascript",
        "typescrip",
        "plain",
        "norg",
    }
end

add_cmd("Tmp", function(args)
    require("ignis.extras").scratch_buf(args)
end, {
    nargs = "?",
    complete = filetypes,
})

add_cmd("CursorNodes", function()
    local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
    while node do
        dump(node:type())
        node = node:parent()
    end
end, {})

local function ShowLangTree(langtree, indent)
    local ts = vim.treesitter
    langtree = langtree or ts.get_parser()
    indent = indent or ""

    print(indent .. langtree:lang())
    for _, region in pairs(langtree:included_regions()) do
        if type(region[1]) == "table" then
            print(indent .. "  " .. vim.inspect(region))
        else
            print(indent .. "  " .. vim.inspect({ region[1]:range() }))
        end
    end
    for lang, child in pairs(langtree._children) do
        ShowLangTree(child, indent .. "  ")
    end
end

add_cmd("LangTree", function()
    ShowLangTree()
end, {})

add_cmd("ClearUndo", function()
    local old = vim.opt.undolevels
    vim.opt.undolevels = -1
    vim.cmd([[exe "normal a \<BS>\<Esc>"]])
    vim.opt.undolevels = old
end, {})
