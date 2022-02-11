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
    -- get row and column of cursor position
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    -- 1-based -> 0-based indexing
    row = row - 1
    -- column is different if in insert mode
    -- it's the column right of the cursor (if line) we don't want that
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

        -- get root of the ast (abstract syntax tree) note that all the nodes are subnodes of the root so this isn't the top of the file
        local root = tstree:root()
        local root_start_row, _, root_end_row, _ = root:range()

        -- check if cursor_pos is inside of root
        if root_start_row > row or root_end_row < row then
            return
        end

        local query = self:get_query(tree:lang())

        if not query:query() then
            return
        end

        local iter = query:query():iter_captures(root, self.bufnr, row, row + 1)

        -- go through all the captures inside root
        for capture, node, _ in iter do
            -- get highlight of capture
            local hl = query.hl_cache[capture]

            -- check if the node is at the cursor position
            if hl and ts_utils.is_in_node_range(node, row, col) then
                local c = query._query.captures[capture] -- name of the capture in the query
                if c ~= nil then
                    -- get the highlight group and insert it into the table
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
    vim.cmd([[normal A,]])
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
    cmd([[normal b~]])
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
            -- center cursor
            -- vim.cmd([[silent normal! zz]])
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

---Create an augroup
---@param autocmds table Autocommands to put into the group (like `BufWritePost * lua print(*yes)`)
---@param name string Name of the augroup
function utils.create_augroup(autocmds, name)
    vim.cmd("augroup " .. name)
    vim.cmd("autocmd!")
    for _, autocmd in ipairs(autocmds) do
        vim.cmd("autocmd " .. autocmd)
    end
    vim.cmd("augroup END")
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

function utils.set_colorscheme(colorscheme)
    if colorscheme then
        vim.cmd("colorscheme " .. colorscheme)
    end
    local theme
    local time = os.date("*t")
    if time.hour < 7 or time.hour >= 20 then
        theme = "tokyodark"
    elseif time.hour < 8 or time.hour >= 19 then
        theme = "kanagawa"
    elseif time.hour < 10 or time.hour >= 17 then
        theme = "onedark"
    else
        theme = "everforest"
        -- theme = "tokyodark"
    end
    require("colors").init(theme)
    local old_scheme = require("custom.db").get_scheme()
    if theme ~= old_scheme then
        require("colorscheme_switcher").new_scheme()
        vim.defer_fn(function()
            require("colorscheme_switcher").new_scheme()
        end, 1000)
    end
end

return utils
