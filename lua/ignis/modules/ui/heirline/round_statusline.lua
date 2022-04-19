-- credits for icons go to https://github.com/tamton-aquib/staline.nvim/blob/49915550f77353f3134036d566ed359587f2d71b/lua/staline/config.lua
-- local leftbracket = "" -- Curve.
-- local rightbracket = "" -- Curve.
-- local leftbracket = u 'e0b2' -- Angle filled.
-- local rightbracket = u 'e0b0' -- Angle filled.
-- local leftbracket = u 'e0b3' -- Angle.
-- local rightbracket = u 'e0b1' -- Angle.
local conditions = require("heirline.conditions")
local utilities = require("heirline.utils")
local utils = require("heirline.utils")
local align = { provider = "%=" }
local space = { provider = " " }
local colors = require("colors").get()

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
    tex = "ﭨ ",
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
    norg = " ",
    txt = " ",
}

-- ""
-- ""

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

local FileNameBlock = {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
        self.mode = vim.fn.mode(1)
    end,
}

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
        -- return self.icon and (" " .. self.icon .. " ")
        return self.icon and (" " .. self.icon)
    end,
    hl = function(self)
        if use_dev_icons then
            return { fg = self.icon_color }
        else
            return { fg = colors.black, bg = colors.blue }
        end
    end,
    condition = function()
        return vim.tbl_contains(vim.tbl_keys(file_icons), vim.bo.ft)
    end,
}

local FileName = {
    provider = function(self)
        local filename = vim.fn.fnamemodify(self.filename, ":t")
        if filename == "" then
            return ""
        end
        if not conditions.width_percent_below(#filename, 0.25) then
            filename = vim.fn.pathshorten(filename)
        end
        return filename .. " "
    end,
    hl = function()
        return { fg = colors.black }
    end,
}

local FileFlags = {
    {
        provider = function()
            if vim.bo.modified then
                return " "
            end
        end,
        hl = function()
            return { fg = colors.black }
        end,
    },
    {
        provider = function()
            if not vim.bo.modifiable or vim.bo.readonly then
                return ""
            end
        end,
        hl = function(self)
            local mode = self.mode:sub(1, 1)
            return { fg = mode_colors[mode] }
        end,
    },
}

local FileIconSurroundF = {
    {
        provider = function()
            return ""
        end,
        hl = function(_)
            return { fg = colors.blue, bg = "none" }
        end,
        condition = function()
            return vim.tbl_contains(vim.tbl_keys(file_icons), vim.bo.ft)
        end,
    },
}
local FileIconSurroundB = {
    {
        provider = function()
            return " "
        end,
        hl = function(_)
            return { bg = colors.nord_blue, fg = colors.blue }
        end,
        condition = function()
            return vim.tbl_contains(vim.tbl_keys(file_icons), vim.bo.ft)
        end,
    },
}
local FileNameSurround = {
    {
        provider = function()
            return ""
        end,
        hl = function(_)
            return { fg = colors.nord_blue, bg = "none" }
        end,
        condition = function()
            return not vim.tbl_contains(vim.tbl_keys(file_icons), vim.bo.ft)
        end,
    },
}

FileNameBlock = utils.insert(
    FileNameBlock,
    FileIconSurroundF,
    FileIcon,
    FileIconSurroundB,
    FileNameSurround,
    FileName,
    unpack(FileFlags),
    {
        provider = "%<",
    }
)
FileNameBlock = utilities.surround(
    { "", "" },
    colors.nord_blue,
    FileNameBlock
)

FileNameBlock[1]["condition"] = function()
    return not conditions.buffer_matches({
        filetype = { "dashboard" },
    })
end
FileNameBlock[2]["condition"] = function()
    return not conditions.buffer_matches({
        filetype = { "dashboard" },
    })
end
FileNameBlock[3]["condition"] = function()
    return not conditions.buffer_matches({
        filetype = { "dashboard" },
    })
end

local option_value = {
    provider = function()
        return require("dynamic_help.extras.statusline").value()
    end,
    hl = { fg = colors.blue },
}

local dyn_help_available = {
    provider = function()
        return require("dynamic_help.extras.statusline").available()
    end,
    hl = { fg = colors.yellow },
}

local git = {
    condition = conditions.is_git_repo,

    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0
            or self.status_dict.removed ~= 0
            or self.status_dict.changed ~= 0
    end,

    hl = { fg = colors.orange },

    {
        provider = function(self)
            return " " .. self.status_dict.head .. " "
        end,
    },
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
    {
        provider = function()
            return "  "
        end,
        hl = function(_)
            return { fg = colors.black, bg = colors.vibrant_green }
        end,
    },
    {
        provider = function()
            return ""
        end,
        hl = { fg = colors.vibrant_green, bg = colors.green },
    },
    {
        provider = function()
            local cwd = vim.fn.getcwd(0)
            cwd = vim.fn.fnamemodify(cwd, ":~")
            if not conditions.width_percent_below(#cwd, 0.25) then
                cwd = vim.fn.pathshorten(cwd)
            end
            local trail = cwd:sub(-1) == "/" and "" or "/"
            return " " .. cwd .. trail
        end,
        hl = { bg = colors.green, fg = colors.black },
    },
}

local mode_icon = {
    {
        init = function(self)
            self.mode = vim.fn.mode(1)
        end,
        provider = function()
            return ""
        end,
        hl = function(self)
            local mode = self.mode:sub(1, 1)
            return { fg = mode_colors[mode] }
        end,
    },
    {
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
            mode_names = {
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
            local mode = self.mode:sub(1, 1)
            return { bg = mode_colors[mode], fg = colors.black }
        end,
        provider = function(self)
            return "%2(" .. self.mode_icons[self.mode:sub(1, 1)] .. "%)" .. " "
        end,
    },
    {
        init = function(self)
            self.mode = vim.fn.mode(1)
        end,
        provider = function()
            return ""
        end,
        hl = function(self)
            local mode = self.mode:sub(1, 1)
            return { fg = mode_colors[mode] }
        end,
    },
}

local function progress_bar()
    local sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇" }
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor(curr_line / lines * (#sbar - 1)) + 1
    return sbar[i]
end

local progress = {
    {
        provider = function()
            return ""
        end,
        hl = function(_)
            return { fg = colors.pink, bg = "none" }
        end,
    },
    {
        provider = function()
            return "%3(%P%)"
        end,
        hl = { bg = colors.pink, fg = colors.black },
    },
    {
        provider = function()
            return ""
        end,
        hl = function(_)
            return { fg = colors.pink, bg = colors.dark_purple }
        end,
    },
    {
        provider = function()
            -- return "%3(%P%) " .. progress_bar() .. " "
            return " " .. progress_bar() .. " "
        end,
        hl = function()
            return { bg = colors.dark_purple, fg = colors.black }
        end,
    },
    {
        provider = function()
            return ""
        end,
        hl = function(_)
            return { fg = colors.dark_purple, bg = "none" }
        end,
    },
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

local lsp_progress = {
    condition = function()
        if #vim.lsp.get_active_clients() == 0 then
            return false
        end
        return true
    end,
    hl = { fg = colors.blue },
    provider = function()
        local messages = vim.lsp.util.get_progress_messages()
        if #messages == 0 then
            return ""
        end
        local status = {}
        for _, msg in pairs(messages) do
            table.insert(status, msg.percentage or 0)
        end
        local spinners = {
            "⠋",
            "⠙",
            "⠹",
            "⠸",
            "⠼",
            "⠴",
            "⠦",
            "⠧",
            "⠇",
            "⠏",
        }
        local ms = vim.loop.hrtime() / 1000000
        local frame = math.floor(ms / 120) % #spinners
        return spinners[frame + 1] .. " " .. table.concat(status, " | ")
    end,
}

local Snippets = {
    condition = function()
        return vim.tbl_contains({ "s", "i" }, vim.fn.mode())
    end,
    provider = function()
        local luasnip = require("luasnip")
        local forward = luasnip.jumpable(1) and " " or ""
        local backward = luasnip.jumpable(-1) and " " or ""
        return backward .. forward
    end,
    hl = { fg = colors.red, syle = "bold" },
}

local coords = {
    {
        provider = function()
            return ""
        end,
        hl = { fg = colors.orange },
    },
    {
        provider = function()
            return "  "
        end,
        hl = { fg = colors.black, bg = colors.orange },
    },
    {
        provider = function()
            return ""
        end,
        hl = { fg = colors.orange, bg = colors.yellow },
    },
    {
        provider = function()
            return "%4(%l%):%2c"
        end,
        hl = function()
            return { fg = colors.black, bg = colors.yellow }
        end,
    },
    {
        provider = function()
            return ""
        end,
        hl = { fg = colors.yellow },
    },
}
local word_count = {
    {
        init = function(self)
            self.mode = vim.fn.mode(1)
        end,
        provider = function()
            return ""
        end,
        hl = function(self)
            local mode = self.mode:sub(1, 1)
            return { fg = mode_colors[mode] }
        end,
    },
    {
        init = function(self)
            self.mode = vim.fn.mode(1)
        end,
        provider = function()
            return "%5(" .. word_counter() .. "%) "
        end,
        hl = function(self)
            local mode = self.mode:sub(1, 1)
            return { bg = mode_colors[mode], fg = colors.black }
        end,
        condition = conditions.is_active(),
    },
    {
        init = function(self)
            self.mode = vim.fn.mode(1)
        end,
        provider = function()
            return ""
        end,
        hl = function(self)
            local mode = self.mode:sub(1, 1)
            return { fg = mode_colors[mode] }
        end,
    },
}

WorkDir = utilities.surround({ "", "" }, colors.green, WorkDir)

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
    option_value,
    space,
    lsp_progress,
    diagnostics,
    space,
    align,
    Snippets,
    space,
    dyn_help_available,
    space,
    coords,
    space,
    -- utilities.surround({ "", "" }, colors.lightbg, mode_icon),
    mode_icon,
    space,
    -- utilities.surround({ "", "" }, colors.lightbg, progress),
    progress,
    space,
    -- utilities.surround({ "", "" }, colors.lightbg, word_count),
    word_count,
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

return statuslines
