-- Plugins
-- =======
-- packer options: https://github.com/wbthomason/packer.nvim#specifying-plugins
require("packer").startup({
  function(use)
    -- package manager
    use("wbthomason/packer.nvim")

    use({
      "lewis6991/impatient.nvim",
      opt = true,
      config = function()
        require("impatient")
        require("impatient").enable_profile()
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

    -- use("github/copilot.vim")

    use({
      "~/nvim-base16.lua",
    })

    use({
      "narutoxy/themer.lua",
      branch = "dev",
      after = "impatient.nvim",
      -- after = "packer.nvim", -- hmm for some reason this errors out also `themer.lua` is not a heavy plugin
      config = function()
        -- require("themer").load("onedark")
      end,
    })

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
          keys = "<ESC>",
          timeout = 200,
        })
      end,
    })

    use({
      "edluffy/specs.nvim",
      event = { "CursorMoved" },
      config = function()
        require("configs.specs")
      end,
    })

    -- faster filetype detection
    use("~/filetype.nvim")

    -- colorscheme
    use({ "sainnhe/gruvbox-material" })
    use({ "NTBBloodbath/doombox.nvim" })
    use({ "MordechaiHadad/nvim-papadark", requires = { "rktjmp/lush.nvim" } })
    use({ "NTBBloodbath/doom-one.nvim" })
    use("~/colorschemes")
    -- use { "~/onedarker.nvim" }
    -- use { "tiagovla/tokyodark.nvim" }
    -- use "~/galaxy_nvim"
    use({
      "folke/tokyonight.nvim",
      config = function()
        require("configs.theme")
        local _time = os.date("*t")
        if _time.hour < 9 then
          vim.g.tokyonight_style = "night"
        end
      end,
    })
    -- parsers for code
    use({
      "nvim-treesitter/nvim-treesitter",
      after = "impatient.nvim",
      opt = true,
      run = ":TSUpdate",
      event = "BufRead",
      config = function()
        require("configs.treesitter")
      end,
    })
    use({ "nvim-treesitter/nvim-treesitter-refactor", after = "nvim-treesitter" })
    use({
      "nvim-treesitter/nvim-treesitter-textobjects",
      after = "nvim-treesitter",
    })
    use({ "RRethy/nvim-treesitter-textsubjects", after = "nvim-treesitter" })
    use({ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" })
    use({
      "nvim-treesitter/playground",
      cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
      after = "nvim-treesitter",
    })
    use({
      "romgrk/nvim-treesitter-context",
      after = "nvim-treesitter",
      config = function()
        require("treesitter-context.config").setup({
          enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        })
      end,
    })
    use({ "mfussenegger/nvim-ts-hint-textobject", after = "nvim-treesitter" })

    use({
      "lukas-reineke/indent-blankline.nvim",
      setup = function()
        require("configs.blankline").setup()
      end,
    })

    -- stay healthy while coding
    -- use {
    --   "~/healthy.nvim",
    --   config = function()
    --     -- require("healthy_nvim").init()
    --   end,
    -- }

    -- floating terminal
    use({
      "akinsho/toggleterm.nvim",
      keys = { "<c-t>", "<leader>r" },
      config = function()
        require("configs.toggleterm")
      end,
    })

    use({
      "chentau/marks.nvim",
      config = function()
        require("marks").setup({})
      end,
    })

    -- bufferline
    use({
      "akinsho/bufferline.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("configs.bufferline")
      end,
    })

    -- statusline
    use({
      "hoob3rt/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = function()
        require("configs.lualine")
      end,
    })

    use({
      "lewis6991/gitsigns.nvim",
      event = "BufReadPre",
      wants = "plenary.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("configs.gitsigns")
      end,
    })

    -- calculate math figures on visual selection
    use({
      "~/vmath.nvim",
      cmd = { "Vmath" },
      config = function()
        require("configs.vmath")
      end,
    })

    -- some functions to help with markdown
    use({ "~/lua_markdown", ft = { "markdown" } })

    -- easily comment out code
    use({
      "terrortylor/nvim-comment",
      keys = { "<leader>c", "<leader>cc" },
      config = function()
        require("configs.nvim_comment")
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

    use("~/float_help.nvim/")

    use("~/colorscheme_switcher/")

    use({
      "nvim-neorg/neorg",
      after = "nvim-treesitter",
      -- branch = "unstable",
      branch = "new-links",
      config = function()
        require("configs.neorg")
      end,

      requires = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
    })

    use({
      "jameshiew/nvim-magic",
      config = function()
        require("nvim-magic").setup()
      end,
      requires = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
      },
    })

    -- highlight and search todo comments
    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      cmd = { "TodoTelescope", "TodoTrouble" },
      config = function()
        require("todo-comments").setup({})
      end,
    })

    use({
      "kyazdani42/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeClose" },
      config = function()
        require("configs.nvim_tree")
      end,
    })

    -- change,add and delete surroundings
    -- use "tpope/vim-surround"
    use({
      "blackCauldron7/surround.nvim",
      config = function()
        require("surround").setup({ mappings_style = "surround" })
      end,
    })

    -- display last undos
    use({ "mbbill/undotree", cmd = "UndotreeToggle" })

    -- more icons
    use("ryanoasis/vim-devicons")

    -- even more icons
    use({
      "kyazdani42/nvim-web-devicons",
      config = function()
        require("configs.web_devicons")
      end,
    })

    use({
      "tamago324/lir.nvim",
      config = function()
        require("configs.lir")
      end,
      requires = "kyazdani42/nvim-web-devicons",
    })

    -- a file explorer
    use({
      "nvim-telescope/telescope.nvim",
      opt = true,
      cmd = "Telescope",
      after = "impatient.nvim",
      event = "BufRead",
      requires = {
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" },
        { "kyazdani42/nvim-web-devicons" },
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        { "nvim-telescope/telescope-symbols.nvim" },
        { "jvgrootveld/telescope-zoxide" },
        { "nvim-telescope/telescope-frecency.nvim" },
        { "benfowler/telescope-luasnip.nvim" },
        { "tami5/sqlite.lua" },
        -- { "nvim-telescope/telescope-packer.nvim" }, -- breaks packer
      },
      config = function()
        require("configs.telescope")
      end,
    })
    use({
      "AckslD/nvim-neoclip.lua",
      requires = { "tami5/sqlite.lua", module = "sqlite" },
      config = function()
        require("neoclip").setup()
      end,
    })

    use({
      "~/startup.nvim",
      opt = true,
      config = function()
        require("startup").setup(require("configs.startup_nvim"))
        -- require("startup").setup()
      end,
    })

    -- colorize color codes
    use({
      "norcalli/nvim-colorizer.lua",
      event = { "CursorMoved", "CursorHold" },
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
      config = function()
        require("configs.cmp")
      end,
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

    -- autopairs
    use({
      "windwp/nvim-autopairs",
      after = "nvim-cmp",
      config = function()
        require("configs.nvim_autopairs")
      end,
    })

    -- easily configure lsp
    use({
      "neovim/nvim-lspconfig",
      opt = true,
      requires = {
        { "folke/lua-dev.nvim", opt = true },
        "kabouzeid/nvim-lspinstall",
      },
      config = function()
        require("configs.lsp")
        require("lspinstall").setup()
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
      requires = "kyazdani42/nvim-web-devicons",
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
      threshold = 0,
    },
    display = {
      open_fn = function()
        return require("packer.util").float({
          border = require("utils").border_thin_rounded,
        })
      end,
    },
  },
})
