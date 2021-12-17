vim.cmd([[PackerLoad telescope-fzf-native.nvim]])
vim.cmd([[PackerLoad telescope-symbols.nvim]])
vim.cmd([[PackerLoad telescope-zoxide]])
vim.cmd([[PackerLoad telescope-frecency.nvim]])
vim.cmd([[PackerLoad telescope-luasnip.nvim]])
vim.cmd([[PackerLoad sqlite.lua]])

local actions = require("telescope.actions")
local actions_layout = require("telescope.actions.layout")
local action_state = require("telescope.actions.state")
local themes = require("telescope.themes")
local builtin = require("telescope.builtin")
---@type nvim_config.utils
local utils = require("utils")

require("telescope").setup({
  defaults = themes.get_ivy({
    -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
    selection_caret = "  ",
    -- layout_strategy = "horizontal",
    selection_strategy = "reset",
    -- file_ignore_patterns = { "^.git" },
    -- prompt_prefix = " ",
    prompt_prefix = "  ",
    shorten_path = true,
    preview = {
      hide_on_startup = true,
    },
    entry_prefix = " ",
    layout_config = {
      width = 0.99,
      height = 0.5,
      preview_cutoff = 20,
      prompt_position = "top",
      horizontal = {
        preview_width = 0.65,
        -- preview_width = function(_, cols, _)
        --   if cols > 200 then
        --     return math.floor(cols * 0.5)
        --   else
        --     return math.floor(cols * 0.6)
        --   end
        -- end,
      },
      vertical = {
        preview_width = 0.65,
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },

      flex = {
        preview_width = 0.65,
        horizontal = {
          -- preview_width = 0.9,
        },
      },
    },
    -- winblend = 20,
    mappings = {
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-o>"] = actions.select_vertical,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-a>"] = actions.send_to_qflist + actions.open_qflist,
        ["<C-h>"] = "which_key",
        ["<C-l>"] = actions_layout.toggle_preview,
      },
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-o>"] = actions.select_vertical,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-a>"] = actions.send_to_qflist + actions.open_qflist,
        ["<C-h>"] = "which_key",
        ["<C-l>"] = actions_layout.toggle_preview,
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
  }),
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
  local opts = themes.get_ivy({
    initial_mode = "insert",
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
      preview_width = 0.75,
      -- horizontal = {
      --   preview_width = 0.55,
      --   results_width = 0.8,
      -- },
      -- vertical = {
      --   mirror = false,
      -- },
      -- width = 0.87,
      height = 0.6,
    },
    preview = {
      preview_cutoff = 120,
      preview_width = 80,
      hide_on_startup = false,
    },
  })
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
  local opts = themes.get_ivy({
    border = true,
    shorten_path = false,
    -- layout_strategy = "flex",
    layout_config = {
      width = 0.99,
      height = 0.5,
      prompt_position = "top",
      -- horizontal = { width = { padding = 0.05 } },
      -- vertical = { preview_height = 0.75 },
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
    preview = {
      hide_on_startup = false,
    },
  })
  -- winblend = 15,
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
  local opts = themes.get_ivy({
    -- winblend = 10,
    -- border = false,
    -- previewer = false,
    shorten_path = false,
    prompt_position = "top",
    layout_config = { prompt_position = "top", height = 0.4 },
  })
  require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

function ts.git_diff()
  local opts = {
    -- layout_strategy = "horizontal",
    border = true,
    prompt_title = "~ Git Diff ~",
    layout_config = {
      width = 0.99,
      height = 0.69,
      preview_width = 0.7,
      prompt_position = "top",
    },
    preview = {
      hide_on_startup = false,
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
      "classic-dark",
      "doom-chad",
      "everforest",
      "gruvbox",
      "gruvchad",
      "javacafe",
      "jellybeans",
      "lfgruv",
      "monokai",
      "mountain",
      "nord",
      "one-light",
      "onedark",
      "onedark-deep",
      "onejelly",
      "onenord",
      "palenight",
      "penokai",
      "solarized",
      "tokyonight",
      "tomorrow-night",
      "uwu",
    },
  }
  base_16_finder(themes.get_ivy(opts))
end

local filetypes = {
  ["typescript  "] = "typescript",
  ["python  "] = "python",
  ["java  "] = "java",
  ["html  "] = "html",
  ["css  "] = "css",
  ["javascript  "] = "javascript",
  ["javascriptreact  "] = "javascriptreact",
  ["markdown  "] = "markdown",
  ["sh  "] = "sh",
  ["zsh  "] = "zsh",
  ["vim  "] = "vim",
  ["rust  "] = "rust",
  ["cpp  "] = "cpp",
  ["c  "] = "c",
  ["go  "] = "go",
  ["lua  "] = "lua",
  ["conf  "] = "conf",
  ["haskel  "] = "haske",
  ["ruby  "] = "ruby",
  ["txt  "] = "txt",
}

local filetype_names = {
  "html  ",
  "css  ",
  "javascript  ",
  "javascriptreact  ",
  "markdown  ",
  "sh  ",
  "zsh  ",
  "vim  ",
  "rust  ",
  "cpp  ",
  "c  ",
  "go  ",
  "lua  ",
  "conf  ",
  "haskel  ",
  "ruby  ",
  "txt  ",
  "typescript  ",
  "python  ",
  "java  ",
}

local function temp_files(opts)
  opts = opts or {}
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local custom_action = function()
    local entry = action_state.get_selected_entry()
    if entry ~= nil then
      print("entry:")
      dump(entry)
      dump(filetypes[entry[1]])
      local buf = vim.api.nvim_create_buf(false, true)
      -- vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
      vim.api.nvim_buf_set_keymap(
        buf,
        "n",
        "q",
        "<cmd>q<CR>",
        { noremap = true, silent = true, nowait = true }
      )
      local width = vim.api.nvim_win_get_width(0)
      local height = vim.api.nvim_win_get_height(0)
      local win = vim.api.nvim_open_win(buf, true, {
        relative = "win",
        win = 0,
        width = math.floor(80),
        height = math.floor(20),
        col = math.floor(3),
        row = math.floor(3),
        -- border = "shadow",
        border = "single",
        style = "minimal",
      })
      vim.api.nvim_buf_set_option(buf, "filetype", filetypes[entry[1]])
      vim.api.nvim_win_set_option(win, "winblend", 10)
    end
    vim.fn.feedkeys(utils.t("<ESC><ESC>"), "i")
  end

  pickers.new(opts, {
    prompt_title = "Create temporary files",
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

function ts.temporary_files()
  temp_files({ data = filetype_names })
end

return ts
