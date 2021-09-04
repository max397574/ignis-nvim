-- Plugins
-- =======
require("packer").startup({
  function(use)
    -- package manager
    use("wbthomason/packer.nvim")

    -- dimm inactive window
    use({"sunjon/shade.nvim",
      config = function()
        require("configs.shade")
      end
    })

    -- lua repl
    use("bfredl/nvim-luadev")

    -- show where lsp code action as available
    use("kosayoda/nvim-lightbulb")

    -- dashboard
    use("glepnir/dashboard-nvim")

    -- bufferline
    use({
      "akinsho/bufferline.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("configs.bufferline")
      end,
    })
    -- colorschemes
    use("lifepillar/vim-gruvbox8")
    use("Pocco81/Catppuccino.nvim")
    use("shaunsingh/moonlight.nvim")
    use("navarasu/onedark.nvim")
    use("folke/tokyonight.nvim")
    use("tiagovla/tokyodark.nvim")
    use("sainnhe/gruvbox-material")
    -- statusline
    use({ "hoob3rt/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = function()
        require("configs.lualine")
      end
    })
    -- stats
    use({ "wakatime/vim-wakatime" })

    -- calculate math figures on visual selection
    use({ "~/vmath.nvim" })

    -- some functions to help with markdown
    use("~/lua_markdown")

    -- show taglist
    use("~/taglist.nvim")

    -- easily comment out code
    use("terrortylor/nvim-comment")

    -- breakup of startup time
    use({ "tweekmonster/startuptime.vim" })

    -- more commands can be repeated with `.`
    use({ "tpope/vim-repeat" })

    -- snippets
    use({ "SirVer/ultisnips" })
    use({ "honza/vim-snippets" })

    -- Git from Vim
    use({ "tpope/vim-fugitive" })

    -- see git commits
    use({ "junegunn/gv.vim" })

    -- distraction free writing
    use({ "folke/zen-mode.nvim" })

    -- dimm inactive parts of code
    use({
      "folke/twilight.nvim",
      config = function()
        require("twilight").setup({
          context = 20, -- amount of lines we will try to show around the current line
        })
      end,
    })

    -- easier use of f/F and t/T
    use("rhysd/clever-f.vim")

    -- easily create md tables
    use({ "dhruvasagar/vim-table-mode" })

    -- display keybindings help
    use({
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup({})
        require("configs.which_key")
      end,
    })

    -- highlight and search todo comments
    use({
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup({})
      end,
    })

    -- automatically match parantheses etc
    use({ "jiangmiao/auto-pairs" })

    -- multiple cursors
    use("mg979/vim-visual-multi")

    -- change,add and delete surroundings
    use("tpope/vim-surround")

    -- display last undos
    use({ "mbbill/undotree" })

    -- display some infos in signcolumn
    use("mhinz/vim-signify")

    -- more icons
    use("ryanoasis/vim-devicons")

    -- even more icons
    use("kyazdani42/nvim-web-devicons")

    -- a file explorer
    use({
      "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" },
        { "sharkdp/bat" },
        { "kyazdani42/nvim-web-devicons" },
      },
      config = function()
        require("configs.telescope")
      end
    })
    -- telescope extensions
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use({ "nvim-telescope/telescope-symbols.nvim" })
    use({ "jvgrootveld/telescope-zoxide" })

    -- display helpfiles
    use({"lvim-tech/lvim-helper",
      config = function()
        require("configs.lvim_helper")
      end
    })

    -- colorize color codes
    use({"norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup({
          "*",
        }, { mode = "foreground" })
      end
    })

    -- completition
    use({ "hrsh7th/nvim-cmp",
      config = function()
        require("configs.cmp")
      end
    })
    use({ "quangnguyen30192/cmp-nvim-ultisnips" })
    use({ "hrsh7th/cmp-emoji" })
    use({ "hrsh7th/cmp-buffer" })
    use({ "hrsh7th/cmp-path" })
    use({ "hrsh7th/cmp-calc" })
    use({ "hrsh7th/cmp-nvim-lua" })
    use({ "hrsh7th/cmp-nvim-lsp" })

    -- easily configure lsp
    use("neovim/nvim-lspconfig")

    -- easy install for lsp servers
    use({"kabouzeid/nvim-lspinstall",
      after = "nvim-lspconfig",
      config = function()
        require("configs.lsp")
      end
    })

    -- colors for lsp diagnostics
    use("folke/lsp-colors.nvim")

    -- list for lsp,quickfix,telescope etc
    use({
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup({
          auto_preview = false, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        })
      end,
    })

    -- parsers for code
    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("configs.treesitter")
      end,
    })

    -- refractor code with TS
    use("nvim-treesitter/nvim-treesitter-refactor")

    -- structural editing with ts queries
    use("vigoux/architext.nvim")

    -- additional textobjects with TS
    use("nvim-treesitter/nvim-treesitter-textobjects")

    -- select code
    use("RRethy/nvim-treesitter-textsubjects")

    -- TS based colored parantheses
    use("p00f/nvim-ts-rainbow")

    -- explore syntax tree and test TS queries
    use("nvim-treesitter/playground")

    -- display context of current function
    use("romgrk/nvim-treesitter-context")

    -- hints for operators
    use("mfussenegger/nvim-ts-hint-textobject")
  end,
  config = {
    profile = {
      enable = true,
      threshold = 0,
    },
    display = {
      open_fn = function()
        return require("packer.util").float({
          border = require("utils").border,
        })
      end,
    },
  },
})

-- Settings
-- ========

require("nvim_comment").setup({
  comment_empty = false,
  create_mappings = true,
  line_mapping = "<leader>cc",
  operator_mapping = "<leader>c",
})

require("treesitter-context.config").setup({
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
})

require("vmath_nvim").setup({
  show_sum = true,
  show_average = true,
  show_count = true,
  show_lowest = true,
  show_highest = true,
  show_range = true,
  show_median = true,
  debug = false,
  registers = true,
})
