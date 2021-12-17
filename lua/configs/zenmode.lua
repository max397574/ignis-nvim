require("zen-mode").setup({
  window = {
    backdrop = 0.3, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
    width = 0.85, -- width of the Zen window
    height = 1, -- height of the Zen window
    options = {
      -- signcolumn = "no", -- disable signcolumn
      -- number = false, -- disable number column
      -- relativenumber = false, -- disable relative numbers
      -- cursorline = false, -- disable cursorline
      cursorcolumn = false, -- disable cursor column
      foldcolumn = "0", -- disable fold column
      list = false, -- disable whitespace characters
    },
  },
  plugins = {
    options = {
      enabled = true,
      ruler = false, -- disables the ruler text in the cmd line area
      showcmd = false, -- disables the command in the last line of the screen
    },
    twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
    gitsigns = { enabled = false }, -- disables git signs
    tmux = { enabled = false }, -- disables the tmux statusline
    kitty = {
      enabled = true,
      font = "+4", -- font size increment
    },
  },
  -- callback where you can add custom code when the Zen window opens
  on_open = function(win) vim.cmd[[PackerLoad twilight.nvim]]end,
  -- callback where you can add custom code when the Zen window closes
  on_close = function() end,
})
