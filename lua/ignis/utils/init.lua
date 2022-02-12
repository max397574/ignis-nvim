local utils = {}

local log = require("ignis.external.log")
local fmt = string.format
local config = require("ignis.config").config

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

utils.set_colorscheme = function(colorscheme)
    if colorscheme then
        vim.cmd("colorscheme " .. colorscheme)
    end
    if type(config.ignis.colorscheme) == "string" then
        vim.cmd([[colorscheme ]] .. config.ignis.colorscheme)
    elseif type(config.ignis.colorscheme) == "function" then
        config.ignis.colorscheme()
    else
        log.error("Invalid options for ignis.colorscheme")
    end
end

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

return utils
