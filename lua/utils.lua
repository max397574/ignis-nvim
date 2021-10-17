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

function M.append_comma()
  local cursor = vim.api.nvim_win_get_cursor(0)
  vim.cmd [[normal A,]]
  vim.api.nvim_win_set_cursor(0, cursor)
end

function M.last_place()
  if
    vim.tbl_contains(vim.api.nvim_list_bufs(), vim.api.nvim_get_current_buf())
  then
    if not vim.tbl_contains({ "help", "packer", "toggleterm" }, vim.bo.ft) then
      vim.cmd [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]]
      local cursor = vim.api.nvim_win_get_cursor(0)
      if vim.fn.foldclosed(cursor[1]) ~= -1 then
        vim.cmd [[silent normal! zO]]
      end
    end
  end
end

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

M.border_thin_rounded = {
  "╭",
  "─",
  "╮",
  "│",
  "╯",
  "─",
  "╰",
  "│",
}
M.border_wide_angular = {
  "▛",
  "▀",
  "▜",
  "▐",
  "▟",
  "▄",
  "▙",
  "▌",
}

-- selene: allow(global_usage)
_G.profile = function(command, times)
  times = times or 100
  local args = {}
  if type(command) == "string" then
    args = { command }
    command = vim.cmd
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

M.functions = {}

function M.execute(id)
  local func = M.functions[id]
  if not func then
    error("Function doest not exist: " .. id)
  end
  return func()
end

local map = function(mode, key, command, opts, defaults)
  opts = vim.tbl_deep_extend(
    "force",
    { silent = true },
    defaults or {},
    opts or {}
  )

  if type(command) == "function" then
    table.insert(M.functions, command)
    if opts.expr then
      command = ([[luaeval('require("util").execute(%d)')]]):format(
        #M.functions
      )
    else
      command = ("<command>lua require('util').execute(%d)<cr>"):format(
        #M.functions
      )
    end
  end
  if opts.buffer ~= nil then
    local buffer = opts.buffer
    opts.buffer = nil
    return vim.api.nvim_buf_set_keymap(buffer, mode, key, command, opts)
  else
    return vim.api.nvim_set_keymap(mode, key, command, opts)
  end
end

function M.map(mode, key, command, opt, defaults)
  return map(mode, key, command, opt, defaults)
end

function M.nmap(key, command, opts)
  return map("n", key, command, opts)
end
function M.vmap(key, command, opts)
  return map("v", key, command, opts)
end
function M.xmap(key, command, opts)
  return map("x", key, command, opts)
end
function M.imap(key, command, opts)
  return map("i", key, command, opts)
end
function M.omap(key, command, opts)
  return map("o", key, command, opts)
end
function M.smap(key, command, opts)
  return map("s", key, command, opts)
end

function M.nnoremap(key, command, opts)
  return map("n", key, command, opts, { noremap = true })
end
function M.vnoremap(key, command, opts)
  return map("v", key, command, opts, { noremap = true })
end
function M.xnoremap(key, command, opts)
  return map("x", key, command, opts, { noremap = true })
end
function M.inoremap(key, command, opts)
  return map("i", key, command, opts, { noremap = true })
end
function M.onoremap(key, command, opts)
  return map("o", key, command, opts, { noremap = true })
end
function M.snoremap(key, command, opts)
  return map("s", key, command, opts, { noremap = true })
end

function M.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.log(msg, hl, name)
  name = name or "Neovim"
  hl = hl or "Todo"
  vim.api.nvim_echo({ { name .. ": ", hl }, { msg } }, true, {})
end

function M.warn(msg, name)
  M.log(msg, "LspDiagnosticsDefaultWarning", name)
end

function M.error(msg, name)
  M.log(msg, "LspDiagnosticsDefaultError", name)
end

function M.info(msg, name)
  M.log(msg, "LspDiagnosticsDefaultInformation", name)
end

function M.toggle(option, silent)
  local info = vim.api.nvim_get_option_info(option)
  local scopes = { buf = "bo", win = "wo", global = "o" }
  local scope = scopes[info.scope]
  local options = vim[scope]
  options[option] = not options[option]
  if silent ~= true then
    if options[option] then
      M.info("enabled vim." .. scope .. "." .. option, "Toggle")
    else
      M.warn("disabled vim." .. scope .. "." .. option, "Toggle")
    end
  end
end

function M.float_terminal(command)
  local buf = vim.api.nvim_create_buf(false, true)
  local vpad = 4
  local hpad = 10
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = vim.o.columns - hpad * 2,
    height = vim.o.lines - vpad * 2,
    row = vpad,
    col = hpad,
    style = "minimal",
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  })
  vim.fn.termopen(command)
  local autocommand = {
    "autocommand! TermClose <buffer> lua",
    string.format("vim.api.nvim_win_close(%d, {force = true});", win),
    string.format("vim.api.nvim_buf_delete(%d, {force = true});", buf),
  }
  vim.cmd(table.concat(autocommand, " "))
  vim.cmd [[startinsert]]
end

function M.docs()
  local name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  local docgen = require "babelfish"
  vim.fn.mkdir("./doc", "p")
  local metadata = {
    input_file = "./README.md",
    output_file = "doc/" .. name .. ".txt",
    project_name = name,
  }
  docgen.generate_readme(metadata)
end

function M.lsp_config()
  local ret = {}
  for _, client in pairs(vim.lsp.get_active_clients()) do
    ret[client.name] = {
      root_dir = client.config.root_dir,
      settings = client.config.settings,
    }
  end
  dump(ret)
end

function M.float_file(filepath)
  local lines_cat = vim.api.nvim_exec("!cat " .. filepath, true)
  local lines_lua = {}
  for line in string.gmatch(lines_cat, "[^\n]+") do
    table.insert(lines_lua, line)
  end
  table.remove(lines_lua, 1)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines_lua)
  local width = vim.api.nvim_win_get_width(0)
  local height = vim.api.nvim_win_get_height(0)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "win",
    win = 0,
    width = math.floor(width * 0.8),
    height = math.floor(height * 0.8),
    col = math.floor(width * 0.1),
    row = math.floor(height * 0.1),
    border = "single",
    style = "minimal",
  })
  vim.api.nvim_win_set_option(win, "winblend", 20)
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
end

return M
