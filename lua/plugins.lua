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
    use({ "hoob3rt/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
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
    use("norcalli/nvim-colorizer.lua")

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

require("colorizer").setup({
  "*",
}, { mode = "foreground" })

local wk = require("which-key")

wk.register({
  f = {
    name = "Find",
    f = { "Files" },
    h = { "Help Tags" },
    b = { "Buffers" },
    o = { "OldFiles" },
    s = { "Lsp Symbols" },
    d = { "Directories (Zoxide)" },
    u = { "Under" },
  },
  l = {
    name = "LiveGrep, LuaDev",
    d = {
      name = "LuaDev",
      r = { "Run" },
      l = { "Run Line" },
    },
    g = "Live Grep",
  },
  tc = {
    name = "Telescope",
    t = {
      name = "TreeSitter, Todo",
      s = { "TreeSitter" },
      d = { "Todo" },
    },
    c = {
      name = "Command History",
      h = { "Command History" },
    },
    s = {
      name = "Search History, Symbols",
      h = { "Search History" },
      b = { "Symbols" },
    },
    g = {
      name = "Git",
      c = { "Commits" },
    },
    b = {
      name = "Builtin Pickers",
      i = { "Builtin Pickers" },
    },
  },
  m = {
    name = "Markdown",
    d = {
      name = "Markdown",
      h = {
        name = "Headings",
        ["1"] = { "Heading 1" },
        ["2"] = { "Heading 2" },
        ["3"] = { "Heading 3" },
      },
      pw = { "preview in browser" },
      a = { "add a link" },
      hr = { "add horizontal rule" },
      l = {
        name = "list",
        u = { "unordered list" },
        o = { "ordered list" },
        t = { "task list" },
      },
    },
  },
  g = {
    name = "Git",
    a = "Add",
    c = "Commit",
    d = "Diff",
    l = "Log",
    p = "Push",
    s = "Status",
  },
  h = {
    name = "Help Files",
    p = "Help Files",
  },
  j = { "Move Current line down" },
  k = { "Move Current line up" },
  o = { "Add empty line below" },
  O = { "Add empty line above" },
  i = { "Add space before" },
  a = { "Add space after" },
  n = { "TreeSitter Next Usage" },
  p = { "TreeSitter Previous Usage" },
  q = { "Edit Register(Macro) q" },
  S = { "Substitute in whole File" },
  y = { "Yank to Clipboard" },
  Y = { "Yank File to Clipboard" },
  e = {
    name = "Explore Files",
    s = "Explore in Split",
    f = "Explore Fullscreen",
  },
  d = {
    name = "Distraction Free",
    f = { "Distraction Free" },
  },
  w = { "Write current file" },
  t = {
    name = "Telescope, Trouble, Table Mode, TreeSitter",
    m = "Table Mode",
    t = "Tabelize",
    s = {
      name = "TreeSitter",
      p = {
        name = "Playground Toggle",
        g = "Playground Toggle",
      },
    },
    r = {
      name = "Trouble",
      t = { "Toggle" },
      td = { "Todo" },
      l = {
        name = "Lsp",
        d = { "Diagnostics" },
      },
    },
  },
  u = {
    name = "UndoTree",
    t = "UndotreeToggle",
  },
  s = {
    name = "Substitue",
    s = { "Substitue on current line" },
    G = { "Substitue to the end of the file" },
  },
}, {
  prefix = "<leader>",
  mode = "n",
})
wk.register({
  n = {
    name = "Goto Next, Incremental Selection, List",
    n = { "Incremental Selection" },
    d = { "Goto Definition" },
    D = { "List Definitions" },
    O = { "List Definitions TOC" },
    ["0"] = { "List Lsp Workspace" },
    f = "Start Outer Function",
    i = {
      name = "Inner",
      c = { "Start Call" },
      f = { "Start Function" },
      F = { "End Function" },
      C = { "End Call" },
    },
    F = { "End Outer Function" },
    p = { "Start Inner Parameter" },
    c = { "Start Outer Call" },
    P = { "End Inner Parameter" },
    C = { "End Outer Call" },
  },
  p = {
    name = "Goto Previous",
    f = "Start Outer Function",
    i = {
      name = "Inner",
      c = { "Start Call" },
      f = { "Start Function" },
      F = { "End Function" },
      C = { "End Call" },
    },
    F = { "End Outer Function" },
    p = { "Start Inner Parameter" },
    c = { "Start Outer Call" },
    P = { "End Inner Parameter" },
    C = { "End Outer Call" },
  },
}, {
  prefix = "g",
  mode = "n",
})

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

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "powerline",
    component_separators = { "", "" },
    section_separators = { "", "" },
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})
