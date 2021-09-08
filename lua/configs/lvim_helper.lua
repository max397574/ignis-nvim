local home = os.getenv "HOME"
require("lvim-helper").setup {
  files = {
    home .. "/.config/nvim/vimhelp/treesitter.md",
    home .. "/.config/nvim/vimhelp/ts_textobjects_move.md",
    home .. "/.config/nvim/vimhelp/ts_textobjects_select.md",
    home .. "/.config/nvim/vimhelp/telescope.md",
    home .. "/.config/nvim/vimhelp/cmp.md",
    home .. "/.config/nvim/vimhelp/useful.md",
  },
  winopts = {
    winhl = table.concat({ "Normal:LvimHelperNormal" }, ","),
  },
}
local lvim_helper_bindings = require "lvim-helper.bindings"
lvim_helper_bindings.bindings = {
  ["J"] = lvim_helper_bindings.lvim_helper_callback "next",
  ["K"] = lvim_helper_bindings.lvim_helper_callback "prev",
  ["q"] = lvim_helper_bindings.lvim_helper_callback "close",
}
