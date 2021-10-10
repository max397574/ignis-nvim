-- Plugins
-- =======
-- packer options: https://github.com/wbthomason/packer.nvim#specifying-plugins
require("packer").startup {
  function(use)
    -- package manager
    use "wbthomason/packer.nvim"

    -- create directories if they don't exist
    use {
      "jghauser/mkdir.nvim",
      config = function()
        require "mkdir"
      end,
      event = "BufWritePre",
    }

    -- better escape
    use {
      -- "max397574/better-escape.nvim",
      -- branch = "dev",
      "~/betterEscape.nvim",
      event = { "InsertEnter" },
      config = function()
        require("better_escape").setup {
          keys = "<ESC>",
          timeout = 200,
        }
      end,
    }

    use {
      "AckslD/nvim-neoclip.lua",
      requires = { "tami5/sqlite.lua", module = "sqlite" },
      config = function()
        require("neoclip").setup()
      end,
    }

    use {
      "edluffy/specs.nvim",
      config = function()
        require "configs.specs"
      end,
    }

    use "tamton-aquib/essentials.nvim"

    -- startup screen
    use {
      "~/startup.nvim",
      config = function()
        require("startup").setup(require "configs.startup_nvim")
      end,
    }

    -- faster filetype detection
    use "~/filetype.nvim"

    -- colorscheme
    use { "sainnhe/gruvbox-material" }
    use { "LunarVim/onedarker.nvim" }
    use "~/galaxy_nvim"
    use {
      "folke/tokyonight.nvim",
      config = function()
        require "configs.theme"
        local _time = os.date "*t"
        if _time.hour < 9 then
          vim.g.tokyonight_style = "night"
        end
      end,
    }

    use {
      "lukas-reineke/indent-blankline.nvim",
      setup = function()
        require("configs.blankline").setup()
      end,
    }

    -- stay healthy while coding
    use {
      "~/healthy.nvim",
      config = function()
        -- require("healthy_nvim").init()
      end,
    }

    -- floating terminal
    use {
      "akinsho/toggleterm.nvim",
      keys = { "<c-t>", "<leader>r" },
      config = function()
        require "configs.toggleterm"
      end,
    }

    -- bufferline
    use {
      "akinsho/bufferline.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require "configs.bufferline"
      end,
    }

    -- statusline
    use {
      "hoob3rt/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = function()
        require "configs.lualine"
      end,
    }

    use {
      "lewis6991/gitsigns.nvim",
      event = "BufReadPre",
      wants = "plenary.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require "configs.gitsigns"
      end,
    }

    -- calculate math figures on visual selection
    use {
      "~/vmath.nvim",
      cmd = { "Vmath" },
      config = function()
        require "configs.vmath"
      end,
    }

    -- some functions to help with markdown
    use { "~/lua_markdown", ft = { "markdown" } }

    -- easily comment out code
    use {
      "terrortylor/nvim-comment",
      config = function()
        require "configs.nvim_comment"
      end,
    }

    -- Git from Vim
    use { "tpope/vim-fugitive", cmd = "G" }

    -- see git commits
    use {
      "junegunn/gv.vim",
      cmd = "GV",
      requires = { "tpope/vim-fugitive" },
    }

    -- easier use of f/F and t/T
    use { "rhysd/clever-f.vim", keys = "f" }

    -- easily create md tables
    use {
      "dhruvasagar/vim-table-mode",
      cmd = "TableModeToggle",
    }

    -- display keybindings help
    use {
      "folke/which-key.nvim",
      key = "<leader>",
      config = function()
        require("which-key").setup {}
        require "configs.which_key"
      end,
    }

    -- highlight and search todo comments
    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      cmd = { "TodoTelescope", "TodoTrouble" },
      config = function()
        require("todo-comments").setup {}
      end,
    }

    use {
      "kyazdani42/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeClose" },
      config = function()
        require "configs.nvim_tree"
      end,
    }

    -- change,add and delete surroundings
    use "tpope/vim-surround"

    -- display last undos
    use { "mbbill/undotree", cmd = "UndotreeToggle" }

    -- more icons
    use "ryanoasis/vim-devicons"

    -- even more icons
    use {
      "kyazdani42/nvim-web-devicons",
      config = function()
        require "configs.web_devicons"
      end,
    }

    use {
      "tamago324/lir.nvim",
      config = function()
        require "configs.lir"
      end,
      requires = "kyazdani42/nvim-web-devicons",
    }

    -- a file explorer
    use {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      event = { "CursorMoved", "CursorHold" },
      requires = {
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" },
        { "kyazdani42/nvim-web-devicons" },
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        { "nvim-telescope/telescope-symbols.nvim" },
        { "jvgrootveld/telescope-zoxide" },
        { "nvim-telescope/telescope-frecency.nvim" },
        { "tami5/sqlite.lua" },
        -- { "nvim-telescope/telescope-packer.nvim" },
      },
      config = function()
        require "configs.telescope"
      end,
    }

    -- display helpfiles
    use {
      "lvim-tech/lvim-helper",
      cmd = "LvimHelper",
      config = function()
        require "configs.lvim_helper"
      end,
    }

    -- colorize color codes
    use {
      "norcalli/nvim-colorizer.lua",
      event = { "CursorMoved", "CursorHold" },
      config = function()
        require("colorizer").setup({
          "*",
        }, {
          mode = "foreground",
        })
        vim.cmd [[ColorizerAttachToBuffer]]
      end,
    }

    -- completition
    use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      config = function()
        require "configs.cmp"
      end,
      requires = {
        {
          "L3MON4D3/LuaSnip",
          requires = "rafamadriz/friendly-snippets",
          config = function()
            require "configs.snippets"
          end,
        },
      },
    }
    use { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" }
    use { "hrsh7th/cmp-emoji", after = "nvim-cmp" }
    use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
    use { "hrsh7th/cmp-path", after = "nvim-cmp" }
    use { "hrsh7th/cmp-calc", after = "nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" }
    use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }

    -- autopairs
    use {
      "windwp/nvim-autopairs",
      after = "nvim-cmp",
      config = function()
        require "configs.nvim_autopairs"
      end,
    }

    -- easily configure lsp
    use {
      "neovim/nvim-lspconfig",
      ft = {
        "vim",
        "typescript",
        "cpp",
        "html",
        "lua",
        "csharp",
        "cs",
        "css",
        "tex",
        "java",
        "python",
        "c",
      },
    }

    -- easy install for lsp servers
    use {
      after = "nvim-lspconfig",
      "kabouzeid/nvim-lspinstall",
      config = function()
        require("lspinstall").setup()
        require "configs.lsp"
      end,
    }

    -- show where lsp code action as available
    use {
      "kosayoda/nvim-lightbulb",
      after = "nvim-lspconfig",
      config = function()
        vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
      end,
    }

    -- list for lsp,quickfix,telescope etc
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      cmd = { "Trouble", "TroubleToggle" },
      config = function()
        require("trouble").setup {
          auto_preview = false,
        }
      end,
    }

    -- parsers for code
    use {
      "nvim-treesitter/nvim-treesitter",
      event = { "BufEnter" },
      run = ":TSUpdate",
      config = function()
        require "configs.treesitter"
      end,
    }

    -- refractor code with TS
    use {
      "nvim-treesitter/nvim-treesitter-refactor",
      after = "nvim-treesitter",
    }

    -- additional textobjects with TS
    use {
      "nvim-treesitter/nvim-treesitter-textobjects",
      after = "nvim-treesitter",
    }

    -- select code
    use { "RRethy/nvim-treesitter-textsubjects", after = "nvim-treesitter" }

    -- TS based colored parantheses
    use { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" }

    -- explore syntax tree and test TS queries
    use {
      "nvim-treesitter/playground",
      after = "nvim-treesitter",
      cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
    }

    -- display context of current function
    use {
      "romgrk/nvim-treesitter-context",
      after = "nvim-treesitter",
      config = function()
        require("treesitter-context.config").setup {
          enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        }
      end,
    }

    -- hints for operators
    use {
      "mfussenegger/nvim-ts-hint-textobject",
      after = "nvim-treesitter",
    }
  end,
  config = {
    profile = {
      enable = true,
      threshold = 0,
    },
    display = {
      open_fn = function()
        return require("packer.util").float {
          border = require("utils").border_thin_rounded,
        }
      end,
    },
  },
}
