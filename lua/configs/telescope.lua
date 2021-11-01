vim.cmd([[PackerLoad telescope-fzf-native.nvim]])
vim.cmd([[PackerLoad telescope-symbols.nvim]])
vim.cmd([[PackerLoad telescope-zoxide]])
vim.cmd([[PackerLoad telescope-frecency.nvim]])
vim.cmd([[PackerLoad telescope-luasnip.nvim]])
vim.cmd([[PackerLoad sqlite.lua]])

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local themes = require("telescope.themes")
local builtin = require("telescope.builtin")
local utils = require("utils")

require("telescope").setup({
  defaults = {
    -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.99,
      height = 0.99,
      preview_cutoff = 90,
      prompt_position = "bottom",
      horizontal = {
        preview_width = function(_, cols, _)
          if cols > 200 then
            return math.floor(cols * 0.5)
          else
            return math.floor(cols * 0.6)
          end
        end,
      },
      vertical = {
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },

      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
    },
    winblend = 20,
    mappings = {
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-o>"] = actions.select_vertical,
        -- alt j and k
        ["º"] = actions.preview_scrolling_down,
        ["∆"] = actions.preview_scrolling_up,
      },
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-o>"] = actions.select_vertical,
        ["º"] = actions.preview_scrolling_down,
        ["∆"] = actions.preview_scrolling_up,
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
require("telescope").load_extension("frecency")
require("telescope").load_extension("luasnip")

local ts = {}

function ts.file_browser()
  local opts

  opts = {
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    prompt_prefix = "  ",
    layout_config = {
      prompt_position = "top",
    },
    file_ignore_patterns = { "vendor/*" },

    attach_mappings = function(prompt_bufnr, map)
      local current_picker = action_state.get_current_picker(prompt_bufnr)

      local modify_cwd = function(new_cwd)
        current_picker.cwd = new_cwd
        current_picker:refresh(
          opts.new_finder(new_cwd),
          { reset_prompt = true }
        )
      end

      map("i", "-", function()
        modify_cwd(current_picker.cwd .. "/..")
      end)

      map("i", "~", function()
        modify_cwd(vim.fn.expand("~"))
      end)

      local modify_depth = function(mod)
        return function()
          opts.depth = opts.depth + mod

          local this_picker = action_state.get_current_picker(prompt_bufnr)
          this_picker:refresh(
            opts.new_finder(current_picker.cwd),
            { reset_prompt = true }
          )
        end
      end

      -- alt =
      map("i", "Ú", modify_depth(1))
      -- alt +
      map("i", "∞", modify_depth(-1))

      map("n", "yy", function()
        local entry = action_state.get_selected_entry()
        vim.fn.setreg("+", entry.value)
      end)

      return true
    end,
  }

  builtin.file_browser(opts)
end

function ts.help_tags()
  local opts = {
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
  }
  builtin.help_tags(opts)
end

function ts.code_actions()
  local opts = {
    -- winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }
  builtin.lsp_code_actions(themes.get_dropdown(opts))
end

function ts.find_string()
  local opts = {
    border = true,
    shorten_path = false,
    layout_strategy = "flex",
    layout_config = {
      width = 0.99,
      height = 0.8,
      horizontal = { width = { padding = 0.05 } },
      vertical = { preview_height = 0.75 },
    },
    file_ignore_patterns = {
      "vendor/*",
      "node_modules",
      "%.jpg",
      "%.jpeg",
      "%.png",
      "%.svg",
      "%.otf",
      "%.ttf",
    },
    -- winblend = 15,
  }
  builtin.live_grep(opts)
end

function ts.grep_last_search(opts)
  opts = opts or {}

  -- \<getreg\>\C
  -- -> Subs out the search things
  local register = vim.fn.getreg("/")
    :gsub("\\<", "")
    :gsub("\\>", "")
    :gsub("\\C", "")

  opts.path_display = { "shorten" }
  opts.word_match = "-w"
  opts.search = register

  require("telescope.builtin").grep_string(opts)
end

function ts.curbuf()
  local opts = themes.get_dropdown({
    -- winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  })
  require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

function ts.git_diff()
  local opts = {
    layout_strategy = "horizontal",
    border = true,
    prompt_title = "~ Git Diff ~",
    layout_config = {
      width = 0.99,
      height = 0.99,
      preview_width = 0.8,
      prompt_position = "top",
    },
  }
  require("telescope.builtin").git_status(opts)
end

local function base_16_finder(opts)
  opts = opts or {}
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local custom_action = function()
    local entry = action_state.get_selected_entry()
    if entry ~= nil then
      require("colors").init(entry[1])
      require("colorscheme_switcher").new_scheme()
    end
    vim.fn.feedkeys(utils.t("<ESC><ESC>"), "i")
  end

  pickers.new(opts, {
    prompt_title = "Base 16 Colorschemes",
    layout_strategy = "flex",
    finder = finders.new_table(opts.data),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(_, map)
      map("i", "<CR>", custom_action)
      map("n", "<CR>", custom_action)
      return true
    end,
  }):find()
end

function ts.colorschemes()
  local opts = {
    data = {
      "aquarium",
      "blossom",
      "chadracula",
      "doom-chad",
      "everforest",
      "gruvbox",
      "gruvchad",
      "javacafe",
      "jellybeans",
      "lfgruv",
      "mountain",
      "nord",
      "one-light",
      "onedark",
      "onedark-deep",
      "onejelly",
      "onenord",
      "tokyonight",
      "xterm",
      "tomorrow-night",
      "uwu",
    },
  }
  base_16_finder(opts)
end

return ts
