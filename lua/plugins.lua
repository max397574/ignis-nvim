local actions = require("telescope.actions")

-- Plugins
-- =======
require("packer").startup({
  function(use)
    -- package manager
    use("wbthomason/packer.nvim")

    -- dimm inactive window
    use("sunjon/shade.nvim")

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
        require("bufferline").setup({
          options = {
            custom_areas = {
              right = function()
                local result = {}
                local error = vim.lsp.diagnostic.get_count(0, [[Error]])
                local warning = vim.lsp.diagnostic.get_count(0, [[Warning]])
                local info = vim.lsp.diagnostic.get_count(0, [[Information]])
                local hint = vim.lsp.diagnostic.get_count(0, [[Hint]])

                if error ~= 0 then
                  table.insert(
                    result,
                    { text = "  " .. error, guifg = "#EC5241" }
                  )
                end

                if warning ~= 0 then
                  table.insert(
                    result,
                    { text = "  " .. warning, guifg = "#EFB839" }
                  )
                end

                if hint ~= 0 then
                  table.insert(
                    result,
                    { text = "  " .. hint, guifg = "#A3BA5E" }
                  )
                end

                if info ~= 0 then
                  table.insert(
                    result,
                    { text = "  " .. info, guifg = "#7EA9A7" }
                  )
                end
                return result
              end,
            },
          },
        })
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
    })
    -- telescope extensions
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use({ "nvim-telescope/telescope-symbols.nvim" })
    use({ "jvgrootveld/telescope-zoxide" })

    -- display helpfiles
    use("lvim-tech/lvim-helper")

    -- colorize color codes
    use("norcalli/nvim-colorizer.lua")

    -- completition
    use({ "hrsh7th/nvim-cmp" })
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
        print("ts loaded")
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
require("shade").setup({
  overlay_opacity = 50,
  opacity_step = 1,
  keys = {
    brightness_up = "<C-Up>",
    brightness_down = "<C-Down>",
    toggle = "<Leader>s",
  },
})
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
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
  },
})
require("telescope").load_extension("fzf")
require("telescope").load_extension("zoxide")

local home = os.getenv("HOME")
require("lvim-helper").setup({
  files = {
    home .. "/.config/nvim/vimhelp/treesitter.md",
    home .. "/.config/nvim/vimhelp/ts_textobjects_move.md",
    home .. "/.config/nvim/vimhelp/ts_textobjects_select.md",
    home .. "/.config/nvim/vimhelp/telescope.md",
    home .. "/.config/nvim/vimhelp/cmp.md",
    home .. "/.config/nvim/vimhelp/latex.md",
  },
  winopts = {
    winhl = table.concat({ "Normal:LvimHelperNormal" }, ","),
  },
})
local lvim_helper_bindings = require("lvim-helper.bindings")
lvim_helper_bindings.bindings = {
  ["J"] = lvim_helper_bindings.lvim_helper_callback("next"),
  ["K"] = lvim_helper_bindings.lvim_helper_callback("prev"),
  ["q"] = lvim_helper_bindings.lvim_helper_callback("close"),
}

require("colorizer").setup({
  "*",
}, { mode = "foreground" })

local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },

  -- You can set mapping if you want.
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },

  sources = {
    { name = "buffer" },
    { name = "path" },
    { name = "emoji" },
    { name = "calc" },
    { name = "nvim_lsp" },
    { name = "ultisnips" },
  },
  formatting = {
    format = function(entry, vim_item)
      local icons = require("configs/lsp_kind").icons
      vim_item.kind = icons[vim_item.kind]
      vim_item.menu = ({
        nvim_lsp = "[L]",
        emoji = "[E]",
        path = "[F]",
        calc = "[C]",
        buffer = "[B]",
        ultisnips = "[U]",
        -- add nvim_lua as well
      })[entry.source.name]
      vim_item.dup = ({
        buffer = 1,
        path = 1,
        nvim_lsp = 1,
      })[entry.source.name] or 0
      return vim_item
    end,
  },
})


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

require("nvim-treesitter.configs").setup({
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    custom_captures = {
      ["require_call"] = "RequireCall",
    },
  },
  incremental_selection = {
    enable = true,

    keymaps = {
      init_selection = "gnn",
      node_incremental = "gnn",
      scope_incremental = "gns",
      node_decremental = "gnp",
    },
  },
  textsubjects = {
    enable = true,
    keymaps = {
      [","] = "textsubjects-smart",
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
  indent = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 1000,
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
        ["icd"] = "@conditional.inner",
        ["acd"] = "@conditional.outer",
        ["acm"] = "@comment.outer",
        ["ast"] = "@statement.outer",
        ["isc"] = "@scopename.inner",
        ["iB"] = "@block.inner",
        ["aB"] = "@block.outer",
        ["p"] = "@parameter.inner",
      },
    },

    move = {
      enable = true,
      set_jumps = true, -- Whether to set jumps in the jumplist
      goto_next_start = {
        ["gnf"] = "@function.outer",
        ["gnif"] = "@function.inner",
        ["gnp"] = "@parameter.inner",
        ["gnc"] = "@call.outer",
        ["gnic"] = "@call.inner",
      },
      goto_next_end = {
        ["gnF"] = "@function.outer",
        ["gniF"] = "@function.inner",
        ["gnP"] = "@parameter.inner",
        ["gnC"] = "@call.outer",
        ["gniC"] = "@call.inner",
      },
      goto_previous_start = {
        ["gpf"] = "@function.outer",
        ["gpif"] = "@function.inner",
        ["gpp"] = "@parameter.inner",
        ["gpc"] = "@call.outer",
        ["gpic"] = "@call.inner",
      },
      goto_previous_end = {
        ["gpF"] = "@function.outer",
        ["gpiF"] = "@function.inner",
        ["gpP"] = "@parameter.inner",
        ["gpC"] = "@call.outer",
        ["gpiC"] = "@call.inner",
      },
    },
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
