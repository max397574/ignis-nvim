local settings = {
  header = {
    type = "text",
    content = require("startup.buildingblocks.headers").neovim_logo(),
    align = "center",
  },
  body = {
    type = "text",
    -- content = require("startup.buildingblocks.functions").oldfiles(10),
    content = { "" },
    command = [[nnoremap <silent>I :e ~/.config/nvim/init.lua<CR>
      nnoremap p <silent>:e ~/.config/nvim/lua/plugins.lua<CR>
    ]],
  },
  footer = {
    type = "text",
    content = require("startup.buildingblocks.functions").packer_plugins(),
    align = "center",
  },
  options = {
    empty_lines_between_mappings = true,
    mapping_keys = true,
  },
}

return settings
