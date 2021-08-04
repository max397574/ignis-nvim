return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use("morhetz/gruvbox")
	use("~/jump-ray")
	use("~/mark-ray")
	use("~/vmath.nvim")
	use("~/lua_markdown")
	use("terrortylor/nvim-comment")
	use({ "tweekmonster/startuptime.vim", cmd = { "StartupTime" } })
	use("folke/zen-mode.nvim")
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
	use("rhysd/clever-f.vim")
	use("dhruvasagar/vim-table-mode")
	use("folke/which-key.nvim")
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
				-- list of named colors where we try to extract the guifg from the
				-- list of hilight groups or use the hex color if hl not found as a fallback
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
					-- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
				},
			})
		end,
	})
  use("jiangmiao/auto-pairs")
  use("mg979/vim-visual-multi")
  use("tpope/vim-surround")
  use("mbbill/undotree")
  use("mhinz/vim-signify")
  use("michaelb/sniprun")
  use("sharkdp/bat")
  use("ryanoasis/vim-devicons")
  use("kyazdani42/nvim-web-devicons")
  use({'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
})

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
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
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '‚îÄ', '‚îÇ', '‚îÄ', '‚îÇ', '‚ï≠', '‚ïÆ', '‚ïØ', '‚ï∞' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}

end)
