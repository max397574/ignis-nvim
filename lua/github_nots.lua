local M = {}
M.events = {}
local job = require("plenary.job")

local function float_win(text)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_keymap(
    buf,
    "n",
    "q",
    "<cmd>q<CR>",
    { noremap = true, silent = true, nowait = true }
  )
  local lines = text -- table with strings
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  local width = vim.api.nvim_win_get_width(0)
  local height = vim.api.nvim_win_get_height(0)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "win",
    win = 0,
    width = math.floor(width * 0.99),
    height = math.floor(height * 0.99),
    col = math.floor(width * 0.1),
    row = math.floor(height * 0.1),
    border = "single",
    style = "minimal",
  })
  vim.api.nvim_win_set_option(win, "winblend", 20)
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
end

local parse_json = function(json_data)
  for _, event in ipairs(json_data) do
    local action
    local icon
    local user = event["actor"]["display_login"]
    -- print("event:")
    -- dump(event)

    if event["payload"]["forkee"] then
    elseif event["payload"]["action"] == "started" then
      action = "starred"
      icon = " "
      local repo = event["repo"]["name"]
      table.insert(M.events, ("%s %s %s %s"):format(icon, user, action, repo))
      -- table.insert(M.events, ("%s"):format(repo))
    else
    end
  end
end

M.setup = function()
  local username = "budswa"
  -- local url = ("https://api.github.com/users/%s/received_events"):format(username)
  local url = ("https://api.github.com/users/%s/events"):format(username)

  vim.schedule(function()
    local sauce = job:new({ command = "curl", args = { url } }):sync()
    local json_data = vim.json.decode(table.concat(sauce, ""))
    parse_json(json_data)
    float_win(M.events)
  end)
end

return M
