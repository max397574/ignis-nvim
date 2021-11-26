_G.dump = function(...)
  print(vim.inspect(...))
end

_G.profile = function(command, times)
  times = times or 100
  local args = {}
  if type(cmd) == "string" then
    args = { cmd }
    cmd = cmd
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

---@class nvim_config.utils
local utils = {}

function utils.append_comma()
  local cursor = vim.api.nvim_win_get_cursor(0)
  vim.cmd([[normal A,]])
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

local map = function(mode, key, command, opts, defaults)
  opts = vim.tbl_deep_extend(
    "force",
    { silent = true },
    defaults or {},
    opts or {}
  )

  if type(command) == "function" then
    table.insert(utils.functions, command)
    if opts.expr then
      command = ([[luaeval('require("util").execute(%d)')]]):format(
        #utils.functions
      )
    else
      command = ("<command>lua require('util').execute(%d)<cr>"):format(
        #utils.functions
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

function utils.map(mode, key, command, opt, defaults)
  return map(mode, key, command, opt, defaults)
end

function utils.nmap(key, command, opts)
  return map("n", key, command, opts)
end
function utils.vmap(key, command, opts)
  return map("v", key, command, opts)
end
function utils.xmap(key, command, opts)
  return map("x", key, command, opts)
end
function utils.imap(key, command, opts)
  return map("i", key, command, opts)
end
function utils.omap(key, command, opts)
  return map("o", key, command, opts)
end
function utils.smap(key, command, opts)
  return map("s", key, command, opts)
end

function utils.nnoremap(key, command, opts)
  return map("n", key, command, opts, { noremap = true })
end
function utils.vnoremap(key, command, opts)
  return map("v", key, command, opts, { noremap = true })
end
function utils.xnoremap(key, command, opts)
  return map("x", key, command, opts, { noremap = true })
end
function utils.inoremap(key, command, opts)
  return map("i", key, command, opts, { noremap = true })
end
function utils.onoremap(key, command, opts)
  return map("o", key, command, opts, { noremap = true })
end
function utils.snoremap(key, command, opts)
  return map("s", key, command, opts, { noremap = true })
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

-- https://paste.sh/GkuItIwS#SIH7vDr2kHsl-Zd6wxSdkXvc
function utils.siduck_function(mappings)
  vim.cmd([[highlight SiduckSectionContent guibg = #353b45]])
  vim.cmd([[highlight SiduckHeading guifg = #8bcd5b]])
  vim.cmd([[highlight SiduckBorder guifg = #617190 guibg = #353b45]])
  local section_title_colors = {
    "#41a7fc",
    "#ea8912",
    "#f65866",
    "#ebc275",
    "#c678dd",
    "#34bfd0",
  }
  for i, color in ipairs(section_title_colors) do
    vim.cmd("highlight SiduckTopic" .. i .. " guifg = " .. color)
  end
  local ns = vim.api.nvim_create_namespace("help")
  -- local lines = {" ","          My Mappings:"}
  local lines = {}
  local win, buf
  local heading_lines = {}
  local section_lines = {}
  local section_titles = {}
  local border_lines = {}
  local line_nr = 0
  for main_sec, section_contents in pairs(mappings) do
    table.insert(lines, " ")
    table.insert(lines, "          " .. main_sec)
    line_nr = line_nr + 2
    table.insert(section_titles, line_nr)
    for topic, values in pairs(section_contents) do
      if type(values) == "table" then
        lines[#lines + 1] = " "
        line_nr = line_nr + 1
        lines[#lines + 1] = "            " .. topic
        table.insert(heading_lines, line_nr)
        line_nr = line_nr + 1
        lines[#lines + 1] = "                                               "
        line_nr = line_nr + 1
        table.insert(
          lines,
          "              " .. "▛" .. string.rep("▀", 31) .. "▜"
        )
        table.insert(border_lines, line_nr)
        line_nr = line_nr + 1
        for mapping, key in pairs(values) do
          if type(key) == "string" then
            table.insert(
              lines,
              "              ▌"
                .. mapping
                .. string.rep(" ", 30 - #mapping - #key)
                .. key
                .. " ▐"
            )
            table.insert(section_lines, line_nr)
            line_nr = line_nr + 1
          else
            if type(key[1]) == "string" then
              table.insert(
                lines,
                "              ▌"
                  .. mapping
                  .. string.rep(" ", 30 - #mapping - #key[1])
                  .. key[1]
                  .. " ▐"
              )
              table.insert(section_lines, line_nr)
              line_nr = line_nr + 1
            elseif type(key) == "table" then
              table.insert(
                lines,
                "              ▌"
                  .. mapping
                  .. ":"
                  .. string.rep(" ", 30 - #mapping)
                  .. "▐"
              )
              table.insert(section_lines, line_nr)
              line_nr = line_nr + 1
              for mapping_name, keystroke in pairs(key) do
                table.insert(
                  lines,
                  "              ▌  "
                    .. mapping_name
                    .. string.rep(" ", 30 - #mapping_name - 2 - #keystroke)
                    .. keystroke
                    .. " ▐"
                )
                table.insert(section_lines, line_nr)
                line_nr = line_nr + 1
              end
            end
          end
        end
        table.insert(
          lines,
          "              " .. "▙" .. string.rep("▄", 31) .. "▟"
        )
        table.insert(border_lines, line_nr)
        line_nr = line_nr + 1
        table.insert(lines, " ")
        line_nr = line_nr + 1
      else
        lines[#lines + 1] = " "
        line_nr = line_nr + 1
        table.insert(
          lines,
          "            ▌"
            .. topic
            .. string.rep(" ", 30 - #topic - #values)
            .. values
            .. " "
        )
        table.insert(section_lines, line_nr)
        line_nr = line_nr + 1
        table.insert(
          lines,
          "              " .. "▙" .. string.rep("▄", 31) .. "▟"
        )
        table.insert(section_lines, line_nr)
        line_nr = line_nr + 1
      end
    end
  end
  buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_keymap(
    buf,
    "n",
    "q",
    "<cmd>q<CR>",
    { noremap = true, silent = true, nowait = true }
  )
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  local width = vim.api.nvim_win_get_width(0)
  local height = vim.api.nvim_win_get_height(0)
  win = vim.api.nvim_open_win(
    buf,
    true,
    {
      relative = "win",
      win = 0,
      width = math.floor(58),
      height = math.floor(height * 0.9),
      col = math.floor(width * 0.1),
      row = math.floor(height * 0.1),
      border = "shadow",
      style = "minimal",
    }
  )
  local highlight_nr = 1
  for i, line in ipairs(heading_lines) do
    if true then
      highlight_nr = highlight_nr + 1
      vim.api.nvim_buf_add_highlight(
        buf,
        ns,
        "SiduckTopic" .. highlight_nr,
        line,
        0,
        -1
      )
      if highlight_nr == 6 then
        highlight_nr = 1
      end
    end
  end
  for _, line in ipairs(section_lines) do
    vim.api.nvim_buf_add_highlight(
      buf,
      ns,
      "SiduckSectionContent",
      line,
      15,
      -1
    )
  end
  for _, line in ipairs(border_lines) do
    vim.api.nvim_buf_add_highlight(buf, ns, "SiduckBorder", line, 15, -1)
  end
  for _, line in ipairs(section_lines) do
    vim.api.nvim_buf_add_highlight(buf, ns, "SiduckBorder", line, 16, 17)
    vim.api.nvim_buf_add_highlight(buf, ns, "SiduckBorder", line, 50, 51)
  end
  for _, line in ipairs(section_titles) do
    vim.api.nvim_buf_add_highlight(buf, ns, "SiduckHeading", line - 1, 1, -1)
  end
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
end

function utils.siduck_test()
  utils.siduck_function({

    ["General Mappings"] = {
      misc = {
        close_buffer = "<leader>x",
        copy_whole_file = "<C-a>", -- copy all contents of current buffer
        line_number_toggle = "<leader>n", -- toggle line number
        update_nvchad = "<leader>uu",
        new_buffer = "<S-t>",
        new_tab = "<C-t>b",
        save_file = "<C-s>", -- save file using :w
        theme_toggler = "<leader>tt", -- see in ui.theme_toggler
      },
      -- navigation in insert mode, only if enabled in options
      insert_nav = {
        backward = "<C-h>",
        end_of_line = "<C-e>",
        forward = "<C-l>",
        next_line = "<C-k>",
        prev_line = "<C-j>",
        beginning_of_line = "<C-a>",
      },
      -- better window movement
      window_nav = {
        moveLeft = "<C-h>",
        moveRight = "<C-l>",
        moveUp = "<C-k>",
        moveDown = "<C-j>",
      },
      -- terminal related mappings
      terminal = {
        -- multiple mappings can be given for esc_termmode, esc_hide_termmode
        -- get out of terminal mode
        esc_termmode = { "jk" },
        -- get out of terminal mode and hide it
        esc_hide_termmode = { "JK" },
        -- show & recover hidden terminal buffers in a telescope picker
        pick_term = "<leader>W",
        -- spawn terminals
        new_horizontal = "<leader>h",
        new_vertical = "<leader>v",
        new_window = "<leader>w",
      },
      bufferline = {
        next_buffer = "<TAB>",
        prev_buffer = "<S-Tab>",
      },
      cheatsheet = {
        default_keys = "<leader>dk",
        user_keys = "<leader>uk",
      },
    },
    Plugins = {
      comment = {
        toggle = "<leader>/",
      },
      dashboard = {
        bookmarks = "<leader>bm",
        new_file = "<leader>fn", -- basically create a new buffer
        open = "<leader>db", -- open dashboard
        session_load = "<leader>l",
        session_save = "<leader>s",
      },
      -- map to <ESC> with no lag
      better_escape = { -- <ESC> will still work
        esc_insertmode = { "jk" }, -- multiple mappings allowed
      },
      nvimtree = {
        toggle = "<C-n>",
        focus = "<leader>e",
      },
      telescope = {
        buffers = "<leader>fb",
        find_files = "<leader>ff",
        find_hiddenfiles = "<leader>fa",
        git_commits = "<leader>cm",
        git_status = "<leader>gt",
        help_tags = "<leader>fh",
        live_grep = "<leader>fw",
        oldfiles = "<leader>fo",
        themes = "<leader>th", -- NvChad theme picker
        telescope_media = {
          media_files = "<leader>fp",
        },
      },
    },
  })
end

return utils
