local wk = require("which-key")

require("which-key").setup({
    show_help = false,
    layout = {
        height = { max = 20 },
        spacing = 5, -- spacing between columns
    },
    window = {
        border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
        margin = { 1, 0, 1, 0 }, -- top right bottom left
        -- padding = { 1, 2, 1, 3 }, -- top right bottom left
        padding = { 0, 2, 0, 0 }, -- top right bottom left
        winblend = 0,
        -- winblend = 20,
    },
})

wk.register({
    b = {
        name = "+Block Comment",
        c = "Current Line",
    },
    n = {
        name = "Goto Next, Incremental Selection, List",
        n = { "Incremental Selection" },
        d = { "Goto Definition" },
        D = { "List Definitions" },
        O = { "List Definitions TOC" },
        ["0"] = { "List Lsp Workspace" },
        f = "Start Outer Function",
        u = "Next Usage",
        i = {
            name = "Inner",
            c = { "Start Call" },
            f = { "Start Function" },
            F = { "End Function" },
            C = { "End Call" },
        },
        F = { "End Outer Function" },
        p = { "Start Inner Parameter" },
        c = { "Start Outer Call" },
        P = { "End Inner Parameter" },
        C = { "End Outer Call" },
    },
    p = {
        name = "Goto Previous",
        f = "Start Outer Function",
        i = {
            name = "Inner",
            c = { "Start Call" },
            f = { "Start Function" },
            F = { "End Function" },
            C = { "End Call" },
        },
        F = { "End Outer Function" },
        p = { "Start Inner Parameter" },
        c = { "Start Outer Call" },
        P = { "End Inner Parameter" },
        C = { "End Outer Call" },
        u = { "Previous Usage" },
    },
}, {
    prefix = "g",
    mode = "n",
})
