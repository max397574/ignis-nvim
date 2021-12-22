local function clock()
  return " " .. os.date("%H:%M")
end

local function empty()
  return "%="
end
local colors = {
  green = "#9ece6a",
  red = "#db4b4b",
  orange = "#e0af68",
}

local function progress_bar()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local chars = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

vim.cmd([[autocmd User LspProgressUpdate let &ro = &ro]])

local config = {
  options = {
    theme = "onedark",
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    -- section_separators = { "", "" },
    -- component_separators = { "", "" },
    icons_enabled = true,
    disabled_filetypes = { "startup", "TelescopePrompt" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = {
      { "diagnostics", sources = { "nvim_diagnostic" } },
      {
        "diff",
        symbols = { added = " ", modified = "柳", removed = " " },
        color_added = colors.green,
        color_modified = colors.orange,
        color_removed = colors.red,
      },
      empty,
      "filename",
    },
    lualine_x = { "filetype" },
    lualine_y = { "progress", progress_bar },
    lualine_z = { "loaction", clock },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "nvim-tree" },
}
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end
-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_y, component)
end

ins_left({
  function()
    return "%="
  end,
})
ins_right("location")

require("lualine").setup(config)
