vim.cmd([[PackerLoad telescope-fzf-native.nvim]])
vim.cmd([[PackerLoad telescope-symbols.nvim]])
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local ts = {}

local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local actions_layout = require("telescope.actions.layout")
local action_state = require("telescope.actions.state")
local themes = require("telescope.themes")
local builtin = require("telescope.builtin")
local tele_utils = require("telescope.utils")
local previewers = require("telescope.previewers")
---@type nvim_config.utils
local utils = require("utils")

local resolve = require("telescope.config.resolve")
local p_window = require("telescope.pickers.window")
local if_nil = vim.F.if_nil

local calc_tabline = function(max_lines)
  local tbln = (vim.o.showtabline == 2)
    or (vim.o.showtabline == 1 and #vim.api.nvim_list_tabpages() > 1)
  if tbln then
    max_lines = max_lines - 1
  end
  return max_lines, tbln
end

local get_border_size = function(opts)
  if opts.window.border == false then
    return 0
  end

  return 1
end

local calc_size_and_spacing =
  function(cur_size, max_size, bs, w_num, b_num, s_num)
    local spacing = s_num * (1 - bs) + b_num * bs
    cur_size = math.min(cur_size, max_size)
    cur_size = math.max(cur_size, w_num + spacing)
    return cur_size, spacing
  end

local function set_options()
  require("telescope.pickers.layout_strategies").custom_bottom =
    function(self, max_columns, max_lines, layout_config)
      local initial_options = p_window.get_initial_window_options(self)
      local results = initial_options.results
      local prompt = initial_options.prompt
      local preview = initial_options.preview
      layout_config = {
        anchor = "S",
        bottom_pane = {
          height = 0.5,
          preview_cutoff = 20,
          prompt_position = "top",
        },
        custom_bottom = {
          height = 0.5,
          preview_cutoff = 20,
          prompt_position = "top",
        },
        center = {
          height = 0.5,
          preview_cutoff = 20,
          prompt_position = "top",
          width = 0.99,
        },
        cursor = {
          height = 0.5,
          preview_cutoff = 20,
          width = 0.99,
        },
        flex = {
          horizontal = {},
          preview_width = 0.65,
        },
        height = 0.5,
        horizontal = {
          height = 0.5,
          preview_cutoff = 20,
          preview_width = 0.65,
          prompt_position = "top",
          width = 0.99,
        },
        preview_cutoff = 20,
        prompt_position = "top",
        vertical = {
          height = 0.95,
          preview_cutoff = 20,
          preview_height = 0.5,
          preview_width = 0.65,
          prompt_position = "top",
          width = 0.9,
        },
        width = 0.99,
      }

      local tbln
      max_lines, tbln = calc_tabline(max_lines)

      local height = if_nil(
        resolve.resolve_height(layout_config.height)(
          self,
          max_columns,
          max_lines
        ),
        25
      )
      local width_opt = layout_config.width

      local width = resolve.resolve_width(width_opt)(
        self,
        max_columns,
        max_lines
      )

      -- local height = 21
      if
        type(layout_config.height) == "table"
        and type(layout_config.height.padding) == "number"
      then
        -- Since bottom_pane only has padding at the top, we only need half as much padding in total
        -- This doesn't match the vim help for `resolve.resolve_height`, but it matches expectations
        height = math.floor((max_lines + height) / 2)
      end
      prompt.border = results.border

      local bs = get_border_size(self)

      -- Cap over/undersized height
      height, _ = calc_size_and_spacing(height, max_lines, bs, 2, 3, 0)

      -- Height
      prompt.height = 2
      results.height = height - prompt.height - (2 * bs)
      preview.height = results.height - bs

      -- Width
      local w_space

      preview.width = 0
      prompt.width = max_columns - 2 * bs
      if self.previewer and max_columns >= layout_config.preview_cutoff then
        -- Cap over/undersized width (with preview)
        width, w_space = calc_size_and_spacing(
          max_columns,
          max_columns,
          bs,
          2,
          4,
          0
        )

        preview.width = resolve.resolve_width(
          if_nil(layout_config.preview_width, 0.5)
        )(self, width, max_lines)
        results.width = width - preview.width - w_space
        prompt.width = results.width
        results.width = results.width
      else
        width, w_space = calc_size_and_spacing(width, max_columns, bs, 1, 2, 0)
        preview.width = 0
        results.width = width - preview.width - w_space
        prompt.width = results.width
      end

      -- Line
      if layout_config.prompt_position == "top" then
        prompt.line = max_lines - results.height - (1 + bs) + 1
        results.line = prompt.line + 1
        preview.line = prompt.line + 1
        if results.border == true then
          results.border = { 0, 1, 1, 1 }
        end
        if type(results.title) == "string" then
          results.title = { { pos = "S", text = results.title } }
        end
      elseif layout_config.prompt_position == "bottom" then
        results.line = max_lines - results.height - (1 + bs) + 1
        preview.line = results.line
        prompt.line = max_lines - bs
        if type(prompt.title) == "string" then
          prompt.title = { { pos = "S", text = prompt.title } }
        end
        if results.border == true then
          results.border = { 1, 1, 0, 1 }
        end
      else
        error(
          "Unknown prompt_position: "
          .. tostring(self.window.prompt_position)
          .. "\n"
          .. vim.inspect(layout_config)
        )
      end
      local width_padding = math.floor((max_columns - width) / 2)

      -- Col
      prompt.col = 0 -- centered
      if layout_config.mirror and preview.width > 0 then
        results.col = preview.width + (3 * bs)
        preview.col = bs + 1
        prompt.col = results.col
      else
        preview.col = prompt.width + width_padding + bs + 1

        results.col = bs + 1
        prompt.col = preview.col + preview.width + bs
      end

      if tbln then
        prompt.line = prompt.line + 1
        results.line = results.line + 1
        preview.line = preview.line
      end
      results.line = results.line + 2
      results.height = results.height - 1
      preview.col = preview.col + 1
      preview.height = preview.height + 1
      prompt.col = 1
      preview.height = prompt.height + results.height
      preview.title = "~ Preview ~"
      results.title = { {
        pos = "S",
        text = "~ Results ~",
      } }
      results.col = 2

      return {
        preview = self.previewer and preview.width > 0 and preview,
        prompt = prompt,
        results = results,
      }
    end
end

local function reloader()
  RELOAD("plenary")
  RELOAD("telescope")
  set_options()
  RELOAD("configs.telescope")
  set_options()
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
    get_status_text = function(self)
      -- local xx = (self.stats.processed or 0) - (self.stats.filtered or 0)
      -- local yy = self.stats.processed or 0
      -- if xx == 0 and yy == 0 then
      --   return ""
      -- end
      --
      -- -- local status_icon
      -- -- if opts.completed then
      -- --   status_icon = "✔️"
      -- -- else
      -- --   status_icon = "*"
      -- -- end
      -- return string.format("%s / %s", xx, yy)
      return ""
    end,
    -- layout_strategy = "horizontal",
    layout_strategy = "custom_bottom",
    selection_strategy = "reset",
    -- layout_strategy = layout_strategies.bottom_pane,
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
      -- anchor = "S",
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
        ["<C-d>"] = actions.preview_scrolling_up,
        ["<C-f>"] = actions.preview_scrolling_down,
        ["<C-n>"] = require("telescope.actions").cycle_history_next,
        ["<C-u>"] = require("telescope.actions").cycle_history_prev,
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
        ["<C-d>"] = actions.preview_scrolling_up,
        ["<C-f>"] = actions.preview_scrolling_down,
        ["<C-n>"] = require("telescope.actions").cycle_history_next,
        ["<C-u>"] = require("telescope.actions").cycle_history_prev,
      },
    },
    extensions = {
      file_browser = {
        -- theme = "ivy",
        mappings = {
          ["i"] = {},
          ["n"] = {},
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

function ts.find_notes()
  reloader()
  local opts = {
    cwd = "~/notes",
    prompt_title = "~ Notes ~",
  }
  require("telescope.builtin").find_files(opts)
end

function ts.search_config()
  reloader()
  local opts = {
    cwd = "~/.config/nvim_config",
    prompt_title = "~ Neovim Config ~",
  }
  require("telescope.builtin").find_files(opts)
end

function ts.help_tags()
  reloader()
  -- local opts = themes.get_ivy({
  local opts = {
    prompt_title = "~ Help Tags ~",
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
  }
  builtin.help_tags(opts)
end

function ts.code_actions()
  reloader()
  local opts = {
    -- winblend = 10,
    prompt_title = "~ Code Actions ~",
    border = false,
    previewer = false,
    shorten_path = false,
  }
  builtin.lsp_code_actions(themes.get_dropdown(opts))
end

function ts.find_string()
  reloader()
  -- local opts = themes.get_ivy({
  local opts = {
    border = true,
    shorten_path = false,
    prompt_title = "~ Live Grep ~",
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
  }
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
  opts.prompt_title = "~ Last Search Grep ~"

  require("telescope.builtin").grep_string(opts)
end

function ts.curbuf()
  reloader()
  -- local opts = themes.get_ivy({
  local opts = {
    -- winblend = 10,
    -- border = false,
    -- previewer = false,
    shorten_path = false,
    prompt_position = "top",
    prompt_title = "~ Current Buffer ~",
    layout_config = { prompt_position = "top", height = 0.4 },
  }
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

    previewer = previewers.new({
      preview_fn = function(_, entry, status)
        if not deleted then
          deleted = true
          del_win(status.preview_win)
          del_win(status.preview_border_win)
        end
        require("colors").init(entry.value)
      end,
    })
  else
    -- show current buffer content in previewer
    previewer = previewers.new_buffer_previewer({
      define_preview = function(self, entry)
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
        local filetype = require("plenary.filetype").detect(bufname) or "diff"

        require("telescope.previewers.utils").highlighter(
          self.state.bufnr,
          filetype
        )
        require("colors").init(entry.value)
      end,
    })
  end

  pickers.new(opts, {
    prompt_title = "~ Base 16 Colorschemes ~",
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

function ts.find_files()
  reloader()
  local opts = {
    prompt_title = "~ Find Files ~",
    find_command = { "rg", "-g", "!.git", "--files", "--hidden", "--no-ignore" },
    layout_config = {
      prompt_position = "top",
    },
  }
  require("telescope.builtin").find_files(opts)
end

function ts.colorschemes()
  reloader()
  local opts = {
    data = utils.get_themes(),
  }
  base_16_finder(opts)
end

return ts
