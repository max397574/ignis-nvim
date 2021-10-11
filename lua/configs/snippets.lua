local util = require "utils"
local luasnip = require "luasnip"

luasnip.config.set_config {
  history = true,
  -- Update more often, :h events for more info.
  updateevents = "TextChanged,TextChangedI",
}

require("luasnip/loaders/from_vscode").load()

--- <tab> to jump to next snippet's placeholder
local function on_tab()
  return luasnip.jump(1) and "" or util.t "<Tab>"
end

--- <s-tab> to jump to next snippet's placeholder
local function on_s_tab()
  return util.t "<Plug>luasnip-expand-or-jump"
end

util.imap("<Tab>", on_tab, { expr = true })
util.smap("<Tab>", on_tab, { expr = true })
util.imap("<leader><TAB>", on_s_tab, { expr = true })
util.smap("<leader><TAB>", on_s_tab, { expr = true })
