local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
local colors = require("colors").get()

parser_configs.norg = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg",
        files = { "src/parser.c", "src/scanner.cc" },
        branch = "main",
        -- branch = "dev",
    },
}

parser_configs.norg_table = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
        files = { "src/parser.c" },
        branch = "main",
    },
}

parser_configs.norg_meta = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
        branch = "main",
        files = { "src/parser.c" },
    },
}

parser_configs.luap = {
    install_info = {
        url = "https://github.com/vhyrro/tree-sitter-luap",
        files = { "src/parser.c" },
        branch = "main",
        -- branch = "attached-modifiers",
    },
}

require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "markdown",
        "rust",
        "lua",
        "python",
        "cpp",
        "c",
        "vim",
        "latex",
        "java",
        "help",
        "vim",
        "norg",
        "comment",
        "norg_meta",
        "norg_table",
    },
    highlight = {
        enable = true,
        -- custom_captures = {
        --     ["require_call"] = "RequireCall",
        --     ["function_definition"] = "FunctionDefinition",
        -- },
    },
    incremental_selection = {
        enable = true,

        keymaps = {
            init_selection = "gnn",
            node_incremental = "gnn",
            scope_incremental = "gns",
            node_decremental = "gnp",
        },
    },
    textsubjects = {
        enable = true,
        keymaps = {
            [","] = "textsubjects-smart",
        },
    },
    refactor = {
        highlight_definitions = { enable = false },
        highlight_current_scope = { enable = false },
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "grr",
            },
        },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition = "gnd",
                list_definitions = "gnD",
                list_definitions_toc = "gO",
                goto_next_usage = "gnu",
                goto_previous_usage = "gpu",
            },
        },
    },
    playground = { enable = true, updatetime = 10, persist_queries = true },
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold", "CursorMoved" },
    },
    endwise = { enable = true },
    indent = { enable = true, disable = { "python" } },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 1000,
        colors = {
            colors.blue,
            colors.red,
            colors.green,
            colors.orange,
            colors.cyan,
            colors.pink,
        },
    },
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["il"] = "@loop.inner",
                ["al"] = "@loop.outer",
                ["icd"] = "@conditional.inner",
                ["acd"] = "@conditional.outer",
                ["acm"] = "@comment.outer",
                ["ast"] = "@statement.outer",
                ["isc"] = "@scopename.inner",
                ["iB"] = "@block.inner",
                ["aB"] = "@block.outer",
                ["p"] = "@parameter.inner",
            },
        },

        move = {
            enable = true,
            set_jumps = true, -- Whether to set jumps in the jumplist
            goto_next_start = {
                ["gnf"] = "@function.outer",
                ["gnif"] = "@function.inner",
                ["gnp"] = "@parameter.inner",
                ["gnc"] = "@call.outer",
                ["gnic"] = "@call.inner",
            },
            goto_next_end = {
                ["gnF"] = "@function.outer",
                ["gniF"] = "@function.inner",
                ["gnP"] = "@parameter.inner",
                ["gnC"] = "@call.outer",
                ["gniC"] = "@call.inner",
            },
            goto_previous_start = {
                ["gpf"] = "@function.outer",
                ["gpif"] = "@function.inner",
                ["gpp"] = "@parameter.inner",
                ["gpc"] = "@call.outer",
                ["gpic"] = "@call.inner",
            },
            goto_previous_end = {
                ["gpF"] = "@function.outer",
                ["gpiF"] = "@function.inner",
                ["gpP"] = "@parameter.inner",
                ["gpC"] = "@call.outer",
                ["gpiC"] = "@call.inner",
            },
        },
    },
})

require("nvim-treesitter.highlight").set_custom_captures({
    -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
    -- ["foo.bar"] = "Identifier",
    ["require_call"] = "RequireCall",
    ["function_definition"] = "FunctionDefinition",
    ["quantifier"] = "Special",
    ["utils"] = "Function",
})
