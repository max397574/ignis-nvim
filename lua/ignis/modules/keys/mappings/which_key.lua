local wk = require("which-key")
wk.register({
    e = {
        name = "+Explore",
        f = {
            function()
                require("lir.float").init()
            end,
            "Float",
        },
        l = {
            function()
                require("lir").init()
            end,
            "Lir",
        },
        s = { "<cmd>SymbolsOutline<CR>", "Symbols Outline" },
    },
    -- == Git ==
    g = {
        name = "+Git",
        s = {
            function()
                require("ignis.modules.files.telescope").git_status()
            end,
            "Status",
        },
        p = { "<cmd>Git push<CR>", "Push" },
        d = {
            function()
                require("ignis.modules.files.telescope").git_diff()
            end,
            "Diff",
        },
        l = { "<cmd>Telescope git_commits<CR>", "Log" },
        c = { "<cmd>Git commit<CR>", "Commit" },
        a = { "<cmd>Git add %<CR>", "Add" },
        y = { "Copy permalink to clipbard" },
        h = {
            name = "+Hunk",
            s = "Stage",
            u = "Undo stage",
            r = "Reset",
            R = "Reset buffer",
            p = "Preview",
            b = "Blame line",
        },
    },
    n = {
        name = "+Nvim-Tree",
        t = { "<cmd>NvimTreeToggle<CR>", "Toggle" },
        c = { "<cmd>NvimTreeClose<CR>", "Close" },
    },
    c = {
        name = "+Comment, Clipboard, Colors",
        b = {
            function()
                require("telescope").extensions.neoclip.default()
            end,
            "Clipboard",
        },
        c = { "Toggle comment line" },
    },
    -- == Colors ==
    C = {
        name = "+Colors",
        n = {
            function()
                require("ignis.modules.files.telescope").colorschemes()
            end,
            "NvChad Base 16 Picker",
        },
        s = {
            function()
                require("ignis.modules.files.telescope").highlights()
            end,
            "Search",
        },
    },
    r = "Run",
    J = {
        function()
            require("tsht").jump_nodes()
        end,
        "Jump Around",
    },
    -- == Markdown ==
    m = {
        name = "Markdown, Messages",
        d = {
            name = "Markdown",
            h = {
                name = "Heading, HR",
                ["1"] = { "<cmd>MdHeading1<CR>", "Heading 1" },
                ["2"] = { "<cmd>MdHeading2<CR>", "Heading 2" },
                ["3"] = { "<cmd>MdHeading3<CR>", "Heading 3" },
                ["r"] = { "<cmd>MdHorizontalRule<CR>", "Horizontal Rule" },
            },
            a = { "<cmd>MdLink<CR>", "Link" },
            l = {
                name = "List",
                u = { "<cmd>MdUnorderedList<CR>", "Unordered" },
                o = { "<cmd>MdOrderedList<CR>", "Ordered" },
                t = { "<cmd>MdTaskList<CR>", "Task" },
            },
        },
    },
    -- == Errors ==
    x = {
        name = "+Errors",
        x = { "<cmd>TroubleToggle<CR>", "Trouble" },
        w = { "<cmd>Trouble lsp_workspace_diagnostics<CR>", "Workspace Trouble" },
        d = { "<cmd>Trouble lsp_document_diagnostics<CR>", "Document Trouble" },
        t = { "<cmd>TodoTrouble<CR>", "Todo Trouble" },
        T = { "<cmd>TodoTelescope<CR>", "Todo Telescope" },
        l = { "<cmd>lopen<CR>", "Open Location List" },
        q = { "<cmd>copen<CR>", "Open Quickfix List" },
    },
    Q = { ":let @q='<c-r><c-r>q", "Edit Macro Q" },
    t = {
        name = "+Table, Tasks",
        m = { "<cmd>TableModeToggle<CR>", "Toggle Table Mode" },
        t = { "Tabelize" },
        v = { "<cmd>Neorg gtd views<CR>", "View Tasks" },
        c = { "<cmd>Neorg gtd capture<CR>", "Capture Taks" },
        e = { "<cmd>Neorg gtd edit<CR>", "Edit Task" },
    },
    l = {
        name = "+Last, Load",
        f = { "<cmd>so<CR>", "Load File" },
        s = {
            function()
                require("ignis.modules.files.telescope").grep_last_search()
            end,
            "Grep Last Search",
        },
    },
    -- == Help ==
    ["h"] = {
        name = "+Help, Harpoon",
        t = { "<cmd>Telescope builtin<CR>", "Telescope" },
        c = { "<cmd>Telescope commands<CR>", "Commands" },
        d = {
            function()
                if require("dynamic_help.extras.statusline").available() then
                    require("dynamic_help").float_help(vim.fn.expand("<cword>"))
                else
                    local help = vim.fn.input("Help Tag> ")
                    require("dynamic_help").float_help(help)
                end
            end,
            "Dynamic Help",
        },
        h = {
            function()
                require("ignis.modules.files.telescope").help_tags()
            end,
            "Help Pages",
        },
        m = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
        k = { "<cmd>Telescope keymaps<CR>", "Key Maps" },
        -- s = { "<cmd>Telescope highlights<CR>", "Search Highlight Groups" },
        l = {
            [[<cmd>TSHighlightCapturesUnderCursor<CR>]],
            "Highlight Groups at cursor",
        },
        o = { "<cmd>Telescope vim_options<CR>", "Options" },
        f = {
            function()
                require("float_help").float_help()
            end,
            "Help Files",
        },
        p = {
            name = "+Harpoon",
            a = {
                function()
                    require("harpoon.mark").add_file()
                end,
                "Add File",
            },
            m = {
                function()
                    require("harpoon.ui").toggle_quick_menu()
                end,
                "Menu",
            },
            n = {
                function()
                    require("harpoon.ui").nav_next()
                end,
                "Next File",
            },
            p = {
                function()
                    require("harpoon.ui").nav_prev()
                end,
                "Previous File",
            },
            t = { "<cmd>Telescope harpoon marks<CR>", "Telescope" },
        },
    },
    u = { "<cmd>UndotreeToggle<CR>", "UndoTree" },
    --== Buffers ==
    b = {
        name = "+Buffer",
        ["b"] = { "<cmd>e #<CR>", "Switch to Other Buffer" },
        ["p"] = { "<cmd>BufferLineCyclePrev<CR>", "Previous Buffer" },
        ["["] = { "<cmd>BufferLineCyclePrev<CR>", "Previous Buffer" },
        ["n"] = { "<cmd>BufferLineCycleNext<CR>", "Next Buffer" },
        ["]"] = { "<cmd>BufferLineCycleNext<CR>", "Next Buffer" },
        ["d"] = {
            "<cmd>lua require('bufferline').handle_close(vim.fn.bufnr('%'))<cr>",
            "Delete Buffer",
        },
        ["g"] = { "<cmd>BufferLinePick<CR>", "Goto Buffer" },
    },
    --== Search ==
    s = {
        name = "+Search",
        a = { "<cmd>Telescope autocommands<CR>", "Auto Commands" },
        g = {
            function()
                require("ignis.modules.files.telescope").find_string()
            end,
            "Grep",
        },
        b = {
            function()
                require("ignis.modules.files.telescope").curbuf()
            end,
            "Buffer",
        },
        d = { "<cmd>Telescope lsp_document_diagnostics<CR>", "Diagnostics" },
        B = { "<cmd>Telescope buffers<CR>", "Buffers" },
        e = {
            function()
                require("telescope.builtin").symbols({})
            end,
            "Emojis",
        },
        l = { "<cmd>Telescope luasnip<CR>", "Luasnip" },
        p = {
            function()
                require("ignis.modules.files.telescope").search_plugins()
            end,
            "Plugins",
        },
        y = {
            function()
                require("telescope").extensions.neoclip.default()
            end,
            "Yanks",
        },
        q = {
            function()
                require("telescope").extensions.macroscope.default()
            end,
            "Macros",
        },
        s = {
            function()
                require("telescope.builtin").lsp_workspace_symbols()
            end,
            "Goto Symbol",
        },
        S = {
            "<cmd>SymbolsOutline<CR>",
            "Symbols Outline",
        },
        h = { "<cmd>Telescope command_history<CR>", "Command History" },
        m = { "<cmd>Telescope marks<CR>", "Marks" },
        M = { "<cmd>messages<cr>", "Messages" },
        c = {
            function()
                require("ignis.modules.files.telescope").code_actions()
            end,
            "Code Actions",
        },
        t = { "<cmd>TodoTelescope<CR>", "Todo Comments" },
    },
    M = {
        name = "+Messages",
        v = {
            function()
                require("ignis.utils").view_messages()
            end,
            "View",
        },
        y = {
            function()
                vim.cmd([[let @0 = execute('messages')]])
            end,
            "Copy to Clipboard",
        },
        c = {
            function()
                vim.cmd([[let @+ = execute('messages')]])
            end,
            "Copy to Clipboard",
        },
    },
    --== Files ==
    F = {
        name = "+File",
        r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
        n = { "<cmd>enew<CR>", "New File" },
    },
    --== Find ==
    f = {
        name = "+Find",
        f = {
            function()
                require("ignis.modules.files.telescope").find_files()
            end,
            "File",
        },
        ["/"] = { "<cmd>Telescope grep_last_search<CR>", "Grep Last Search" },
        o = { "<cmd>Telescope oldfiles<CR>", "Oldfiles" },
        b = {
            "<cmd>Telescope buffers show_all_buffers=true<cr>",
            "Switch Buffer",
        },
        N = {
            function()
                require("ignis.modules.files.telescope").search_config()
            end,
            "Neovim Config",
        },
        h = {
            function()
                require("ignis.modules.files.telescope").help_tags()
            end,
            "Help Tags",
        },
        n = {
            function()
                require("ignis.modules.files.telescope").find_notes()
            end,
            "Notes",
        },
        B = { "<cmd>Telescope<CR>", "Builtin" },
        r = { "<cmd>Telescope registers<CR>", "Registers" },
        m = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
        a = { "<cmd>Telescope autocommands<CR>", "Autocommands" },
        O = { "<cmd>Telescope vim_options<CR>", "Vim Options" },
        c = { "<cmd>Telescope commands<CR>", "Commands" },
    },
    --== Insert ==
    i = {
        name = "+Insert",
        o = { "o<ESC>k", "Empty line below" },
        O = { "O<ESC>j", "Empty line above" },
        i = { "i <ESC>l", "Space before" },
        a = { "a <ESC>h", "Space after" },
        ["<CR>"] = { "i<CR><ESC>", "Linebreak at Cursor" },
    },
    a = {
        function()
            -- require("neogen").generate()
            require("neogen").generate({ snippet_engine = "luasnip" })
        end,
        "Generate Annotations",
    },
    ["."] = {
        function()
            require("ignis.modules.files.telescope").file_browser()
        end,
        "Browse Files",
    },
    ["/"] = {
        function()
            require("ignis.modules.files.telescope").find_string()
        end,
        "Live Grep",
    },
    [":"] = { "<cmd>Telescope commands<cr>", "Commands" },
    [","] = { "<cmd>Telescope buffers<cr>", "Buffers" },
    q = {
        name = "+Quickfix",
        n = { "<cmd>cnext<CR>", "Next Entry" },
        p = { "<cmd>cprevious<CR>", "Previous Entry" },
    },
    j = { ":m .+1<CR>==", "Move Current line down" },
    k = { ":m .-2<CR>==", "Move Current line up" },
    y = { '"+y', "Yank to Clipboard" },
    p = { '"0p', "Paste last yanked text" },
    P = { '"0P', "Paste last yanked text" },
    --== Window ==
    w = {
        name = "+Window",
        ["w"] = { "<C-W>p", "other-window" },
        ["d"] = { "<C-W>c", "delete-window" },
        ["-"] = { "<C-W>s", "split-window-below" },
        ["|"] = { "<C-W>v", "split-window-right" },
        ["2"] = { "<C-W>v", "layout-double-columns" },
        ["h"] = { "<C-W>h", "window-left" },
        ["j"] = { "<C-W>j", "window-below" },
        ["l"] = { "<C-W>l", "window-right" },
        ["k"] = { "<C-W>k", "window-up" },
        ["H"] = { "<C-W>5<", "expand-window-left" },
        ["J"] = { ":resize +5<CR>", "expand-window-below" },
        ["L"] = { "<C-W>5>", "expand-window-right" },
        ["K"] = { ":resize -5<CR>", "expand-window-up" },
        ["="] = { "<C-W>=", "balance-window" },
        ["s"] = { "<C-W>s", "split-window-below" },
        ["v"] = { "<C-W>v", "split-window-right" },
    },
    R = { "<cmd>Telescope reloader<CR>", "Reloader" },
    v = {
        name = "+View",
        l = {
            function()
                require("ignis.utils").LatexPreview()
            end,
            "Latex",
        },
        f = {
            function()
                require("nabla").popup()
            end,
            "Formulas",
        },
        m = {
            function()
                require("ignis.utils").MarkdownPreview()
            end,
            "Markdown",
        },
        -- c = {"<cmd>ColorizerAttachToBuffer<CR>", "Colorizer"},
        c = { "<cmd>PackerLoad nvim-colorizer.lua<CR>", "Colorizer" },
    },
}, {
    prefix = "<leader>",
    mode = "n",
})

wk.register({
    g = {
        name = "+Git",
        y = { "Yank permalink to selection" },
    },
}, {
    prefix = "<leader>",
    mode = "v",
})
