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
      error(
        "Command failed: "
          .. tostring(ok)
          .. " "
          .. vim.inspect { command = command, args = args }
      )
    end
  end
  print(((vim.loop.hrtime() - start) / 1000000 / times) .. "ms")
end

local M = {}

-- write latex file, create pdf and open in preview
function M.LatexPreview()
  vim.cmd [[
  write
  silent !pdflatex %; open %:t:r.pdf
  ]]
end

-- convert markdown file to html and open
function M.MarkdownPreview()
  vim.cmd [[
  write
  silent !python3 -m markdown % > ~/temp_html.html
  silent !open ~/temp_html.html
  ]]
end

-- highlight group of text under cursor
function M.SynGroup()
  vim.cmd [[
  let l:s = synID(line('.'), col('.'), 1)
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
  ]]
end

function M.create_augroup(autocmds, name)
  cmd("augroup " .. name)
  cmd "autocmd!"
  for _, autocmd in ipairs(autocmds) do
    cmd("autocmd " .. autocmd)
  end
  cmd "augroup END"
end

M.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

return M
