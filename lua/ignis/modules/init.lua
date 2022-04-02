-- Plugins
-- =======

-- somewhen plugins
-- https://github.com/yamatsum/nvim-nonicons
-- https://github.com/lervag/vimtex#configuration
-- https://github.com/latex-lsp/texlab

-- local packer_path = vim.fn.stdpath("data")
--     .. "/site/pack/packer/opt/packer.nvim"
--
-- if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
--     require("ignis.external.log").info(
--         "Bootstrapping packer.nvim, please wait ..."
--     )
--     vim.fn.system({
--         "git",
--         "clone",
--         "https://github.com/wbthomason/packer.nvim",
--         packer_path,
--     })
-- end

-- Load packer
vim.cmd([[ packadd packer.nvim ]])
local packer = require("packer")

-- packer options: https://github.com/wbthomason/packer.nvim#specifying-plugins
packer.startup({
    function(use)
        -- package manager
        use({ "wbthomason/packer.nvim", opt = true })

        use("lewis6991/impatient.nvim")

        use({
            "rebelot/heirline.nvim",
            config = function()
                require("ignis.modules.ui.heirline")
            end,
        })
        -- use({
        --     "tamton-aquib/staline.nvim",
        --     config = function()
        --         vim.cmd(
        --             [[hi StalineSeparator guifg=]]
        --                 .. vim.g.color_base_01
        --                 .. [[ guibg=none]]
        --         )
        --         vim.cmd(
        --             [[hi StalineEmpty guibg=none guifg=]] .. vim.g.color_base_01
        --         )
        --         require("staline").setup({
        --             sections = {
        --                 left = {
        --                     " ",
        --                     "file_name",
        --                     { "StalineSeparator", "left_sep" },
        --                     -- "left_sep",
        --                     { "StylineEmpty", " " },
        --                     { "StalineSeparator", "right_sep" },
        --                     -- "right_sep",
        --                     "branch",
        --                     { "StalineSeparator", "left_sep" },
        --                     -- "left_sep",
        --                     { "StylineEmpty", " " },
        --                     "-lsp",
        --                 },
        --
        --                 mid = {
        --                     { "StalineSeparator", "right_sep" },
        --                     -- "right_sep",
        --                     "mode",
        --                     { "StalineSeparator", "left_sep" },
        --                     -- "left_sep",
        --                 },
        --                 right = {
        --                     { "StalineSeparator", "right_sep" },
        --                     -- "right_sep",
        --                     "line_column",
        --                     "word_count",
        --                 },
        --             },
        --
        --             defaults = {
        --                 bg = vim.g.color_base_01,
        --                 -- bg = "none",
        --                 left_separator = "",
        --                 -- left_separator = "",
        --                 right_separator = "",
        --                 -- right_separator = "",
        --                 true_colors = true,
        --                 line_column = "[%l:%c] %p%% ",
        --                 -- font_active = "bold"
        --             },
        --             mode_colors = {
        --                 n = vim.g.terminal_color_1,
        --                 i = vim.g.terminal_color_2,
        --                 ic = vim.g.terminal_color_3,
        --                 c = vim.g.terminal_color_4,
        --                 v = vim.g.terminal_color_5,
        --             },
        --         })
        --     end,
        -- })

        use({ "shift-d/wordle.nvim", command = "Wordle" })

        use({
            "akinsho/bufferline.nvim",
            -- can be lazyloaded because disabled when opening only one file
            event = "ColorScheme",
            config = function()
                require("ignis.modules.ui.bufferline")
            end,
        })

        use({ "nvim-lua/plenary.nvim", module = "plenary" })

        -- use({
        --     "rcarriga/nvim-notify",
        --     config = function()
        -- vim.notify = require("notify")
        --     end,
        -- })

        -- create directories if they don't exist
        use({
            "jghauser/mkdir.nvim",
            config = function()
                require("mkdir")
            end,
            event = "BufWritePre",
        })

        use({ "VonHeikemen/searchbox.nvim", opt = true })
        use({ "elihunter173/dirbuf.nvim", opt = true })
        use({ "mizlan/iswap.nvim", opt = true })
        use({ "lervag/vimtex", config = function() end, filetype = "tex" })
        use({ "~/neovim_plugins/nabla.nvim", filetype = "tex" })
        -- use({ "~/neovim_plugins/lambda.nvim", filetype = "tex" })

        use({
            "~/neovim_plugins/selection_popup",
            module = "selection_popup",
        })

        use({
            "~/neovim_plugins/nvim-base16.lua",
        })
        use({
            "tami5/sqlite.lua",
            module = "sqlite",
            branch = "new/index_access",
        })

        use({
            "Krafi2/jeskape.nvim",
            event = "InsertEnter",
            config = function()
                require("jeskape").setup({
                    mappings = {
                        [","] = {
                            [","] = "<cmd>lua require'ignis.utils'.append_comma()<CR>",
                        },
                        j = {
                            k = "<esc>",
                            [","] = "<cmd>lua require'ignis.utils'.append_comma()<CR><esc>o",
                            j = "<esc>o",
                        },
                    },
                })
            end,
        })

        use({ "~/float_help.nvim/", module = "float_help" })

        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function()
                require("ignis.modules.misc.treesitter")
            end,
            requires = {
                "nvim-treesitter/nvim-treesitter-refactor",
                "nvim-treesitter/nvim-treesitter-textobjects",
                "p00f/nvim-ts-rainbow",
                {
                    "romgrk/nvim-treesitter-context",
                    event = "InsertEnter",
                    config = function()
                        vim.cmd([[hi! link TreesitterContext Visual]])
                        require("treesitter-context.config").setup({
                            enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                            patterns = {
                                default = {
                                    "class",
                                    "function",
                                    "method",
                                    "for",
                                    "field",
                                    "if",
                                },
                            },
                        })
                    end,
                },
            },
        })

        use({
            "~/neovim_plugins/nvim-treehopper/",
            module = "tsht",
            after = "nvim-treesitter",
        })

        use({ "RRethy/nvim-treesitter-endwise", event = "InsertEnter" })

        use({
            "nvim-treesitter/playground",
            cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
        })

        use({ "ggandor/lightspeed.nvim", keys = { "S", "s" } })

        use({
            "lukas-reineke/indent-blankline.nvim",
            -- opt = true,
            config = function()
                require("ignis.modules.ui.blankline").setup()
            end,
        })

        -- floating terminal
        use({
            "akinsho/toggleterm.nvim",
            keys = { "<c-t>", "<leader>r", "<c-g>" },
            config = function()
                require("ignis.modules.misc.toggleterm")
            end,
        })

        use({ "tpope/vim-repeat" })

        use({
            "lewis6991/gitsigns.nvim",
            event = "InsertEnter",
            opt = true,
            config = function()
                require("ignis.modules.ui.gitsigns")
            end,
        })

        --
        -- -- easily comment out code
        use({
            "numToStr/Comment.nvim",
            keys = { "<leader>c", "gb" },
            config = function()
                require("comment").setup({
                    toggler = {
                        ---line-comment keymap
                        line = "<leader>cc",
                        ---block-comment keymap
                        block = "gbc",
                    },

                    ---LHS of operator-pending mappings in NORMAL + VISUAL mode
                    opleader = {
                        ---line-comment keymap
                        line = "<leader>c",
                        ---block-comment keymap
                        block = "gb",
                    },
                    mappings = {
                        extended = true,
                    },
                })
            end,
        })

        -- easier use of f/F and t/T
        -- use({ "rhysd/clever-f.vim", keys = "f" })

        -- easily create md tables
        use({
            "dhruvasagar/vim-table-mode",
            cmd = "TableModeToggle",
        })

        use({ "jbyuki/venn.nvim", command = "VBox" })

        -- display keybindings help
        -- use my fork because of vim.keymap.set
        use({
            opt = true,
            "~/neovim_plugins/which-key.nvim",
            after = "nvim-treesitter",
            config = function()
                require("which-key").setup({})
                require("ignis.modules.keys.which_key")
                require("ignis.modules.keys.mappings")
            end,
        })

        use({
            "bfredl/nvim-luadev",
            cmd = "Luadev",
        })

        -- More Helpfiles
        -- luv
        use("nanotee/luv-vimdocs")
        -- builtin lua functions
        use("milisims/nvim-luaref")

        -- make only certain arreas or code accessible
        use({
            "chrisbra/NrrwRgn",
            cmd = { "NarrowRegion", "NarrowWindow" },
        })

        use({
            "~/neovim_plugins/pomodoro.nvim/",
            config = function()
                require("tomato").setup()
            end,
        })

        use({
            -- "nvim-neorg/neorg",
            "~/neovim_plugins/neorg",
            -- branch = "indentation-v3",
            config = function()
                require("ignis.modules.misc.neorg")
            end,

            requires = {
                "~/neovim_plugins/neorg-telescope/",
                "~/neovim_plugins/neorg-zettelkasten/",
            },
        })

        use({
            "~/neovim_plugins/dynamic_help/",
        })

        use({
            "ruifm/gitlinker.nvim",
            keys = "<leader>gy",
            config = function()
                require("gitlinker").setup()
            end,
        })

        use({
            "folke/zen-mode.nvim",
            config = function()
                require("ignis.modules.ui.zen_mode")
            end,
            cmd = "ZenMode",
            requires = {
                opt = true,
                "folke/twilight.nvim",
                config = function()
                    require("twilight").setup({
                        dimming = {
                            alpha = 0.25,
                            color = { "Normal", vim.g.color_base_01 },
                            inactive = false,
                        },
                        context = 10,
                        treesitter = true,
                        expand = {
                            "function",
                            "method",
                            "table",
                            "if_statement",
                        },
                        exclude = {},
                    })
                end,
            },
        })

        -- highlight and search todo comments
        use({
            "folke/todo-comments.nvim",
            cmd = { "TodoTelescope", "TodoTrouble", "TodoQuickFix" },
            config = [[ require("todo-comments").setup({}) ]],
        })

        use({
            "kyazdani42/nvim-tree.lua",
            cmd = { "NvimTreeToggle", "NvimTreeClose" },
            config = function()
                vim.g.nvim_tree_ignore = { ".git", "node_modules" }
                vim.g.nvim_tree_gitignore = 1
                vim.g.nvim_tree_auto_ignore_ft = {
                    "dashboard",
                    "startify",
                    "startup",
                }
                vim.g.nvim_tree_indent_markers = 1
                vim.g.nvim_tree_git_hl = 1
                vim.g.nvim_tree_lsp_diagnostics = 1
                require("nvim-tree").setup({
                    auto_open = 1,
                    auto_close = 1,
                    follow = 1,
                    -- disable_netrw = 0,
                })
            end,
        })

        -- change,add and delete surroundings
        use({
            "~/neovim_plugins/surround.nvim",
            module = "surround",
            config = function()
                require("surround").setup({
                    mappings_style = "surround",
                    map_insert_mode = false,
                    pairs = {
                        nestable = {
                            { "(", ")" },
                            { "[", "]" },
                            { "{", "}" },
                            { "/", "/" },
                            {
                                "*",
                                "*",
                            },
                        },
                        linear = { { "'", "'" }, { "`", "`" }, { '"', '"' } },
                    },
                })
            end,
        })

        -- -- display last undos
        use({ "mbbill/undotree", cmd = "UndotreeToggle" })

        -- -- more icons
        use("ryanoasis/vim-devicons")

        -- -- even more icons
        use({
            "kyazdani42/nvim-web-devicons",
        })

        use({
            "jose-elias-alvarez/null-ls.nvim",
        })

        use({
            "simrat39/symbols-outline.nvim",
            cmd = "SymbolsOutline",
            config = function()
                vim.cmd([[highlight FocusedSymbol gui=italic guifg=#56b6c2 ]])
            end,
        })

        use({
            "ThePrimeagen/harpoon",
            keys = { "<leader>hp" },
            config = function()
                require("telescope").load_extension("harpoon")
            end,
        })
        use({
            "~/neovim_plugins/filetype.nvim",
        })

        -- a file explorer
        use({
            "nvim-telescope/telescope.nvim",
            cmd = "Telescope",
            module = { "telescope", "ignis.modules.files.telescope" },
            config = function()
                require("ignis.modules.files.telescope")
            end,
        })
        use({ "nvim-lua/popup.nvim", after = "telescope.nvim" })
        use({
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
            after = "telescope.nvim",
        })
        use({ "nvim-telescope/telescope-symbols.nvim", after = "telescope.nvim" })
        use({
            "nvim-telescope/telescope-file-browser.nvim",
            after = "telescope.nvim",
        })

        use({
            "AckslD/nvim-neoclip.lua",
            config = function()
                require("neoclip").setup({
                    enable_persistent_history = true,
                    default_register_macros = "q",
                    enable_macro_history = true,
                    on_replay = {
                        set_reg = true,
                    },
                })
            end,
        })

        -- use({
        --     "~/startup.nvim",
        --     config = function()
        --         require("startup").setup(
        --             require("ignis.modules.ui.startup_nvim")
        --         )
        --     end,
        --     requires = {
        --         "~/startup_themes/",
        --     },
        -- })

        -- use({ "~/neovim_plugins/colorschemes/" })

        use({
            "~/neovim_plugins/colorscheme_switcher/",
            module = { "colorscheme_switcher" },
        })

        -- colorize color codes
        use({
            "xiyaowong/nvim-colorizer.lua",
            keys = { "<leader>vc" },
            config = function()
                require("colorizer").setup({
                    "*",
                }, {
                    mode = "foreground",
                    hsl_fn = true,
                })
                vim.cmd([[ColorizerAttachToBuffer]])
            end,
        })

        use({ "max397574/hangman.nvim", command = "Hangman" })

        -- completition
        use({
            -- "~/neovim_plugins/nvim-cmp",
            -- "iron-e/nvim-cmp",
            "hrsh7th/nvim-cmp",
            -- branch = "feat/completion-menu-borders",
            branch = "dev",
            commit = "9b202effd71f84d8585439438ec931a5342f7941",
            event = { "InsertEnter" },
            config = function()
                require("ignis.modules.completion.cmp")
            end,
        })

        use({
            "L3MON4D3/LuaSnip",
            requires = {
                {
                    "~/neovim_plugins/friendly-snippets",
                    after = "LuaSnip",
                    event = "InsertEnter",
                },
            },
            -- event = "InsertEnter",
            module = "luasnip",
            -- after = "nvim-cmp",
            -- config = function()
            --     require("ignis.modules.completion.snippets")
            -- end,
        })
        use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })
        use({ "hrsh7th/cmp-emoji", after = "nvim-cmp" })
        use({ "max397574/cmp-greek", after = "nvim-cmp" })
        use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
        use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
        use({ "kdheepak/cmp-latex-symbols", after = "nvim-cmp" })
        use({ "hrsh7th/cmp-calc", after = "nvim-cmp" })
        use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
        use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
        use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })
        use({ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" })

        use({
            "gelguy/wilder.nvim",
            event = "CmdLineEnter",
            requires = {
                { "romgrk/fzy-lua-native", opt = true, after = "wilder.nvim" },
            },
            run = ":UpdateRemotePlugins",
            config = function()
                require("ignis.modules.completion.wilder")
            end,
        })

        use({
            "danymat/neogen",
            module = { "neogen" },
            config = function()
                require("neogen").setup({
                    snippet_engine = "luasnip",
                    enabled = true,
                })
            end,
        })

        -- autopairs
        use({
            "windwp/nvim-autopairs",
            after = "nvim-cmp",
            config = function()
                require("ignis.modules.completion.autopairs")
            end,
        })

        use({ "lewis6991/hover.nvim", opt = true })

        -- config for lsp
        use({
            "neovim/nvim-lspconfig",
            opt = true,
            requires = {
                { "folke/lua-dev.nvim", module = "lua-dev", opt = true },
            },
            config = function()
                require("ignis.modules.lsp")
            end,
        })
        use({
            "simrat39/rust-tools.nvim",
            module = "rust-tools",
            filetype = "rust",
            requires = {
                { "mfussenegger/nvim-dap", after = "rust-tools.nvim" },
                {
                    "rcarriga/nvim-dap-ui",
                    config = function()
                        require("dapui").setup({
                            mappings = { toggle = "<tab>" },
                        })
                    end,
                    after = "rust-tools.nvim",
                },
            },
        })
        use({
            "p00f/clangd_extensions.nvim",
            module = "clangd_extensions",
            filetype = { "cpp", "c" },
        })

        -- show where lsp code action as available
        use({
            "kosayoda/nvim-lightbulb",
            after = "nvim-lspconfig",
            config = function()
                vim.cmd(
                    [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
                )
            end,
        })

        -- some functions to refactor
        use({
            "ThePrimeagen/refactoring.nvim",
            config = function()
                require("configs.refactor")
            end,
            keys = { "<leader>R" },
        })

        -- list for lsp,quickfix,telescope etc
        use({
            "folke/trouble.nvim",
            cmd = { "Trouble", "TroubleToggle" },
            config = function()
                require("trouble").setup({
                    auto_preview = false,
                })
            end,
        })
        use({ "~/neovim_plugins/plugnplay/plugnplay.nvim/" })
    end,
    config = {
        -- compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
        profile = {
            enable = true,
            threshold = 0.0001,
        },
        max_jobs = 10,
        display = {
            title = "Packer",
            done_sym = "",
            error_syn = "×",
            keybindings = {
                toggle_info = "<TAB>",
            },
        },
    },
})
