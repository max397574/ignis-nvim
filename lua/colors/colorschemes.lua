Colo = {}

function Colo.color_galaxy(transparent)
  require "colors.color_galaxy".shine()
  require "colors.vimcolors"
  if transparent == true then
    vim.cmd("highlight Normal guibg=none")
  end
end

function Colo.moonlight(transparent)
  vim.cmd("colorscheme moonlight")
  if transparent == true then
    vim.cmd("highlight Normal guibg=none")
  end
end
function Colo.gruvbox8(transparent)
  vim.cmd("colorscheme gruvbox8")
  if transparent == true then
    vim.cmd("highlight Normal guibg=none")
  end
end
function Colo.onedark(transparent)
  vim.cmd("colorscheme onedark")
  if transparent == true then
    vim.cmd("highlight Normal guibg=none")
  end
end
function Colo.tokyonight(transparent)
  vim.cmd("colorscheme tokyonight")
  if transparent == true then
    vim.cmd("highlight Normal guibg=none")
  end
end
function Colo.tokyodark(transparent)
  vim.cmd("colorscheme tokyodark")
  if transparent == true then
    vim.cmd("highlight Normal guibg=none")
  end
end
function Colo.gruvbox_material(transparent)
  vim.cmd("colorscheme gruvbox-material")
  if transparent == true then
    vim.cmd("highlight Normal guibg=none")
  end
end

return Colo
