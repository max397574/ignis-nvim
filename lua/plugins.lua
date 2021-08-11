local actions = require('telescope.actions')

-- ===Plugins===
return require("packer").startup(function(use)
  -- stylua: ignore start
  -- package manager
  use("wbthomason/packer.nvim")

  -- colorscheme
  use("lifepillar/vim-gruvbox8")
  -- stats
  use({"wakatime/vim-wakatime"})

  -- calculate math figures on visual selection
  use({"~/vmath.nvim"})

  -- some functions to help with markdown
  use("~/lua_markdown")

  -- easily comment out code
  use("terrortylor/nvim-comment")

  -- breakup of startup time
  use({ "tweekmonster/startuptime.vim"})

  -- more commands can be repeated with `.`
  use({"tpope/vim-repeat"})

  -- snippets
  use ({"SirVer/ultisnips"})
  use ({"honza/vim-snippets"})

  -- Git from Vim
  use ({"tpope/vim-fugitive"})

  -- see git commits
  use ({"junegunn/gv.vim"})

  -- distraction free writing
  use({"folke/zen-mode.nvim"})

  -- dimm inactive parts of code
  use({"folke/twilight.nvim",
    config = function()
      require("twilight").setup({
        dimming = {
          alpha = 0.25, -- amount of dimming
          color = { "Normal", "#ffffff" },
        },
        context = 20, -- amount of lines we will try to show around the current line
        expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
          "function",
          "method",
          "table",
          "if_statement",
        },
        exclude = {}, -- exclude these filetypes
      })
    end,
  })

  -- easier use of f/F and t/T
  use("rhysd/clever-f.vim")

  -- easily create md tables
  use({"dhruvasagar/vim-table-mode"})

  -- display keybindings help
  use({"folke/which-key.nvim",
    config = function()
      require("which-key").setup({
        {
          plugins = {
            marks = true,
            registers = true,
            spelling = {
              enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
              suggestions = 20, -- how many suggestions should be shown in the list?
            },
            presets = {
              operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
              motions = true, -- adds help for motions
              text_objects = true, -- help for text objects triggered after entering an operator
              windows = true, -- default bindings on <c-w>
              nav = true, -- misc bindings to work with windows
              z = true, -- bindings for folds, spelling and others prefixed with z
              g = true, -- bindings for prefixed with g
            },
          },
          operators = { gc = "Comments" },
          key_labels = {
          },
          icons = {
            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
            separator = "➜", -- symbol used between a key and it's label
            group = "+", -- symbol prepended to a group
          },
          window = {
            border = "none", -- none, single, double, shadow
            position = "bottom", -- bottom, top
            margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
            padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
          },
          layout = {
            height = { min = 4, max = 25 }, -- min and max height of the columns
            width = { min = 20, max = 50 }, -- min and max width of the columns
            spacing = 3, -- spacing between columns
            align = "left", -- align columns left, center or right
          },
          ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
          hidden = {
            "<silent>",
            "<cmd>",
            "<Cmd>",
            "<CR>",
            "call",
            "lua",
            "^:",
            "^ ",
          }, -- hide mapping boilerplate
          show_help = true, -- show help message on the command line when the popup is visible
          triggers = "auto", -- automatically setup triggers
          -- triggers = {"<leader>"} -- or specify a list manually
          triggers_blacklist = {
            -- list of mode / prefixes that should never be hooked by WhichKey
            -- this is mostly relevant for key maps that start with a native binding
            -- most people should not need to change this
            i = { "j", "k" },
            v = { "j", "k" },
          },
        },
      })
    end,
  })

  -- highlight and search todo comments
  use({"folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({
        signs = true, -- show icons in the signs column
        sign_priority = 8, -- sign priority
        -- keywords recognized as todo comments
        keywords = {
          FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        },
        merge_keywords = true, -- when true, custom keywords will be merged with the defaults
        -- highlighting of the line containing the todo comment
        -- * before: highlights before the keyword (typically comment characters)
        -- * keyword: highlights of the keyword
        -- * after: highlights after the keyword (todo text)
        highlight = {
          before = "", -- "fg" or "bg" or empty
          keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
          after = "fg", -- "fg" or "bg" or empty
          pattern = [[.*<(KEYWORDS)\s*:]], -- pattern used for highlightng (vim regex)
          comments_only = true, -- uses treesitter to match keywords in comments only
          max_line_len = 400, -- ignore lines longer than this
          exclude = {}, -- list of file types to exclude highlighting
        },
        colors = {
          error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
          warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24" },
          info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
          hint = { "LspDiagnosticsDefaultHint", "#10B981" },
          default = { "Identifier", "#7C3AED" },
        },
        search = {
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          -- regex that will be used to match keywords.
          -- don't replace the (KEYWORDS) placeholder
          pattern = [[\b(KEYWORDS):]], -- ripgrep regex
        },
      })
    end,
  })

  -- automatically match parantheses etc
  use({"jiangmiao/auto-pairs"})

  -- multiple cursors
  use("mg979/vim-visual-multi")

  -- change,add and delete surroundings
  use("tpope/vim-surround")

  -- display last undos
  use({"mbbill/undotree"})

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
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {'nvim-telescope/telescope-symbols.nvim'}
  use {'nvim-telescope/telescope-smart-history.nvim'}

  -- display helpfiles
  use("lvim-tech/lvim-helper")

  -- colorize color codes
  use("norcalli/nvim-colorizer.lua")

  -- completition
  use({"hrsh7th/nvim-compe"})

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
        position = "bottom", -- position of the list can be: bottom, top, left, right
        height = 10, -- height of the trouble list when position is top or bottom
        width = 50, -- width of the list when position is left or right
        icons = true, -- use devicons for filenames
        mode = "lsp_workspace_diagnostics", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
        fold_open = "Ôëº", -- icon used for open folds
        fold_closed = "Ôë†", -- icon used for closed folds
        action_keys = { -- key mappings for actions in the trouble list
          -- map to {} to remove a mapping, for example:
          -- close = {},
          close = "q", -- close the list
          cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
          refresh = "r", -- manually refresh
          jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
          open_split = { "<c-x>" }, -- open buffer in new split
          open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
          open_tab = { "<c-t>" }, -- open buffer in new tab
          jump_close = { "o" }, -- jump to the diagnostic and close the list
          toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
          toggle_preview = "P", -- toggle auto_preview
          hover = "K", -- opens a small popup with the full multiline message
          preview = "p", -- preview the diagnostic location
          close_folds = { "zM", "zm" }, -- close all folds
          open_folds = { "zR", "zr" }, -- open all folds
          toggle_fold = { "zA", "za" }, -- toggle fold of current file
          previous = "k", -- preview item
          next = "j", -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false, -- automatically fold a file trouble list at creation
        signs = {
          -- icons / text used for a diagnostic
          error = "Ôôô",
          warning = "Ôî©",
          hint = "Ô†µ",
          information = "Ôëâ",
          other = "Ô´†",
        },
        use_lsp_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
      })
    end,
  })

  -- parsers for code
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

  -- refractor code with TS
  use("nvim-treesitter/nvim-treesitter-refactor")

  -- structural editing with ts queries
  use ("vigoux/architext.nvim")

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

  -- stylua: ingore end

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
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = false, -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        }
      },
      history = {
        path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
        limit = 100,
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = "> ",
      selection_caret = "> ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          mirror = false,
        },
        vertical = {
          mirror = false,
        },
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = {},
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      use_less = true,
      path_display = {},
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    },
  })
  require('telescope').load_extension('fzf')
  require('telescope').load_extension('smart_history')

  local home = os.getenv("HOME")
  require("lvim-helper").setup({
    files = {
      home .. "/.config/nvim/vimhelp/treesitter.md",
    },
    width = 80,
    side = "right",
    current_file = 1,
    winopts = {
      relativenumber = false,
      number = false,
      list = false,
      winfixwidth = true,
      winfixheight = true,
      foldenable = false,
      spell = false,
      signcolumn = "no",
      foldmethod = "manual",
      foldcolumn = "0",
      cursorcolumn = false,
      colorcolumn = "0",
      wrap = false,
      winhl = table.concat({ "Normal:LvimHelperNormal" }, ","),
    },
    bufopts = {
      swapfile = false,
      buftype = "nofile",
      modifiable = false,
      filetype = "LvimHelper",
      bufhidden = "hide",
    },
  })

  require("colorizer").setup({
    "*",
  }, { mode = "foreground" })

  require("compe").setup({
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    resolve_timeout = 800,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = {
      border = { "", "", "", " ", "", "", "", " " }, -- the border option is the same as `|help nvim_open_win|`
      winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
      max_width = 120,
      min_width = 30,
      max_height = math.floor(vim.o.lines),
      min_height = 1,
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
        t = {"Help Tags"},
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
        c = {"Commits"},
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
      s = "Status"
    },
    h = {
      name = "Help Files",
      p = "Help Files",
    },
    f = {
      name = "Find Under",
      u = "Find Under"
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
    -- Linters prefer comment and line to have a space in between markers
    marker_padding = true,
    -- should comment out empty or whitespace only lines
    comment_empty = false,
    -- Should key mappings be created
    create_mappings = true,
    -- Normal mode mapping left hand side
    line_mapping = "<leader>cc",
    -- Visual/Operator mapping left hand side
    operator_mapping = "<leader>c",
  })

  require("nvim-treesitter.configs").setup({
    ensure_installed = "maintained",
    highlight = {
      enable = true,
      --disable = { "c", "rust" },  -- list of language that will be disabled
      custom_captures = {
        -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
        --["foo.bar"] = "Identifier",
        ["variable"] = "YellowVariable",
        ["keyword.operator"] = "RedConditional",
        ["conditional"] = "RedConditional",
        ["number"] = "BlueNumber",
        ["float"] = "BlueNumber",
        ["operator"] = "BlueOperator",
        ["keyword"] = "ItalicRed",
        ["keyword.return"] = "ItalicRed",
        ["string"] = "LightBlueConstant",
        ["field"] = "GreenString",
        ["boolean"] = "PurpleBoolean",
        ["constant"] = "LightBlueConstant",
        ["property"] = "LightBlueConstant",
        ["repeat"] = "RedLoops",
        ["keyword.function"] = "RedLoops",
        ["function"] = "GreenFunction",
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
    textobjects = {
      lsp_interop = {
        enable = true,
        border = "none",
        peek_definition_code = {
          ["df"] = "@function.outer",
          ["dF"] = "@class.outer",
        },
      },
      select = {
        enable = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/blob/master/queries/python/textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",

          -- Or you can define your own textobjects like this
          --["iF"] = {
          --python = "(function_definition) @function",
          --cpp = "(function_definition) @function",
          --c = "(function_definition) @function",
          --java = "(method_declaration) @function",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["gsp"] = "@parameter.inner",
          ["gsf"] = "@function.outer",
        },
        swap_previous = {
          ["gsP"] = "@parameter.inner",
          ["gsF"] = "@function.outer",
        },
      },
      move = {
        enable = false,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
    },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<CR>",
        show_help = "?",
      },
    },
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { "BufWrite", "CursorHold", "CursorMoved" },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    indent = {
      enable = true,
    },
    textsubjects = {
      enable = true,
      keymaps = {
        ["."] = "textsubjects-smart",
        [";"] = "textsubjects-container-outer",
      },
    },
    rainbow = {
      enable = true,
      extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
      max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
      --colors = {}, -- table of hex strings
      --termcolors = {}, -- table of colour name strings
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
end)
