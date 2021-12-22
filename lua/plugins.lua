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
      "~/nvim-base16.lua",
    })

    -- use({
    --   "narutoxy/themer.lua",
    --   branch = "dev",
    --   after = "impatient.nvim",
    --   -- after = "packer.nvim", -- hmm for some reason this errors out also `themer.lua` is not a heavy plugin
    --   config = function()
    --     -- require("themer").load("onedark")
    --   end,
    -- })

    -- use {"~/footprints.nvim/", after = "themer.lua",
    --   config = function()
    --     require"footprints_nvim".setup({
    --       ns_id = require"themer.utils.util".ns,
    --       highlight_color_2 = "#353b45",
    --       highlight_color_3 = "#3e4451",
    --       highlight_color_4 = "#545862",
    --       highlight_color_5 = "#565c64",
    --     })
    --   end}

    -- better escape
    use({
      -- "max397574/better-escape.nvim",
      -- branch = "dev",
      "~/betterEscape.nvim",
      event = { "InsertEnter" },
      config = function()
        require("better_escape").setup({
          mapping = { "yy" },
          keys = "<ESC>",
          timeout = 200,
        })
      end,
    })

    -- use({
    --   "edluffy/specs.nvim",
    --   event = { "CursorMoved" },
    --   config = function()
    -- require("specs").setup({
    --   show_jumps = true,
    --   min_jump = 10,
    --   popup = {
    --     delay_ms = 0, -- delay before popup displays
    --     inc_ms = 20, -- time increments used for fade/resize effects
    --     blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
    --     width = 20,
    --     winhl = "PMenu",
    --     fader = require("specs").linear_fader,
    --     resizer = require("specs").shrink_resizer,
    --   },
    --   ignore_filetypes = { "norg", "neorg" },
    --   ignore_buftypes = { nofile = true },
    -- })

    --   end,
    -- })

    -- faster filetype detection
    use("~/filetype.nvim")

    -- colorscheme
    -- use({ "sainnhe/gruvbox-material" })
    -- use({ "NTBBloodbath/doombox.nvim" })
    -- use({ "MordechaiHadad/nvim-papadark", requires = { "rktjmp/lush.nvim" } })
    -- use({ "NTBBloodbath/doom-one.nvim" })
    use({ "~/colorschemes", opt = true })
    -- use { "~/onedarker.nvim" }
    -- use { "tiagovla/tokyodark.nvim" }
    -- use "~/galaxy_nvim"
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

    -- parsers for code
    use({
      "nvim-treesitter/nvim-treesitter",
      -- "~/nvim-treesitter",
      -- after = "impatient.nvim",
      -- opt = true,
      run = ":TSUpdate",
      -- event = "BufRead",
      config = function()
        require("configs.treesitter")
      end,
      requires = {
        "nvim-treesitter/nvim-treesitter-refactor",
        "nvim-treesitter/nvim-treesitter-textobjects",
        {
          "nvim-treesitter/playground",
          cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
        },
        "mfussenegger/nvim-ts-hint-textobject",
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
            ["c"] = {
              ["c"] = "<cmd>lua require'utils'.append_comma()<CR>",
            },
            j = {
              k = "<esc>",
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
    -- use({
    --   "hoob3rt/lualine.nvim",
    --   config = [[ require("configs.lualine") ]],
    -- })
    use({
      "~/staline.nvim/",
      -- "tamton-aquib/staline.nvim",
      config = function()
        vim.cmd([[hi StalineSeparator guifg=#181a23 guibg=none]])
        vim.cmd([[hi StalineEmpty guibg=none guifg=#353b45]])
        require("staline").setup({
          sections = {
            left = {
              " ",
              "file_name",
              { "StalineSeparator", "left_sep" },
              -- "left_sep",
              {"StylineEmpty", " "},
              { "StalineSeparator", "right_sep" },
              -- "right_sep",
              "branch",
              { "StalineSeparator", "left_sep" },
              -- "left_sep",
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
            bg = "#181a23",
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
            n = "#98c379",
            i = "#56b6c2",
            ic = "#56b6c2",
            c = "#c678dd",
            v = "#61afef",       -- etc
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

    -- calculate math figures on visual selection
    -- use({
    --   "~/vmath.nvim",
    --   cmd = { "Vmath" },
    --   config = [[ require("configs.vmath") ]],
    -- })

    -- some functions to help with markdown
    use({ "~/lua_markdown", ft = { "markdown" } })

    -- easily comment out code
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

    -- Git from Vim
    use({ "tpope/vim-fugitive", cmd = { "G", "GV" } })

    -- see git commits
    use({
      "junegunn/gv.vim",
      cmd = "GV",
      requires = { "tpope/vim-fugitive" },
    })

    -- easier use of f/F and t/T
    use({ "rhysd/clever-f.vim", keys = "f" })

    -- easily create md tables
    use({
      "dhruvasagar/vim-table-mode",
      cmd = "TableModeToggle",
    })

    -- display keybindings help
    use({
      opt = true,
      "folke/which-key.nvim",
      after = "nvim-treesitter",
      config = function()
        require("which-key").setup({})
        require("configs.which_key")
        require("mappings")
      end,
    })

    use({ "~/float_help.nvim/", keys = { "<leader>hp" } })

    use({ "~/colorscheme_switcher/", keys = { "<leader>cn" } })

    use({
      -- "nvim-neorg/neorg",
      "~/neorg",
      -- branch = "display-inline-toc",
      branch = "main",
      -- branch = "better-concealing-performance",
      config = [[ require("configs.neorg") ]],

      requires = {
        -- {"max397574/neorg-telescope/",
        -- branch = "heading_picker"},
        -- "nvim-neorg/neorg-telescope",
        "~/neorg-telescope/",
      },
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

    -- use({
    --   "jameshiew/nvim-magic",
    --   config = [[ require("nvim-magic").setup() ]],
    --   requires = {
    --     "MunifTanjim/nui.nvim",
    --   },
    -- })

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
        vim.g.nvim_tree_auto_ignore_ft = { "dashboard", "startify", "startup" }
        vim.g.nvim_tree_indent_markers = 1
        vim.g.nvim_tree_git_hl = 1
        vim.g.nvim_tree_lsp_diagnostics = 1
        require("nvim-tree").setup({
          auto_open = 1,
          auto_close = 1,
          follow = 1,
          -- disable_netrw = 0,
        })
        require("nvim-tree.events").on_nvim_tree_ready(function()
          vim.cmd("NvimTreeRefresh")
        end)
      end,
    })

    -- change,add and delete surroundings
    -- use "tpope/vim-surround"
    use({
      "blackCauldron7/surround.nvim",
      config = [[ require("surround").setup({ mappings_style = "surround",
      pairs = {
      nestable = {{"(", ")"}, {"[", "]"}, {"{", "}"},{"/","/"}},
      linear = {{"'", "'"}, {"`", "`"}, {'"', '"'}}
      },
      }) ]],
    })

    -- display last undos
    use({ "mbbill/undotree", cmd = "UndotreeToggle" })

    -- more icons
    use("ryanoasis/vim-devicons")

    -- even more icons
    use({
      "kyazdani42/nvim-web-devicons",
    })

    use({
      "tamago324/lir.nvim",
      opt = true,
      keys = { "<leader>el", "<leader>ef" },
      config = [[ require("configs.lir") ]],
      requires = "kyazdani42/nvim-web-devicons",
    })

    -- a file explorer
    use({
      "nvim-telescope/telescope.nvim",
      -- "~/telescope.nvim/",
      -- "l-kershaw/telescope.nvim",
      -- branch = "fix/bottom_pane_overlaps",
      -- opt = true,
      -- cmd = "Telescope",
      -- after = "impatient.nvim",
      -- event = "BufRead",
      requires = {
        { "nvim-lua/popup.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        { "nvim-telescope/telescope-symbols.nvim" },
        { "nvim-telescope/telescope-file-browser.nvim" },
      },
      config = [[ require("configs.telescope") ]],
    })
    use({
      "AckslD/nvim-neoclip.lua",
      requires = { "tami5/sqlite.lua", module = "sqlite" },
      config = [[ require("neoclip").setup() ]],
    })

    use({
      "~/startup.nvim",
      opt = true,
      config = [[ require("startup").setup(require("configs.startup_nvim")) ]],
      -- config = [[ require("startup").setup(require("custom.nv_startup")) ]],
      -- config = [[ require("startup").setup({theme = "evil"}) ]],
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

    -- completition
    use({
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
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
    use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-calc", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" })

    use({
      "danymat/neogen",
      keys = { "<leader>a" },
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

    -- easily configure lsp
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
          [[autocmd CursorHold,CursorHoldI *.{lua} lua require'nvim-lightbulb'.update_lightbulb()]]
        )
      end,
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
