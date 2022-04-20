local utils = {}

local log = require("ignis.external.log")
local fmt = string.format

--- Picks a random element of a table
---@param table table
---@return any Random-element
function utils.random_element(table)
    math.randomseed(os.clock())
    local index = math.random() * #table
    return table[math.floor(index) + 1]
end

--- Loads the specified modules
---@param folder string The folder which contains the module files (e.g. `ignis`)
---@param modules table|string The modules to load (e.g. `{ "utils", "ui" }`)
utils.load_module = function(folder, modules)
    local paths = {}
    if type(modules) == "string" then
        paths[1] = fmt("%s.%s", folder, modules)
    elseif type(modules) == "table" then
        for _, module in ipairs(modules) do
            table.insert(paths, fmt("%s.%s", folder, module))
        end
    else
        log.error("Invalid value for `modules`")
    end
    for _, path in ipairs(paths) do
        local ok, err = xpcall(require, debug.traceback, path)
        if not ok then
            log.error(
                fmt("Error loading module '%s'! Traceback:\n%s", path, err)
            )
        else
            log.debug("Loaded module '%s'", path)
        end
    end
end

--- Loads specified ignis modules
---@param module string The modules name (without ignis.modules)
---@param files string|table The files in the module to load
utils.load_ignis_module = function(module, files)
    utils.load_module("ignis.modules." .. module, files)
end

--- Sets the colorscheme specified or uses the one from config
---@param colorscheme string The colorscheme to use
utils.set_colorscheme = function(colorscheme)
    if colorscheme then
        require("colors").init(colorscheme)
        return
    end
    local theme = utils.get_colorscheme()
    require("colors").init(theme)
    local old_scheme = require("custom.db").get_scheme()
    if theme ~= old_scheme then
        RELOAD("colorscheme_switcher")
        require("colorscheme_switcher").new_scheme()
        vim.defer_fn(function()
            require("colorscheme_switcher").new_scheme()
        end, 1000)
    end
end

--- Gets the colorscheme based on daytime
---@return string colorscheme The colorscheme
function utils.get_colorscheme()
    local theme
    local time = os.date("*t")
    if time.hour < 7 or time.hour >= 21 then
        theme = "tokyodark"
    elseif time.hour < 8 or time.hour >= 19 then
        theme = "kanagawa"
    elseif time.hour < 10 or time.hour >= 17 then
        theme = "onedark"
    else
        theme = "everforest"
    end
    if vim.g.forced_theme then
        theme = vim.g.forced_theme
    end
    return theme
end

--- Gets the system separator
---@return string system_separator
function utils.system_separator()
    return package.config:sub(1, 1)
end

---Get the available nvim-base16 themes
---@return table themes All the themes found
utils.get_themes = function()
    local themes = {}
    -- the local plugin dir
    local theme_dir = vim.fn.expand("~")
        .. "/neovim_plugins/nvim-base16.lua/lua/hl_themes"
    -- get all the files inside the folder
    local theme_files = require("plenary.scandir").scan_dir(theme_dir, {})
    -- go through all the files
    for _, theme in ipairs(theme_files) do
        -- insert the filename without the extenstion and the path before it into the themes table
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
    -- also go through all the themes in the config folder
    theme_dir = vim.fn.expand("~") .. "/.config/nvim_config/lua/hl_themes"
    theme_files = require("plenary.scandir").scan_dir(theme_dir, {})
    for _, theme in ipairs(theme_files) do
        table.insert(
            themes,
            (theme
                :gsub(
                    vim.fn.expand("~")
                        .. "/%.config/nvim%_config/lua/hl%_themes/",
                    ""
                )
                :gsub(".lua", ""))
        )
    end
    return themes
end

---Appends a `;` to the current line
function utils.append_semicolon()
    -- save cursor position
    local cursor = vim.api.nvim_win_get_cursor(0)
    -- append ,
    vim.cmd([[normal A;]])
    -- restore cursor position
    vim.api.nvim_win_set_cursor(0, cursor)
end

---Appends a `,` to the current line
function utils.append_comma()
    -- save cursor position
    local cursor = vim.api.nvim_win_get_cursor(0)
    -- append ,
    vim.cmd([[normal A,]])
    -- restore cursor position
    vim.api.nvim_win_set_cursor(0, cursor)
end

---Changes the case of the current *word*
function utils.change_case()
    -- save cursor position
    local cursor = vim.api.nvim_win_get_cursor(0)
    -- go to the beginning of word and change case of letter under cursor
    vim.cmd([[normal b~]])
    -- restore cursor position
    vim.api.nvim_win_set_cursor(0, cursor)
end

---Go to the last cursor position in the buffer
function utils.last_place()
    if
        vim.tbl_contains(
            vim.api.nvim_list_bufs(),
            vim.api.nvim_get_current_buf()
        )
    then
        -- check if filetype isn't one of the listed
        if
            not vim.tbl_contains(
                { "gitcommit", "help", "packer", "toggleterm" },
                vim.bo.ft
            )
        then
            -- check if mark `"` is inside the current file (can be false if at end of file and stuff got deleted outside neovim)
            -- if it is go to it
            vim.cmd(
                [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]]
            )
            -- get cursor position
            local cursor = vim.api.nvim_win_get_cursor(0)
            -- if there are folds under the cursor open them
            if vim.fn.foldclosed(cursor[1]) ~= -1 then
                vim.cmd([[silent normal! zO]])
            end
        end
    end
end

---Write latex file, create pdf and open in preview
function utils.LatexPreview()
    vim.cmd([[
      write
      silent !pdflatex %; open %:t:r.pdf
    ]])
end

---Convert markdown file to html and open
function utils.MarkdownPreview()
    vim.cmd([[
  write
  silent !python3 -m markdown % > ~/temp_html.html
  silent !open ~/temp_html.html
  ]])
end

---Highlight group of text under cursor
function utils.SynGroup()
    vim.cmd([[
  let l:s = synID(line('.'), col('.'), 1)
  echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
  ]])
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

---Prints out the configurations for the servers attached to the current buffer
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

---Opens contents of specified file in a float
---@param filepath string Path to the file to open
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

---Set format options
function utils.formatoptions()
    vim.opt.formatoptions = vim.opt.formatoptions
        + "r" -- continue comments after return
        + "c" -- wrap comments using textwidth
        + "q" -- allow to format comments w/ gq
        + "j" -- remove comment leader when joining lines when possible
        - "t" -- don't autoformat
        - "a" -- no autoformatting
        - "o" -- don't continue comments after o/O
        - "2" -- don't use indent of second line for rest of paragraph
end

--- View the messages in a buffer
function utils.view_messages()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
    vim.keymap.set(
        "n",
        "<ESC>",
        "<cmd>q<CR>",
        { noremap = true, silent = true, nowait = true, buffer = buf }
    )
    vim.keymap.set(
        "n",
        "q",
        "<cmd>q<CR>",
        { noremap = true, silent = true, nowait = true, buffer = buf }
    )
    local width = vim.api.nvim_win_get_width(0)
    local height = vim.api.nvim_win_get_height(0)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "win",
        win = 0,
        width = math.floor(width * 0.25),
        height = math.floor(height * 0.9),
        col = math.floor(width * 0.75),
        row = math.floor(height * 0.05),
        border = "single",
        style = "minimal",
    })
    vim.api.nvim_win_set_option(win, "winblend", 20)
    vim.cmd([[put =execute('messages')]])
end

--- Opens a temporary buffer
function utils.temp_buf()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
    vim.keymap.set(
        "n",
        "<ESC>",
        "<cmd>q<CR>",
        { noremap = true, silent = true, nowait = true, buffer = buf }
    )
    vim.keymap.set(
        "n",
        "q",
        "<cmd>q<CR>",
        { noremap = true, silent = true, nowait = true, buffer = buf }
    )
    local width = vim.api.nvim_win_get_width(0)
    local height = vim.api.nvim_win_get_height(0)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "win",
        win = 0,
        width = math.floor(width * 0.95),
        height = math.floor(height * 0.95),
        col = math.floor(width * 0.025),
        row = math.floor(height * 0.025),
        border = "single",
        style = "minimal",
    })
    vim.api.nvim_win_set_option(win, "winblend", 20)
end

--- Highlights duplicate lines in the current buffer
utils.highlight_duplicate_lines = function()
    local lines = vim.api.nvim_buf_get_lines(0, 1, -1, false)
end

utils.in_mathzone = function()
    local has_treesitter, ts = pcall(require, "vim.treesitter")
    local _, query = pcall(require, "vim.treesitter.query")

    local MATH_ENVIRONMENTS = {
        displaymath = true,
        eqnarray = true,
        equation = true,
        math = true,
        array = true,
    }
    local MATH_NODES = {
        displayed_equation = true,
        inline_formula = true,
    }

    local function get_node_at_cursor()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local cursor_range = { cursor[1] - 1, cursor[2] }
        local buf = vim.api.nvim_get_current_buf()
        local ok, parser = pcall(ts.get_parser, buf, "latex")
        if not ok or not parser then
            return
        end
        local root_tree = parser:parse()[1]
        local root = root_tree and root_tree:root()

        if not root then
            return
        end

        return root:named_descendant_for_range(
            cursor_range[1],
            cursor_range[2],
            cursor_range[1],
            cursor_range[2]
        )
    end

    if has_treesitter then
        local buf = vim.api.nvim_get_current_buf()
        local node = get_node_at_cursor()
        while node do
            if MATH_NODES[node:type()] then
                return true
            end
            if node:type() == "environment" then
                local begin = node:child(0)
                local names = begin and begin:field("name")

                if
                    names
                    and names[1]
                    and MATH_ENVIRONMENTS[query.get_node_text(names[1], buf):gsub(
                        "[%s*]",
                        ""
                    )]
                then
                    return true
                end
            end
            node = node:parent()
        end
        return false
    end
end

function utils.adjust_color(color, amount)
    color = vim.trim(color)
    color = color:gsub("#", "")
    local first = ("0" .. string.format(
        "%x",
        (math.min(255, tonumber(color:sub(1, 2), 16) + amount))
    )):sub(-2)
    local second = ("0" .. string.format(
        "%x",
        (math.min(255, tonumber(color:sub(3, 4), 16) + amount))
    )):sub(-2)
    local third = ("0" .. string.format(
        "%x",
        (math.min(255, tonumber(color:sub(5, -1), 16) + amount))
    )):sub(-2)
    return "#" .. first .. second .. third
end

function utils.darken_color(color, amount)
    return utils.adjust_color(color, -amount)
end

function utils.lighten_color(color, amount)
    return utils.adjust_color(color, amount)
end

return utils
