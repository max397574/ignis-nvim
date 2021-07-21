local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local opt = vim.opt  -- to set options

require("config_files.options")
require("plugin_settings.colorizer")
require("plugin_settings.comment")
require("plugin_settings.lsp")
require("plugin_settings.lvim_helper")
require("plugin_settings.telescope")
require("plugin_settings.todo-comments")
require("plugin_settings.treesitter")
require("plugin_settings.trouble")
require("plugin_settings.twilight")
require("plugin_settings.which_key")
require("plugin_settings.compe")
vim.cmd('source ~/.config/nvim/tablemode.vim')
vim.cmd('source ~/.config/nvim/plugins.vim')
vim.cmd('source ~/.config/nvim/spelling.vim')
vim.cmd('source ~/.config/nvim/mapping.vim')
vim.cmd('colorscheme gruvbox')
