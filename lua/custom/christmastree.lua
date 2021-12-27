local x = " "
local tree = {
  [[]],
  [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⬤ ⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⬤ ⣾⣿⣿⣿⣿⣿⣿⣿⣷⣄⬤ ⠀⠀⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⠀⠀⠈⬤ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡛⠛⠁⠀⠀⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⬤ ⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⬤ ⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⠀⬤ ⠉⠉⠉⠀⠠⠉⠛⢻⣿⡀⠈⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⠀⡸⠛⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
}

local buf = vim.api.nvim_create_buf(false, true)
vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
vim.api.nvim_buf_set_keymap(
  buf,
  "n",
  "q",
  "<cmd>q<CR>",
  { noremap = true, silent = true, nowait = true }
)
local lines = tree -- table with strings
vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
local width = vim.api.nvim_win_get_width(0)
local height = vim.api.nvim_win_get_height(0)
local win = vim.api.nvim_open_win(buf, true, {
  relative = "win",
  win = 0,
  width = 30,
  height = 12,
  col = math.floor(width * 0.1),
  row = math.floor(height * 0.1),
  border = "shadow",
  style = "minimal",
})
vim.api.nvim_win_set_option(win, "winblend", 0)
vim.api.nvim_buf_set_option(buf, "modifiable", false)
local ns = vim.api.nvim_create_namespace("christmastree")
vim.cmd([[hi TreeOne guifg=#E34242]])
vim.cmd([[hi TreeTwo guifg=#4083C7]])
vim.cmd([[hi TreeThree guifg=#E3B236]])
vim.cmd([[hi TreeGreen guifg=#98c379]])
for i = 1, 10, 1 do
  vim.api.nvim_buf_add_highlight(buf, ns, "TreeGreen", i, 1, -1)
end
vim.api.nvim_buf_add_highlight(buf, ns, "TreeOne", 3, 29, 32)
vim.api.nvim_buf_add_highlight(buf, ns, "TreeTwo", 4, 28, 31)
vim.api.nvim_buf_add_highlight(buf, ns, "TreeThree", 4, 62, 65)
vim.api.nvim_buf_add_highlight(buf, ns, "TreeOne", 6, 25, 28)
vim.api.nvim_buf_add_highlight(buf, ns, "TreeTwo", 7, 70, 73)
vim.api.nvim_buf_add_highlight(buf, ns, "TreeOne", 8, 73, 76)
vim.api.nvim_buf_add_highlight(buf, ns, "TreeThree", 9, 19, 22)
vim.defer_fn(function()
  vim.cmd([[hi TreeOne guifg=#E34242]])
  vim.cmd([[hi TreeTwo guifg=#4083C7]])
  vim.cmd([[hi TreeThree guifg=#E3B236]])
  vim.defer_fn(function()
    vim.cmd([[hi TreeThree guifg=#E34242]])
    vim.cmd([[hi TreeOne guifg=#4083C7]])
    vim.cmd([[hi TreeTwo guifg=#E3B236]])
    vim.defer_fn(function()
      vim.cmd([[hi TreeTwo guifg=#E34242]])
      vim.cmd([[hi TreeThree guifg=#4083C7]])
      vim.cmd([[hi TreeOne guifg=#E3B236]])
      vim.defer_fn(function()
        vim.cmd([[hi TreeOne guifg=#E34242]])
        vim.cmd([[hi TreeTwo guifg=#4083C7]])
        vim.cmd([[hi TreeThree guifg=#E3B236]])
        vim.defer_fn(function()
          vim.cmd([[hi TreeThree guifg=#E34242]])
          vim.cmd([[hi TreeOne guifg=#4083C7]])
          vim.cmd([[hi TreeTwo guifg=#E3B236]])
          vim.defer_fn(function()
            vim.cmd([[hi TreeTwo guifg=#E34242]])
            vim.cmd([[hi TreeThree guifg=#4083C7]])
            vim.cmd([[hi TreeOne guifg=#E3B236]])
            vim.defer_fn(function()
              vim.cmd([[hi TreeOne guifg=#E34242]])
              vim.cmd([[hi TreeTwo guifg=#4083C7]])
              vim.cmd([[hi TreeThree guifg=#E3B236]])
              vim.defer_fn(function()
                vim.cmd([[hi TreeThree guifg=#E34242]])
                vim.cmd([[hi TreeOne guifg=#4083C7]])
                vim.cmd([[hi TreeTwo guifg=#E3B236]])
                vim.defer_fn(function()
                  vim.cmd([[hi TreeTwo guifg=#E34242]])
                  vim.cmd([[hi TreeThree guifg=#4083C7]])
                  vim.cmd([[hi TreeOne guifg=#E3B236]])
                  vim.defer_fn(function()
                    vim.cmd([[hi TreeOne guifg=#E34242]])
                    vim.cmd([[hi TreeTwo guifg=#4083C7]])
                    vim.cmd([[hi TreeThree guifg=#E3B236]])
                    vim.defer_fn(function()
                      vim.cmd([[hi TreeThree guifg=#E34242]])
                      vim.cmd([[hi TreeOne guifg=#4083C7]])
                      vim.cmd([[hi TreeTwo guifg=#E3B236]])
                      vim.defer_fn(function()
                        vim.cmd([[hi TreeTwo guifg=#E34242]])
                        vim.cmd([[hi TreeThree guifg=#4083C7]])
                        vim.cmd([[hi TreeOne guifg=#E3B236]])
                      end, 500)
                    end, 500)
                  end, 500)
                end, 500)
              end, 500)
            end, 500)
          end, 500)
        end, 500)
      end, 500)
    end, 500)
  end, 500)
end, 500)
