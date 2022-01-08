---Print out tables and userdata
---@param v any
---@return any v
P = function(v)
  if type(v) == "userdata" then
    print("Userdata:")
    print(vim.inspect(getmetatable(v)))
  else
    print(vim.inspect(v))
  end
  return v
end

local cmd = vim.cmd

---Returns treesitter highlights under cursor
---@return table highlights
function Get_treesitter_hl()
  local highlighter = require("vim.treesitter.highlighter")
  local ts_utils = require("nvim-treesitter.ts_utils")
  local buf = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1
  if vim.api.nvim_get_mode().mode == "i" then
    col = col - 1
  end

  local self = highlighter.active[buf]
  if not self then
    return {}
  end

  local matches = {}

  self.tree:for_each_tree(function(tstree, tree)
    if not tstree then
      return
    end

    local root = tstree:root()
    local root_start_row, _, root_end_row, _ = root:range()

    if root_start_row > row or root_end_row < row then
      return
    end

    local query = self:get_query(tree:lang())

    if not query:query() then
      return
    end

    local iter = query:query():iter_captures(root, self.bufnr, row, row + 1)

    for capture, node, _ in iter do
      local hl = query.hl_cache[capture]

      if hl and ts_utils.is_in_node_range(node, row, col) then
        local c = query._query.captures[capture] -- name of the capture in the query
        if c ~= nil then
          local general_hl = query:_get_hl_from_capture(capture)
          table.insert(matches, general_hl)
        end
      end
    end
  end, true)
  return matches
end

---Prints out tables
---@vararg any
function _G.dump(...)
  print(vim.inspect(...))
end

---Reloads a module
---@param module string Name of the module
function RELOAD(module)
  return require("plenary.reload").reload_module(module)
end

---Reloads and requires a module
---@param name string Name of the module
---@return any module The required module
R = function(name)
  RELOAD(name)
  return require(name)
end

---@class nvim_config.utils
local utils = {}

utils.get_themes = function()
  local themes = {}
  local theme_dir = vim.fn.expand("~")
    .. "/neovim_plugins/nvim-base16.lua/lua/hl_themes"
  local theme_files = require("plenary.scandir").scan_dir(theme_dir, {})
  for _, theme in ipairs(theme_files) do
    table.insert(
      themes,
      (theme
        :gsub(
          vim.fn.expand("~")
            .. "/neovim%_plugins/nvim%-base16%.lua/lua/hl%_themes/",
          ""
        )
        :gsub(".lua", ""))
    )
  end
  theme_dir = vim.fn.expand("~") .. "/.config/nvim_config/lua/hl_themes"
  theme_files = require("plenary.scandir").scan_dir(theme_dir, {})
  for _, theme in ipairs(theme_files) do
    table.insert(
      themes,
      (theme
        :gsub(
          vim.fn.expand("~") .. "/%.config/nvim%_config/lua/hl%_themes/",
          ""
        )
        :gsub(".lua", ""))
    )
  end
  return themes
end

function utils.append_comma()
  local cursor = vim.api.nvim_win_get_cursor(0)
  vim.cmd([[normal A,]])
  vim.api.nvim_win_set_cursor(0, cursor)
end

function utils.append_semicolon()
  local cursor = vim.api.nvim_win_get_cursor(0)
  vim.cmd([[normal A;]])
  vim.api.nvim_win_set_cursor(0, cursor)
end

function utils.change_case()
  local cursor = vim.api.nvim_win_get_cursor(0)
  cmd([[normal b~]])
  vim.api.nvim_win_set_cursor(0, cursor)
end

function utils.last_place()
  if
    vim.tbl_contains(vim.api.nvim_list_bufs(), vim.api.nvim_get_current_buf())
  then
    if not vim.tbl_contains({ "help", "packer", "toggleterm" }, vim.bo.ft) then
      vim.cmd(
        [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]]
      )
      local cursor = vim.api.nvim_win_get_cursor(0)
      if vim.fn.foldclosed(cursor[1]) ~= -1 then
        vim.cmd([[silent normal! zO]])
      end
      vim.cmd([[silent normal! zz]])
    end
  end
end

-- write latex file, create pdf and open in preview
function utils.LatexPreview()
  vim.cmd([[
  write
  silent !pdflatex %; open %:t:r.pdf
  ]])
end

-- convert markdown file to html and open
function utils.MarkdownPreview()
  vim.cmd([[
  write
  silent !python3 -m markdown % > ~/temp_html.html
  silent !open ~/temp_html.html
  ]])
end

-- highlight group of text under cursor
function utils.SynGroup()
  vim.cmd([[
  let l:s = synID(line('.'), col('.'), 1)
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
  ]])
end

function utils.create_augroup(autocmds, name)
  vim.cmd("augroup " .. name)
  vim.cmd("autocmd!")
  for _, autocmd in ipairs(autocmds) do
    vim.cmd("autocmd " .. autocmd)
  end
  vim.cmd("augroup END")
end

utils.border_thin_rounded = {
  "╭",
  "─",
  "╮",
  "│",
  "╯",
  "─",
  "╰",
  "│",
}
utils.border_wide_angular = {
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
    command = cmd
  end
  local start = vim.loop.hrtime()
  for _ = 1, times, 1 do
    local ok = pcall(command, unpack(args))
    if not ok then
      error(
        "Command failed: "
          .. tostring(ok)
          .. " "
          .. vim.inspect({ command = command, args = args })
      )
    end
  end
  print(((vim.loop.hrtime() - start) / 1000000 / times) .. "ms")
end

utils.functions = {}

function utils.execute(id)
  local func = utils.functions[id]
  if not func then
    error("Function doest not exist: " .. id)
  end
  return func()
end

function utils.t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function utils.log(msg, hl, name)
  name = name or "Neovim"
  hl = hl or "Todo"
  vim.api.nvim_echo({ { name .. ": ", hl }, { msg } }, true, {})
end

function utils.warn(msg, name)
  utils.log(msg, "LspDiagnosticsDefaultWarning", name)
end

function utils.error(msg, name)
  utils.log(msg, "LspDiagnosticsDefaultError", name)
end

function utils.info(msg, name)
  utils.log(msg, "LspDiagnosticsDefaultInformation", name)
end

function utils.toggle(option, silent)
  local info = vim.api.nvim_get_option_info(option)
  local scopes = { buf = "bo", win = "wo", global = "o" }
  local scope = scopes[info.scope]
  local options = vim[scope]
  options[option] = not options[option]
  if silent ~= true then
    if options[option] then
      utils.info("enabled vim." .. scope .. "." .. option, "Toggle")
    else
      utils.warn("disabled vim." .. scope .. "." .. option, "Toggle")
    end
  end
end

function utils.float_terminal(command)
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
  cmd(table.concat(autocommand, " "))
  cmd([[startinsert]])
end

function utils.docs()
  local name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  local docgen = require("babelfish")
  vim.fn.mkdir("./doc", "p")
  local metadata = {
    input_file = "./README.md",
    output_file = "doc/" .. name .. ".txt",
    project_name = name,
  }
  docgen.generate_readme(metadata)
end

function utils.lsp_config()
  local ret = {}
  for _, client in pairs(vim.lsp.get_active_clients()) do
    ret[client.name] = {
      root_dir = client.config.root_dir,
      settings = client.config.settings,
    }
  end
  dump(ret)
end

function utils.float_file(filepath)
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

return utils
