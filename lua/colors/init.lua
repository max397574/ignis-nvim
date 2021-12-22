local colors = {}

-- if theme given, load given theme if given, otherwise nvchad_theme
colors.init = function(theme)
  -- if not theme then
  --   theme = "onedark"
  -- end

  -- set the global theme, used at various places like theme switcher, highlights
  vim.g.nvchad_theme = theme
  vim.g.colors_name = theme

  local present = true
  local base16 = require"base16"

  if present then
    -- first load the base16 theme
    base16(base16.themes(theme), true)

    -- unload to force reload
    package.loaded["colors.highlights" or false] = nil
    -- then load the highlights
    require("colors.highlights")
  else
    return false
  end
end

-- returns a table of colors for givem or current theme
colors.get = function(theme)
  if not theme then
    theme = vim.g.nvchad_theme
  end

  return require("hl_themes." .. theme)
end

return colors
