-- Plugins
-- =======
-- packer options: https://github.com/wbthomason/packer.nvim#specifying-plugins
require("packer").startup {
  function(use)
    -- package manager
    use "wbthomason/packer.nvim"

    -- lua repl
    use {"bfredl/nvim-luadev",
    ft = { "lua"}, }

    -- show where lsp code action as available
    use "kosayoda/nvim-lightbulb"

    -- dashboard
    use {
      "glepnir/dashboard-nvim",
      config = function()
        require "configs.dashboard"
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
    -- colorschemes
    use "lifepillar/vim-gruvbox8"
    use "Pocco81/Catppuccino.nvim"
    use "shaunsingh/moonlight.nvim"
    use "navarasu/onedark.nvim"
    use "folke/tokyonight.nvim"
    use "tiagovla/tokyodark.nvim"
    use "sainnhe/gruvbox-material"
    -- statusline
    use {
      "hoob3rt/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = function()
        require "configs.lualine"
      end,
    }
    -- stats
    use { "wakatime/vim-wakatime" }

    -- calculate math figures on visual selection
    use {
      "~/vmath.nvim",
      config = function()
        require "configs.vmath"
      end,
    }

    -- some functions to help with markdown
    use "~/lua_markdown"

    -- show taglist
    use "~/taglist.nvim"

    -- easily comment out code
    use {
      "terrortylor/nvim-comment",
      config = function()
        require "configs.nvim_comment"
      end,
    }

    -- breakup of startup time
    use { "tweekmonster/startuptime.vim" }

    -- snippets
    use { "SirVer/ultisnips", 
      event = "InsertEnter",
      requires = {"honza/vim-snippets"}
    }

    -- Git from Vim
    use { "tpope/vim-fugitive",
      cmd = "G"
    }

    -- see git commits
    use { "junegunn/gv.vim",
    cmd = "GV"}

    -- easier use of f/F and t/T
    use "rhysd/clever-f.vim"

    -- easily create md tables
    use { "dhruvasagar/vim-table-mode",
    cmd = "TableModeToggle"}

    -- display keybindings help
    use {
      "folke/which-key.nvim",
      config = function()
        require("which-key").setup {}
        require "configs.which_key"
      end,
    }

    -- highlight and search todo comments
    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      cmd = "TodoTelescope",
      config = function()
        require("todo-comments").setup {}
      end,
    }

    -- change,add and delete surroundings
    use "tpope/vim-surround"

    -- display last undos
    use { "mbbill/undotree",
    cmd = "UndotreeToggle"}

    -- display some infos in signcolumn
    use "mhinz/vim-signify"

    -- more icons
    use "ryanoasis/vim-devicons"

    -- even more icons
    use "kyazdani42/nvim-web-devicons"

    -- a file explorer
    use {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      requires = {
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" },
        { "sharkdp/bat" },
        { "kyazdani42/nvim-web-devicons" },
      },
      config = function()
        require "configs.telescope"
      end,
    }
    -- telescope extensions
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use { "nvim-telescope/telescope-symbols.nvim" }
    use { "jvgrootveld/telescope-zoxide" }

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
      config = function()
        require("colorizer").setup({
          "*",
        }, {
          mode = "foreground",
        })
      end,
    }

    -- completition
    use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      config = function()
        require "configs.cmp"
      end,
    }
    use { "quangnguyen30192/cmp-nvim-ultisnips",
    after = "nvim-cmp"}
    use { "hrsh7th/cmp-emoji",after = "nvim-cmp"}
    use { "hrsh7th/cmp-buffer",after = "nvim-cmp"}
    use { "hrsh7th/cmp-path",after = "nvim-cmp"}
    use { "hrsh7th/cmp-calc",after = "nvim-cmp"}
    use { "hrsh7th/cmp-nvim-lua",after = "nvim-cmp"}
    use { "hrsh7th/cmp-nvim-lsp",after = "nvim-cmp"}

    -- autopairs
    use {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
        require "configs.nvim_autopairs"
      end,
    }

    -- easily configure lsp
    use "neovim/nvim-lspconfig"

    -- easy install for lsp servers
    use {
      "kabouzeid/nvim-lspinstall",
      config = function()
        require("lspinstall").setup()
        require "configs.lsp"
      end,
    }

    -- colors for lsp diagnostics
    use "folke/lsp-colors.nvim"

    -- list for lsp,quickfix,telescope etc
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {
          auto_preview = false, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        }
      end,
    }

    -- parsers for code
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require "configs.treesitter"
      end,
    }

    -- refractor code with TS
    use "nvim-treesitter/nvim-treesitter-refactor"

    -- structural editing with ts queries
    use "vigoux/architext.nvim"

    -- additional textobjects with TS
    use "nvim-treesitter/nvim-treesitter-textobjects"

    -- select code
    use "RRethy/nvim-treesitter-textsubjects"

    -- TS based colored parantheses
    use "p00f/nvim-ts-rainbow"

    -- explore syntax tree and test TS queries
    use {"nvim-treesitter/playground",
    cmd = {"TSPlaygroundToggle", "TSHighlightCapturesUnderCursor"}}

    -- display context of current function
    use "romgrk/nvim-treesitter-context"

    -- hints for operators
    use "mfussenegger/nvim-ts-hint-textobject"
  end,
  config = {
    profile = {
      enable = true,
      threshold = 0,
    },
    display = {
      open_fn = function()
        return require("packer.util").float {
          border = require("utils").border,
        }
      end,
    },
  },
}
