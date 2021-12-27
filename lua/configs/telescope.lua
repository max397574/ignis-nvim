vim.cmd([[PackerLoad telescope-fzf-native.nvim]])
vim.cmd([[PackerLoad telescope-symbols.nvim]])

local actions = require("telescope.actions")
local action_layout = require "telescope.actions.layout"
local actions_layout = require("telescope.actions.layout")
local action_state = require("telescope.actions.state")
local themes = require("telescope.themes")
local builtin = require("telescope.builtin")
local tele_utils = require "telescope.utils"
local previewers = require "telescope.previewers"
---@type nvim_config.utils
local utils = require("utils")

local function reloader()
  RELOAD("plenary")
  RELOAD("telescope")
  RELOAD("configs.telescope")
end

local set_prompt_to_entry_value = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  if not entry or not type(entry) == "table" then
    return
  end

  action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

require("telescope").setup({
  defaults = themes.get_ivy({
    -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
    selection_caret = "  ",
    -- layout_strategy = "horizontal",
    selection_strategy = "reset",
    path_display = { "shorten" },
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
        ["<C-y>"] = set_prompt_to_entry_value,
      },
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<c-p>"] = action_layout.toggle_prompt_position,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-y>"] = set_prompt_to_entry_value,
        ["<C-o>"] = actions.select_vertical,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-a>"] = actions.send_to_qflist + actions.open_qflist,
        ["<C-h>"] = "which_key",
        ["<C-l>"] = actions_layout.toggle_preview,
      },
    },
    extensions = {
      file_browser = {
        theme = "ivy",
        mappings = {
          ["i"] = {
            -- your custom insert mode mappings
          },
          ["n"] = {
            -- your custom normal mode mappings
          },
        },
      },
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

local ts = {}

function ts.file_browser()
  reloader()
  require("telescope").load_extension("file_browser")
  local opts

  opts = {
    --   sorting_strategy = "ascending",
    --   scroll_strategy = "cycle",
    --   prompt_prefix = "  ",
    --   layout_config = {
    --     prompt_position = "top",
    --   },
  }

  require("telescope").extensions.file_browser.file_browser(opts)
end

function ts.help_tags()
  reloader()
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
  reloader()
  local opts = {
    -- winblend = 10,
    border = false,
    previewer = false,
    shorten_path = false,
  }
  builtin.lsp_code_actions(themes.get_dropdown(opts))
end

function ts.find_string()
  reloader()
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
  reloader()
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
  reloader()
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
  reloader()
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
  reloader()
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

  -- buffer number and name
  local bufnr = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(bufnr)

  local previewer

  -- in case its not a normal buffer
  if vim.fn.buflisted(bufnr) ~= 1 then
    local deleted = false
    local function del_win(win_id)
      if win_id and vim.api.nvim_win_is_valid(win_id) then
        tele_utils.buf_delete(vim.api.nvim_win_get_buf(win_id))
        pcall(vim.api.nvim_win_close, win_id, true)
      end
    end

    previewer = previewers.new {
      preview_fn = function(_, entry, status)
        if not deleted then
          deleted = true
          del_win(status.preview_win)
          del_win(status.preview_border_win)
        end
        require("colors").init(entry.value)
      end,
    }
  else
    -- show current buffer content in previewer
    previewer = previewers.new_buffer_previewer {
      define_preview = function(self, entry)
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
        local filetype = require("plenary.filetype").detect(bufname) or "diff"

        require("telescope.previewers.utils").highlighter(self.state.bufnr, filetype)
        require("colors").init(entry.value)
      end,
    }
  end

  pickers.new(opts, {
    prompt_title = "Base 16 Colorschemes",
    layout_strategy = "flex",
    finder = finders.new_table(opts.data),
    sorter = conf.generic_sorter(opts),
    previewer = previewer,
    attach_mappings = function(_, map)
      map("i", "<CR>", custom_action)
      map("n", "<CR>", custom_action)
      return true
    end,
  }):find()
end

function ts.colorschemes()
  reloader()
  vim.cmd([[PackerLoad colorschemes]])
  vim.cmd([[PackerLoad colorscheme_switcher]])
  local opts = {
    data = utils.get_themes()
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
