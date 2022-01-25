-- Plugins
-- =======
-- packer options: https://github.com/wbthomason/packer.nvim#specifying-plugins
require("packer").startup({
    function(use)
        -- package manager
        use("wbthomason/packer.nvim")

        use("lewis6991/impatient.nvim")

        use("nvim-lua/plenary.nvim")

        -- create directories if they don't exist
        use({
            "jghauser/mkdir.nvim",
            config = function()
                require("mkdir")
            end,
            event = "BufWritePre",
        })

        -- use("~/selection_popup")

        use({
            "nvchad/nvim-base16.lua",
        })
        use({ "tami5/sqlite.lua", module = "sqlite" })
        --
        -- -- better escape
        -- use({
        --     "~/neovim_plugins/betterEscape.nvim",
        --     event = { "InsertEnter" },
        --     config = function()
        --         require("better_escape").setup({
        --             mapping = { "yy" },
        --             keys = "<ESC>",
        --             timeout = 200,
        --         })
        --     end,
        -- })

        -- faster filetype detection
        use({
            "~/neovim_plugins/filetype.nvim",
            opt = true,
        })

        -- colorscheme
        -- use({ "sainnhe/gruvbox-material" })
        -- use({ "NTBBloodbath/doombox.nvim" })
        -- use({ "NTBBloodbath/doom-one.nvim" })
        -- use("rebelot/kanagawa.nvim")
        -- use("wuelnerdotexe/vim-enfocado")
        use({ "~/neovim_plugins/colorschemes", opt = true })
        -- use { "~/onedarker.nvim" }
        -- use { "tiagovla/tokyodark.nvim" }
        -- use({
        --   "folke/tokyonight.nvim",
        --   config = function()
        --     require("configs.theme")
        --     local _time = os.date("*t")
        --     if _time.hour < 9 then
        --       vim.g.tokyonight_style = "night"
        --     end
        --   end,
        -- })

        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function()
                require("configs.treesitter")
            end,
            requires = {
                "nvim-treesitter/nvim-treesitter-refactor",
                "nvim-treesitter/nvim-treesitter-textobjects",
                {
                    "~/neovim_plugins/nvim-treehopper/",
                    module = "tsht",
                },
                {
                    "romgrk/nvim-treesitter-context",
                    event = "InsertEnter",
                    config = function()
                        require("treesitter-context.config").setup({
                            enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                        })
                    end,
                },
            },
        })

        use({
            "nvim-treesitter/playground",
            cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
        })

        use({ "ggandor/lightspeed.nvim", opt = true })

        use({
            "lukas-reineke/indent-blankline.nvim",
            opt = true,
            setup = function()
                require("configs.blankline").setup()
            end,
        })

        -- floating terminal
        use({
            "akinsho/toggleterm.nvim",
            keys = { "<c-t>", "<leader>r", "<c-g>" },
            config = function()
                require("configs.toggleterm")
            end,
        })

        use({
            "Krafi2/jeskape.nvim",
            event = "InsertEnter",
            config = function()
                require("jeskape").setup({
                    mappings = {
                        [","] = {
                            [","] = "<cmd>lua require'utils'.append_comma()<CR>",
                        },
                        j = {
                            k = "<esc>",
                            [","] = "<cmd>lua require'utils'.append_comma()<CR><esc>o",
                            j = "<esc>o",
                        },
                    },
                })
            end,
        })

        -- bufferline
        use({
            "akinsho/bufferline.nvim",
            opt = true,
            config = [[ require("configs.bufferline") ]],
        })

        -- statusline
        use({
            "~/neovim_plugins/staline.nvim/",
            opt = true,
            config = function()
                vim.cmd(
                    [[hi StalineSeparator guifg=]]
                        .. vim.g.color_base_01
                        .. [[ guibg=none]]
                )
                vim.cmd(
                    [[hi StalineEmpty guibg=none guifg=]] .. vim.g.color_base_01
                )
                require("staline").setup({
                    sections = {
                        left = {
                            " ",
                            "file_name",
                            { "StalineSeparator", "left_sep" },
                            -- "left_sep",
                            { "StylineEmpty", " " },
                            { "StalineSeparator", "right_sep" },
                            -- "right_sep",
                            "branch",
                            { "StalineSeparator", "left_sep" },
                            -- "left_sep",
                            { "StylineEmpty", " " },
                            "-lsp",
                        },

                        mid = {
                            { "StalineSeparator", "right_sep" },
                            -- "right_sep",
                            "mode",
                            { "StalineSeparator", "left_sep" },
                            -- "left_sep",
                        },
                        right = {
                            { "StalineSeparator", "right_sep" },
                            -- "right_sep",
                            "line_column",
                        },
                    },

                    defaults = {
                        bg = vim.g.color_base_01,
                        -- bg = "none",
                        left_separator = "",
                        -- left_separator = "",
                        right_separator = "",
                        -- right_separator = "",
                        true_colors = true,
                        line_column = "[%l:%c] %p%% ",
                        -- font_active = "bold"
                    },
                    mode_colors = {
                        n = vim.g.terminal_color_1,
                        i = vim.g.terminal_color_2,
                        ic = vim.g.terminal_color_3,
                        c = vim.g.terminal_color_4,
                        v = vim.g.terminal_color_5,
                    },
                })
            end,
        })

        use({
            "lewis6991/gitsigns.nvim",
            event = "InsertEnter",
            opt = true,
            config = [[ require("configs.gitsigns") ]],
        })

        -- -- some functions to help with markdown
        -- use({ "~/neovim_plugins/lua_markdown" })
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
        --
        -- -- Git from Vim
        -- use({ "tpope/vim-fugitive", cmd = { "G", "GV" } })
        --
        -- -- see git commits
        -- use({
        --     "junegunn/gv.vim",
        --     cmd = "GV",
        --     requires = { "tpope/vim-fugitive" },
        -- })

        -- easier use of f/F and t/T
        use({ "rhysd/clever-f.vim", keys = "f" })

        -- easily create md tables
        use({
            "dhruvasagar/vim-table-mode",
            cmd = "TableModeToggle",
        })

        -- -- display keybindings help
        use({
            opt = true,
            "~/neovim_plugins/which-key.nvim",
            after = "nvim-treesitter",
            config = function()
                require("which-key").setup({})
                require("configs.which_key")
                require("mappings")
            end,
            requires = {
                "~/neovim_plugins/mappy.nvim/",
            },
        })

        use({
            "rcarriga/nvim-notify",
            opt = true,
            config = function()
                vim.notify = require("notify")
            end,
        })

        use({ "~/float_help.nvim/", keys = { "<leader>hp" } })

        use({
            "~/neovim_plugins/colorscheme_switcher/",
            module = { "colorscheme_switcher" },
        })

        use({
            "bfredl/nvim-luadev",
            cmd = "Luadev",
        })

        -- more helpfiles
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
            -- "nvim-neorg/neorg",
            "~/neovim_plugins/neorg",
            -- branch = "better-concealing-performance",
            branch = "main",
            config = [[ require("configs.neorg") ]],

            requires = {
                -- "nvim-neorg/neorg-telescope",
                "terrortylor/neorg-telescope",
                -- "~/neovim_plugins/neorg-telescope/",
                "~/neovim_plugins/neorg-zettelkasten/",
            },
        })

        use({
            "rose-pine/neovim",
            as = "rose-pine",
            config = function()
                vim.g.rose_pine_variant = "moon"
                vim.g.rose_pine_bold_vertical_split_line = true
                vim.g.rose_pine_disable_italics = false
                vim.g.rose_pine_disable_background = false
                vim.g.rose_pine_disable_float_background = true
            end,
        })

        use({
            "folke/zen-mode.nvim",
            config = [[require("configs.zenmode")]],
            cmd = "ZenMode",
            requires = {
                opt = true,
                "folke/twilight.nvim",
                config = function()
                    require("twilight").setup({
                        dimming = {
                            alpha = 0.25,
                            color = { "Normal", "#ffffff" },
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
            "blackCauldron7/surround.nvim",
            config = function()
                require("surround").setup({
                    mappings_style = "surround",
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
        --
        -- use({
        --     "tamago324/lir.nvim",
        --     opt = true,
        --     module = "lir",
        --     -- keys = { "<leader>el", "<leader>ef" },
        --     config = [[ require("configs.lir") ]],
        --     requires = "kyazdani42/nvim-web-devicons",
        -- })
        --
        use({
            "zeertzjq/symbols-outline.nvim",
            branch = "patch-1",
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

        -- a file explorer
        use({
            "nvim-telescope/telescope.nvim",
            -- "l-kershaw/telescope.nvim",
            -- branch = "fix/preview_update",
            -- "~/neovim_plugins/telescope.nvim/",
            cmd = "Telescope",
            module = { "telescope", "configs.telescope" },
            keys = { "<leader>Cs" },
            requires = {},
            config = [[ require("configs.telescope") ]],
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
                    enable_persistant_history = true,
                    default_register_macros = "q",
                    enable_macro_history = true,
                    on_replay = {
                        set_reg = true,
                    },
                })
            end,
        })

        use({
            "~/startup.nvim",
            opt = true,
            config = [[ require("startup").setup(require("configs.startup_nvim")) ]],
            requires = {
                "~/startup_themes/",
            },
        })

        -- colorize color codes
        use({
            "norcalli/nvim-colorizer.lua",
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

        use({ "~/hangman.nvim/", command = "Hangman" })

        -- completition
        use({
            "iron-e/nvim-cmp",
            -- "~/nvim-cmp/",
            event = { "InsertEnter", "CmdLineEnter" },
            branch = "feat/completion-menu-borders",
            config = [[ require("configs.cmp") ]],
            requires = {
                {
                    "L3MON4D3/LuaSnip",
                    opt = true,
                    requires = {
                        "rafamadriz/friendly-snippets",
                        after = "LuaSnip",
                        event = "InsertEnter",
                    },
                    event = "InsertEnter",
                    after = "nvim-cmp",
                    config = function()
                        require("configs.snippets")
                    end,
                },
            },
        })
        use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })
        use({ "hrsh7th/cmp-emoji", after = "nvim-cmp" })
        use({ "~/neovim_plugins/cmp-greek/", after = "nvim-cmp" })
        use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
        use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
        use({ "kdheepak/cmp-latex-symbols", after = "nvim-cmp" })
        use({ "hrsh7th/cmp-calc", after = "nvim-cmp" })
        use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
        use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
        use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })
        use({ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" })

        use({
            "danymat/neogen",
            module = { "neogen" },
            config = function()
                require("neogen").setup({
                    enabled = true,
                    languages = {
                        lua = {
                            template = {
                                emmylua = {
                                    { nil, "-$1", { type = { "class", "func" } } }, -- add this string only on requested types
                                    { nil, "-$1", { no_results = true } }, -- Shows only when there's no results from the granulator
                                    { "parameters", "-@param %s $1|any" },
                                    { "vararg", "-@vararg $1|any" },
                                    { "return_statement", "-@return $1|any" },
                                    { "class_name", "-@class $1|any" },
                                    { "type", "-@type $1" },
                                },
                            },
                        },
                    },
                })
            end,
        })

        -- autopairs
        use({
            "windwp/nvim-autopairs",
            after = "nvim-cmp",
            config = [[ require("configs.nvim_autopairs") ]],
        })

        -- config for lsp
        use({
            "neovim/nvim-lspconfig",
            opt = true,
            requires = {
                { "folke/lua-dev.nvim", opt = true },
                -- { "williamboman/nvim-lsp-installer", opt = true },
            },
            config = function()
                require("configs.lsp")
            end,
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
    end,
    config = {
        compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
        profile = {
            enable = true,
            threshold = 0.0001,
        },
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
