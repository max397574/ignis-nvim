-- Plugins
-- =======

-- somewhen plugins
-- https://github.com/yamatsum/nvim-nonicons
-- https://github.com/lervag/vimtex#configuration
-- https://github.com/latex-lsp/texlab

local packer_path = vim.fn.stdpath("data")
    .. "/site/pack/packer/opt/packer.nvim"

if vim.fn.empty(vim.fn.glob(packer_path)) > 0 then
    require("ignis.external.log").info(
        "Bootstrapping packer.nvim, please wait ..."
    )
    vim.fn.system({
        "git",
        "clone",
        "https://github.com/wbthomason/packer.nvim",
        packer_path,
    })
end

local plugin_disabled = require("ignis.utils").is_plugin_disabled

local config = require("ignis.config").config
local modules_config = config.ignis.modules

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
            disable = plugin_disabled("ui", "heirline"),
            config = function()
                require("ignis.modules.ui.heirline")
            end,
        })

        use({ "shift-d/wordle.nvim", command = "Wordle", branch = "finish-win" })

        use({
            "akinsho/bufferline.nvim",
            disable = plugin_disabled("ui", "bufferline"),
            -- can be lazyloaded because disabled when opening only one file
            event = "ColorScheme",
            config = function()
                require("ignis.modules.ui.bufferline")
            end,
        })

        use({ "nvim-lua/plenary.nvim", module = "plenary" })

        use({
            "rcarriga/nvim-notify",
            config = function()
                vim.notify = require("notify")
            end,
        })

        -- create directories if they don't exist
        use({
            "jghauser/mkdir.nvim",
            config = function()
                require("mkdir")
            end,
            event = "BufWritePre",
        })

        use({ "VonHeikemen/searchbox.nvim", opt = true })
        use({ "jbyuki/nabla.nvim", opt = true })
        use({ "elihunter173/dirbuf.nvim", opt = true })
        use({ "mizlan/iswap.nvim", opt = true })
        use({ "lervag/vimtex", opt = true })

        -- use({ "max397574/selection_popup.nvim", module = "selection_popup" })

        use({
            "nvim-ignis/nvim-base16.lua",
        })
        use({ "tami5/sqlite.lua", module = "sqlite" })
        --
        -- -- better escape
        use({
            disable = plugin_disabled("utils", "better_escape"),
            "max397574/betterEscape.nvim",
            event = { "InsertEnter" },
            config = function()
                require("better_escape").setup({
                    mapping = { "jk" },
                    keys = "<ESC>",
                    timeout = 200,
                })
            end,
        })

        use({
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function()
                require("ignis.modules.misc.treesitter")
            end,
            requires = {
                "nvim-treesitter/nvim-treesitter-refactor",
                "nvim-treesitter/nvim-treesitter-textobjects",
                {
                    "romgrk/nvim-treesitter-context",
                    event = "InsertEnter",
                    config = function()
                        vim.cmd([[hi! link TreesitterContext Visual]])
                        require("treesitter-context.config").setup({
                            enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                        })
                    end,
                },
            },
        })

        use({ "RRethy/nvim-treesitter-endwise", event = "InsertEnter" })

        use({
            "nvim-treesitter/playground",
            cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
        })

        use({ "ggandor/lightspeed.nvim", opt = true })

        use({
            "lukas-reineke/indent-blankline.nvim",
            opt = true,
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
        use({ "rhysd/clever-f.vim", keys = "f" })

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
            "max397574/which-key.nvim",
            after = "nvim-treesitter",
            config = function()
                require("which-key").setup({})
                require("configs.which_key")
                require("mappings")
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
            "nvim-neorg/neorg",
            disable = plugin_disabled("misc", "neorg"),
            branch = "main",
            config = function()
                require("ignis.modules.misc.neorg")
            end,

            requires = {
                "nvim-neorg/neorg-telescope/",
            },
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
            cmd = "Telescope",
            module = { "telescope", "ignis.modules.files.telescope" },
            requires = {},
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

        use({
            "max397574/startup.nvim",
            config = function()
                require("startup").setup(
                    require("ignis.modules.ui.startup_nvim")
                )
            end,
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

        use({ "max397574/hangman.nvim/", command = "Hangman" })

        -- completition
        use({
            "iron-e/nvim-cmp",
            branch = "feat/completion-menu-borders",
            event = { "InsertEnter", "CmdLineEnter" },
            config = function()
                require("ignis.modules.completion.cmp")
            end,
        })
        use({
            "L3MON4D3/LuaSnip",
            requires = {
                "rafamadriz/friendly-snippets",
                after = "LuaSnip",
                event = "InsertEnter",
            },
            -- event = "InsertEnter",
            module = "luasnip",
            after = "nvim-cmp",
            config = function()
                require("ignis.modules.completion.snippets")
            end,
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
            "danymat/neogen",
            module = { "neogen" },
            config = function()
                require("neogen").setup({
                    enabled = true,
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
                { "folke/lua-dev.nvim", module = "lua-dev" },
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
        for _, plugin in pairs(config.custom_plugins) do
            use(plugin)
        end
    end,
    config = {
        -- compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
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
