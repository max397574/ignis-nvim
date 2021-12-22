local function clock()
  return " " .. os.date("%H:%M")
end

local colors = {
  blue = "#61afef",
  green = "#98c379",
  purple = "#c678dd",
  red1 = "#e06c75",
  red2 = "#be5046",
  yellow = "#e5c07b",
  fg = "#abb2bf",
  bg = "#282c34",
  gray1 = "#5c6370",
  gray2 = "#2c323d",
  gray3 = "#3e4452",
  orange = "#e0af68",
}

local custom_onedark = {
  normal = {
    a = { fg = colors.bg, bg = colors.green },
    b = { fg = colors.fg, bg = colors.gray3 },
    c = { fg = colors.fg, bg = colors.gray2 },
  },
  insert = { a = { fg = colors.bg, bg = colors.blue } },
  visual = { a = { fg = colors.bg, bg = colors.purple } },
  replace = { a = { fg = colors.bg, bg = colors.red1 } },
  inactive = {
    a = { fg = colors.gray1, bg = colors.bg },
    b = { fg = colors.gray1, bg = colors.bg },
    c = { fg = colors.gray1, bg = colors.gray2 },
  },
}

local function empty()
  return "%="
end

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
    theme = custom_onedark,
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
        color_removed = colors.red2,
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
