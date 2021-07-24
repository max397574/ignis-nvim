vim.api.nvim_exec(
[[
call plug#begin('~/.vim/plugged')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'RRethy/nvim-treesitter-textsubjects'
Plug 'nvim-treesitter/playground'
Plug 'romgrk/nvim-treesitter-context'
Plug 'p00f/nvim-ts-rainbow'
call plug#end()
]],
true)
-- so $VIMRUNTIME/syntax/hitest.vim to see colors

require'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained',
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
      border = 'none',
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
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<CR>',
      show_help = '?',
    },
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = {"BufWrite", "CursorHold", "CursorMoved"},
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
    enable = true
  },
  textsubjects = {
        enable = true,
        keymaps = {
            ['.'] = 'textsubjects-smart',
            [';'] = 'textsubjects-container-outer',
        },
    },
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
    --colors = {}, -- table of hex strings
    --termcolors = {}, -- table of colour name strings
  },
}

require'treesitter-context.config'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
}
