local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local function scheme_picker(opts)
  pickers.new(opts, {
    prompt_title = "Nice",
    finder = finders.new_table({
      "tokyonight",
      "color_galaxy",
      "moonlight",
      "onedark",
      "gruvbox8",
      "tokyodark",
      "gruvbox_material",
      "random",
    }),
    sorter = conf.generic_sorter({}),

    attach_mappings = function(_, map)
      map("i", "<CR>", function(bufnr)
        local scheme = require("telescope.actions.state").get_selected_entry()
        require("colors.themes")[scheme[1]](true)
        require("telescope.actions").close(bufnr)
      end)
      return true
    end,
  }):find()
end

return { scheme_picker = scheme_picker }
