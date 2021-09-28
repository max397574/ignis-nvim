local actions = require "telescope.actions"
require("telescope").setup {
  defaults = {
    -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.90,
      height = 0.85,
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
}
require("telescope").load_extension "fzf"
require("telescope").load_extension "zoxide"

local M = {}
local themes = require "telescope.themes"
local builtin = require "telescope.builtin"
function M.code_actions()
  local opts = {
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }
  builtin.lsp_code_actions(themes.get_dropdown(opts))
end
return M
