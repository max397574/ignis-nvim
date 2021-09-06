local cmd = vim.cmd

_G.dump = function(...)
  print(vim.inspect(...))
end

_G.profile = function(command, times)
  times = times or 100
  local args = {}
  if type(cmd) == "string" then
    args = { cmd }
    cmd = vim.cmd
  end
  local start = vim.loop.hrtime()
  for _ = 1, times, 1 do
    local ok = pcall(command, unpack(args))
    if not ok then
      error("Command failed: " .. tostring(ok) .. " " .. vim.inspect({ command = command, args = args }))
    end
  end
  print(((vim.loop.hrtime() - start) / 1000000 / times) .. "ms")
end

local M = {}

function M.create_augroup(autocmds, name)
  cmd("augroup " .. name)
  cmd("autocmd!")
  for _, autocmd in ipairs(autocmds) do
    cmd("autocmd " .. autocmd)
  end
  cmd("augroup END")
end

M.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

return M
