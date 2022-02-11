-- require("packer").startup({
--     function(use)
--         use({
--             "nvchad/nvim-base16.lua",
--             -- "~/neovim_plugins/nvim-base16.lua/",
--         })
--     end,
-- })
vim.cmd([[packadd nvim-base16.lua]])
require("ignis.utils").set_colorscheme()
-- vim.cmd([[packadd staline.nvim]])
-- vim.cmd([[packadd bufferline.nvim]])
-- require("configs.bufferline")
-- require("configs.staline")
-- -- require("plugins")
-- -- require("packer_compiled")
