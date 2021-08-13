local actions = require("telescope.actions")

-- Plugins
-- =======
return require("packer").startup(function(use)
  -- package manager
  use("wbthomason/packer.nvim")

  -- colorschemes
  use("lifepillar/vim-gruvbox8")
  use("shaunsingh/moonlight.nvim")
  use("navarasu/onedark.nvim")
  use("folke/tokyonight.nvim")
  -- statusline
  use({ "hoob3rt/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
  -- stats
  use({ "wakatime/vim-wakatime" })

  -- calculate math figures on visual selection
  use({ "~/vmath.nvim" })

  -- some functions to help with markdown
  use("~/lua_markdown")

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
  use({"folke/twilight.nvim",
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
  use({"folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end,
  })

  -- highlight and search todo comments
  use({"folke/todo-comments.nvim",
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

  -- run snippets of code
  use("michaelb/sniprun")

  -- more icons
  use("ryanoasis/vim-devicons")

  -- even more icons
  use("kyazdani42/nvim-web-devicons")

  -- a file explorer
  use({"nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "sharkdp/bat" },
      { "kyazdani42/nvim-web-devicons" },
    },
  })
  -- telescope extensions
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({ "nvim-telescope/telescope-symbols.nvim" })
  use({ "nvim-telescope/telescope-smart-history.nvim" })

  -- display helpfiles
  use("lvim-tech/lvim-helper")

  -- colorize color codes
  use("norcalli/nvim-colorizer.lua")

  -- completition
  use({ "hrsh7th/nvim-compe" })

  -- easily configure lsp
  use("neovim/nvim-lspconfig")

  -- easy install for lsp servers
  use("kabouzeid/nvim-lspinstall")

  -- colors for lsp diagnostics
  use("folke/lsp-colors.nvim")

  -- list for lsp,quickfix,telescope etc
  use({"folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({
        auto_preview = false, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
      })
    end,
  })

  -- parsers for code
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

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

  -- Settings
  -- ========
  require("telescope").setup({
    defaults = {
      -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
      mappings = {
        n = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-o>"] = actions.select_vertical,
        },
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-o>"] = actions.select_vertical,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = false, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
      },
      history = {
        path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
        limit = 100,
      },
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    },
  })
  require("telescope").load_extension("fzf")
  require("telescope").load_extension("smart_history")

  local home = os.getenv("HOME")
  require("lvim-helper").setup({
    files = {
      home .. "/.config/nvim/vimhelp/treesitter.md",
    },
    winopts = {
      winhl = table.concat({ "Normal:LvimHelperNormal" }, ","),
    },
  })

  require("colorizer").setup({
    "*",
  }, { mode = "foreground" })

  require("compe").setup({
    documentation = {
      min_width = 30,
      max_height = math.floor(vim.o.lines),
    },

    source = {
      path = true,
      buffer = true,
      calc = true,
      nvim_lsp = {
        max_num_results = 5,
        max_line = 100,
      },
      nvim_lua = true,
      vsnip = true,
      ultisnips = true,
      luasnip = true,
      emoji = true,
    },
  })

  require("lspconfig").pyright.setup({
    flags = {
      debounce_text_changes = 500,
    },
  })

  require("lspinstall").setup()

  require("lspconfig").sumneko_lua.setup({
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  })

  -- Refernce: https://github.com/kabouzeid/nvim-lspinstall/wiki
  local lua_settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  }

  local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return {
      -- enable snippet support
      capabilities = capabilities,
      -- map buffer local keybindings when the language server attaches
      on_attach = on_attach,
    }
  end

  local function setup_servers()
    require("lspinstall").setup()

    -- get all installed servers
    local servers = require("lspinstall").installed_servers()
    -- ... and add manually installed servers
    table.insert(servers, "clangd")
    table.insert(servers, "sourcekit")

    for _, server in pairs(servers) do
      local config = make_config()

      -- language specific config
      if server == "lua" then
        config.settings = lua_settings
      end

      require("lspconfig")[server].setup(config)
    end
  end

  setup_servers()

  local wk = require("which-key")

  wk.register({
    tc = {
      name = "Telescope",
      f = {
        name = "Find Files",
        f = { "Find Files" },
      },
      t = {
        name = "TreeSitter, Todo",
        s = { "TreeSitter" },
        d = { "Todo" },
      },
      h = {
        name = "Help Tags",
        t = { "Help Tags" },
      },
      l = {
        name = "Live Grep",
        g = { "Live Grep" },
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
    f = {
      name = "Find Under, Files",
      u = "Find Under",
      f = "Find Files",
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
      name = "Substitue SnipRun",
      s = { "Substitue on current line" },
      G = { "Substitue to the end of the file" },
      r = { "Run Snippet" },
      c = { "Close Snippet Result" },
    },
  }, {
    prefix = "<leader>",
    mode = "n",
  })
  wk.register({
    md = {
      name = "markdown",
      it = { "italic" },
      bd = { "bold" },
    },
  }, {
    prefix = "<leader>",
    mode = "v",
  })

  require("nvim_comment").setup({
    comment_empty = false,
    create_mappings = true,
    line_mapping = "<leader>cc",
    operator_mapping = "<leader>c",
  })

  require("nvim-treesitter.configs").setup({
    ensure_installed = "maintained",
    highlight = {
      enable = true,
      custom_captures = {
        ["variable"] = "TSVariable",
        ["keyword.operator"] = "TSKeywordOperator",
        ["conditional"] = "TSConditional",
        ["number"] = "TSNumber",
        ["float"] = "TSNumber",
        ["operator"] = "TSOperator",
        ["keyword"] = "TSKeyword",
        ["keyword.return"] = "TSKeyword",
        ["string"] = "TSString",
        ["field"] = "TSField",
        ["boolean"] = "TSBoolean",
        ["constant"] = "TSConstant",
        ["property"] = "TSProperty",
        ["repeat"] = "TSRepeat",
        ["keyword.function"] = "TSKeywordFunction",
        ["function"] = "TSFunction",
        ["require_call"] = "RequireCall",
      },
    },
    refactor = {
      highlight_definitions = { enable = true },
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
          goto_next_usage = "<leader>n",
          goto_previous_usage = "<leader>p",
        },
      },
    },
    playground = { enable = true },
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { "BufWrite", "CursorHold", "CursorMoved" },
    },
    indent = {
      enable = true,
    },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = 1000,
    },
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
end)
