-- credits for icons go to https://github.com/tamton-aquib/staline.nvim/blob/49915550f77353f3134036d566ed359587f2d71b/lua/staline/config.lua
local conditions = require("heirline.conditions")
local utilities = require("heirline.utils")
local utils = require("heirline.utils")
local align = { provider = "%=" }
local space = { provider = " " }

local use_dev_icons = false

local function word_counter()
    local wc = vim.api.nvim_eval("wordcount()")
    if wc["visual_words"] then
        return wc["visual_words"]
    else
        return wc["words"]
    end
end

local file_icons = {
    typescript = " ",
    ts = " ",
    python = " ",
    py = " ",
    java = " ",
    html = " ",
    css = " ",
    scss = " ",
    javascript = " ",
    js = " ",
    javascriptreact = " ",
    markdown = " ",
    md = " ",
    sh = " ",
    zsh = " ",
    vim = " ",
    rust = " ",
    rs = " ",
    cpp = " ",
    c = " ",
    go = " ",
    lua = " ",
    conf = " ",
    haskel = " ",
    hs = " ",
    ruby = " ",
    txt = " ",
}

local mode_colors = {
    n = vim.g.terminal_color_1,
    i = vim.g.terminal_color_2,
    v = vim.g.terminal_color_5,
    V = vim.g.terminal_color_5,
    ["^V"] = vim.g.terminal_color_5,
    c = vim.g.terminal_color_4,
    s = vim.g.terminal_color_3,
    S = vim.g.terminal_color_3,
    ["^S"] = vim.g.terminal_color_3,
    R = vim.g.terminal_color_4,
    r = vim.g.terminal_color_4,
    ["!"] = vim.g.terminal_color_1,
    t = vim.g.terminal_color_1,
}

local colors = require("colors").get()

local FileNameBlock = {
    -- let's first set up some attributes needed by this component and it's children
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
        self.mode = vim.fn.mode(1)
    end,
}
-- We can now define some children separately and add them later

local HelpFileName = {
    condition = function()
        return vim.bo.filetype == "help"
    end,
    provider = function()
        local filename = vim.api.nvim_buf_get_name(0)
        return vim.fn.fnamemodify(filename, ":t")
    end,
    hl = { fg = colors.blue },
}

local FileType = {
    provider = function()
        return string.upper(vim.bo.filetype)
    end,
    hl = { fg = utils.get_highlight("Type").fg, style = "italic" },
}

local FileIcon = {
    init = function(self)
        self.mode = vim.fn.mode(1)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        if use_dev_icons then
            self.icon, self.icon_color =
                require("nvim-web-devicons").get_icon_color(
                    filename,
                    extension,
                    { default = true }
                )
        else
            self.icon = file_icons[extension] or ""
        end
    end,
    provider = function(self)
        return self.icon and (" " .. self.icon)
    end,
    hl = function(self)
        if use_dev_icons then
            return { fg = self.icon_color }
        else
            local mode = self.mode:sub(1, 1) -- get only the first mode character
            return { fg = mode_colors[mode] }
        end
    end,
}

local FileName = {
    provider = function(self)
        -- first, trim the pattern relative to the current directory. For other
        -- options, see :h filename-modifers
        local filename = vim.fn.fnamemodify(self.filename, ":t")
        if filename == "" then
            return "[No Name]"
        end
        -- now, if the filename would occupy more than 1/4th of the available
        -- space, we trim the file path to its initials
        if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
        end
        return filename .. " "
    end,
    -- hl = { fg = utils.get_highlight("Directory").fg },
    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { fg = mode_colors[mode] }
    end,
}

local FileFlags = {
    {
        provider = function()
            if vim.bo.modified then
                return " "
            end
        end,
        hl = function(self)
            local mode = self.mode:sub(1, 1) -- get only the first mode character
            return { fg = mode_colors[mode] }
        end,
    },
    {
        provider = function()
            if not vim.bo.modifiable or vim.bo.readonly then
                return ""
            end
        end,
        hl = function(self)
            local mode = self.mode:sub(1, 1) -- get only the first mode character
            return { fg = mode_colors[mode] }
        end,
    },
}

-- Now, let's say that we want the filename color to change if the buffer is
-- modified. Of course, we could do that directly using the FileName.hl field,
-- but we'll see how easy it is to alter existing components using a "modifier"
-- component

-- let's add the children to our FileNameBlock component
FileNameBlock = utils.insert(
    FileNameBlock,
    FileIcon,
    FileName,
    unpack(FileFlags), -- A small optimisation, since their parent does nothing
    { provider = "%<" } -- this means that the statusline is cut here when there's not enough space
)

local git = {
    condition = conditions.is_git_repo,

    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0
            or self.status_dict.removed ~= 0
            or self.status_dict.changed ~= 0
    end,

    hl = { fg = colors.orange },

    { -- git branch name
        provider = function(self)
            return " " .. self.status_dict.head .. " "
        end,
    },
    -- You could handle delimiters, icons and counts similar to Diagnostics
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and (" " .. count)
        end,
        hl = { fg = colors.green },
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and (" " .. count)
        end,
        hl = { fg = colors.red },
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and (" " .. count)
        end,
        hl = { fg = colors.orange },
    },
}

local WorkDir = {
    provider = function()
        local icon = "  "
        local cwd = vim.fn.getcwd(0)
        cwd = vim.fn.fnamemodify(cwd, ":~")
        if not conditions.width_percent_below(#cwd, 0.25) then
            cwd = vim.fn.pathshorten(cwd)
        end
        local trail = cwd:sub(-1) == "/" and "" or "/"
        return icon .. cwd .. trail
    end,
    hl = { fg = colors.blue },
}

local mode_icon = {
    init = function(self)
        self.mode = vim.fn.mode(1)
    end,

    static = {
        mode_icons = {
            ["n"] = "  ",
            ["i"] = "  ",
            ["s"] = "  ",
            ["S"] = "  ",
            [""] = "  ",

            ["v"] = "  ",
            ["V"] = "  ",
            [""] = "  ",
            ["r"] = " ﯒ ",
            ["r?"] = "  ",
            ["c"] = "  ",
            ["t"] = "  ",
            ["!"] = "  ",
            ["R"] = "  ",
        },
        mode_names = { -- change the strings if yow like it vvvvverbose!
            n = "N",
            no = "N?",
            nov = "N?",
            noV = "N?",
            ["no"] = "N?",
            niI = "Ni",
            niR = "Nr",
            niV = "Nv",
            nt = "Nt",
            v = "V",
            vs = "Vs",
            V = "V_",
            Vs = "Vs",
            [""] = "",
            ["s"] = "",
            s = "S",
            S = "S_",
            [""] = "",
            i = "I",
            ic = "Ic",
            ix = "Ix",
            R = "R",
            Rc = "Rc",
            Rx = "Rx",
            Rv = "Rv",
            Rvc = "Rv",
            Rvx = "Rv",
            c = "C",
            cv = "Ex",
            r = "...",
            rm = "M",
            ["r?"] = "?",
            ["!"] = "!",
            t = "T",
        },
    },
    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { fg = mode_colors[mode] }
    end,
    provider = function(self)
        return "%2(" .. self.mode_icons[self.mode:sub(1, 1)] .. "%)"
        --         .. self.mode_names[self.mode]
    end,
}

local function progress_bar()
    local sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇" }
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor(curr_line / lines * (#sbar - 1)) + 1
    return sbar[i]
end

local progress = {
    provider = function()
        return "%3(%P%) " .. progress_bar() .. " "
    end,
    init = function(self)
        self.mode = vim.fn.mode(1)
    end,
    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { fg = mode_colors[mode] }
    end,
}

local diagnostics = {

    condition = conditions.has_diagnostics,

    static = {
        error_icon = " ",
        warn_icon = " ",
        info_icon = " ",
        hint_icon = " ",
    },

    init = function(self)
        self.errors = #vim.diagnostic.get(
            0,
            { severity = vim.diagnostic.severity.ERROR }
        )
        self.warnings = #vim.diagnostic.get(
            0,
            { severity = vim.diagnostic.severity.WARN }
        )
        self.hints = #vim.diagnostic.get(
            0,
            { severity = vim.diagnostic.severity.HINT }
        )
        self.info = #vim.diagnostic.get(
            0,
            { severity = vim.diagnostic.severity.INFO }
        )
    end,

    {
        provider = function(self)
            -- 0 is just another output, we can decide to print it or not!
            return self.errors > 0 and (self.error_icon .. self.errors .. " ")
        end,
        hl = { fg = utils.get_highlight("DiagnosticError").fg },
    },
    {
        provider = function(self)
            return self.warnings > 0
                and (self.warn_icon .. self.warnings .. " ")
        end,
        hl = { fg = utils.get_highlight("DiagnosticWarn").fg },
    },
    {
        provider = function(self)
            return self.info > 0 and (self.info_icon .. self.info .. " ")
        end,
        hl = { fg = utils.get_highlight("DiagnosticInfo").fg },
    },
    {
        provider = function(self)
            return self.hints > 0 and (self.hint_icon .. self.hints)
        end,
        hl = { fg = utils.get_highlight("DiagnosticHint").fg },
    },
}

local Snippets = {
    -- check that we are in insert or select mode
    condition = function()
        return vim.tbl_contains({ "s", "i" }, vim.fn.mode())
    end,
    provider = function()
        local luasnip = require("luasnip")
        --   elseif luasnip.jumpable(-1) then
        print(luasnip.jumpable(-1))
        local forward = luasnip.jumpable(1) and " " or ""
        local backward = luasnip.jumpable(-1) and " " or ""
        return backward .. forward
    end,
    hl = { fg = colors.red, syle = "bold" },
}

local coords = {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %P = percentage through file of displayed window
    provider = function()
        -- return "%7(%l/%3L%):%2c %P " .. progress_bar() .. " "
        return "%4(%l%):%2c"
    end,
    init = function(self)
        self.mode = vim.fn.mode(1)
    end,
    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { fg = mode_colors[mode] }
    end,
}
local word_count = {
    init = function(self)
        self.mode = vim.fn.mode(1)
    end,
    provider = function()
        return "%5(" .. word_counter() .. "%) "
    end,
    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { fg = mode_colors[mode] }
    end,
    condition = conditions.is_active(),
}

WorkDir = utilities.surround({ "", "" }, colors.lightbg, WorkDir)
FileNameBlock = utilities.surround(
    { "", "" },
    colors.lightbg,
    FileNameBlock
)

local inactive_statusline = {
    condition = function()
        return not conditions.is_active()
    end,
    WorkDir,
    space,
    FileNameBlock,
    align,
}

local default_statusline = {
    condition = conditions.is_active,
    WorkDir,
    space,
    FileNameBlock,
    space,
    git,
    -- branch,
    -- git_diff,
    align,
    diagnostics,
    space,
    -- utilities.surround({ "", "" }, colors.lightbg, coords),
    -- space,
    utilities.surround({ "", "" }, colors.lightbg, mode_icon),
    space,
    utilities.surround({ "", "" }, colors.lightbg, progress),
    space,
    -- Snippets,
    -- space,
    utilities.surround({ "", "" }, colors.lightbg, word_count),
}

local help_file_line = {
    condition = function()
        return conditions.buffer_matches({
            buftype = { "help", "quickfix" },
        })
    end,
    FileType,
    space,
    align,
    HelpFileName,
    align,
    utilities.surround({ "", "" }, colors.lightbg, progress),
}

local startup_nvim_statusline = {
    condition = function()
        return conditions.buffer_matches({
            filetype = { "startup", "TelescopePrompt" },
        })
    end,
    align,
    -- utilities.surround({ "", "" }, colors.lightbg, {
    --     provider = function()
    --         return "Startup"
    --     end,
    --     hl = { fg = colors.red },
    -- }),
    provider = "",
    align,
}

local statuslines = {
    init = utils.pick_child_on_condition,

    startup_nvim_statusline,
    help_file_line,
    inactive_statusline,
    default_statusline,
}

require("heirline").setup(statuslines)
