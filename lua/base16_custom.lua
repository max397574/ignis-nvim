-- code from https://github.com/NvChad/nvim-base16.lua
local function highlight(group, guifg, guibg, attr, guisp)
    local arg = {}
    if guifg then
        arg["fg"] = "#" .. guifg
    end
    if guibg then
        arg["bg"] = "#" .. guibg
    end
    if attr then
        if type(attr) == "table" then
            for _, at in ipairs(attr) do
                arg[at] = true
            end
        else
            arg[attr] = true
        end
    end
    if guisp then
        arg["sp"] = guisp
        -- table.insert(arg, "guisp=#" .. guisp)
    end

    -- nvim.ex.highlight(parts)
    vim.api.nvim_set_hl(0, group, arg)
end

-- Modified from https://github.com/chriskempson/base16-vim
local function apply_base16_theme(theme)
    vim.g.color_base_01 = "#" .. theme.base01
    vim.g.color_base_09 = "#" .. theme.base09
    vim.g.color_base_0F = "#" .. theme.base0F
    highlight("LspDiagnosticsDefaultError", theme.base08, nil, nil, nil)
    highlight("LspDiagnosticsDefaultWarning", theme.base0A, nil, nil, nil)
    highlight("LspDiagnosticsDefaultWarn", theme.base0A, nil, nil, nil)
    highlight("LspDiagnosticsDefaultInformation", theme.base0D, nil, nil, nil)
    highlight("LspDiagnosticsDefaultInfo", theme.base0D, nil, nil, nil)
    highlight("LspDiagnosticsDefaultHint", theme.base0C, nil, nil, nil)

    -- highlight("DiagnosticError", theme.base08, nil, nil, nil)
    -- highlight("DiagnosticWarn", theme.base0A, nil, nil, nil)
    -- highlight("DiagnosticInfo", theme.base0D, nil, nil, nil)
    -- highlight("DiagnosticHint", theme.base0C, nil, nil, nil)

    highlight("TelescopeNormal", theme.base05, theme.base00, nil, nil)
    highlight("TelescopePreviewNormal", theme.base05, theme.base00, nil, nil)
    highlight("Keyword", theme.base0E, nil, "italic", nil)
    highlight("PMenu", theme.base05, theme.base00, nil, nil)
    -- highlight("RequireCall", theme.base0C, nil, "italic,bold", nil)
    highlight("CmpItemKindConstant", theme.base09, nil, nil, nil)
    -- highlight("FloatBorder", theme.base0D, nil, nil, nil)
    highlight("CmpItemKindFunction", theme.base0D, nil, nil, nil)
    highlight("CmpItemKindIdentifier", theme.base08, nil, nil, nil)
    highlight("CmpItemKindField", theme.base08, nil, nil, nil)
    highlight("CmpItemKindVariable", theme.base0E, nil, "italic", nil)
    highlight("CmpItemKindVariable", theme.base0E, nil, "italic", nil)
    highlight("Special", theme.base0C, nil, "italic", nil)
    highlight("CmpItemKindSnippet", theme.base0C, nil, "italic", nil)
    highlight("CmpItemKindText", theme.base0B, nil, nil, nil)
    highlight("CmpItemKindStructure", theme.base0E, nil, nil, nil)
    highlight("CmpItemKindType", theme.base0A, nil, nil, nil)
    highlight("markdownBold", theme.base0A, nil, "bold", nil)
    highlight("FunctionDefinition", theme.base0D, nil, "italic", nil)
    highlight("RequireCall", theme.base0E, nil, "italic", nil)
    highlight("TSEmphasis", theme.base05, nil, "italic", nil)
    -- highlight("RequireCall", theme.base0D, nil, "italic", nil)
end

return setmetatable({
    themes = function(name)
        local path = "lua/themes/" .. name .. "-base16.lua"
        local files = vim.api.nvim_get_runtime_file(path, true)
        local theme_array
        if #files == 0 then
            error("No such base16 theme: " .. name)
        elseif #files == 1 then
            theme_array = dofile(files[1])
        else
            local nvim_base_pattern = "nvim-base16.lua/lua/themes"
            local valid_file = false
            for _, file in ipairs(files) do
                if not file:find(nvim_base_pattern) then
                    theme_array = dofile(file)
                    valid_file = true
                end
            end
            if not valid_file then
                -- multiple files but in startup repo shouldn't happen so just use first one
                theme_array = dofile(files[1])
            end
        end
        return theme_array
    end,
    apply_theme = apply_base16_theme,
    theme_from_array = function(array)
        assert(
            #array == 16,
            "base16.theme_from_array: The array length must be 16"
        )
        local result = {}
        for i, value in ipairs(array) do
            assert(
                #value == 6,
                "base16.theme_from_array: array values must be in 6 digit hex format, e.g. 'ffffff'"
            )
            local key = ("base%02X"):format(i - 1)
            result[key] = value
        end
        return result
    end,
}, {
    __call = function(_, ...)
        apply_base16_theme(...)
    end,
})
