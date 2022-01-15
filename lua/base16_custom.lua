local function highlight(group, guifg, guibg, attr, guisp)
    local parts = { group }
    if guifg then
        table.insert(parts, "guifg=#" .. guifg)
    end
    if guibg then
        table.insert(parts, "guibg=#" .. guibg)
    end
    if attr then
        table.insert(parts, "gui=" .. attr)
    end
    if guisp then
        table.insert(parts, "guisp=#" .. guisp)
    end

    -- nvim.ex.highlight(parts)
    vim.api.nvim_command("highlight " .. table.concat(parts, " "))
end

-- Modified from https://github.com/chriskempson/base16-vim
local function apply_base16_theme(theme)
    highlight("LspDiagnosticsDefaultError", theme.base08, nil, nil, nil)
    highlight("LspDiagnosticsDefaultWarning", theme.base0A, nil, nil, nil)
    highlight("LspDiagnosticsDefaultWarn", theme.base0A, nil, nil, nil)
    highlight("LspDiagnosticsDefaultInformation", theme.base0D, nil, nil, nil)
    highlight("LspDiagnosticsDefaultInfo", theme.base0D, nil, nil, nil)
    highlight("LspDiagnosticsDefaultHint", theme.base0C, nil, nil, nil)

    highlight("DiagnosticError", theme.base08, nil, nil, nil)
    highlight("DiagnosticWarn", theme.base0A, nil, nil, nil)
    highlight("DiagnosticInfo", theme.base0D, nil, nil, nil)
    highlight("DiagnosticHint", theme.base0C, nil, nil, nil)

    highlight("TelescopeNormal", theme.base05, theme.base00, nil, nil)
    highlight("TelescopePreviewNormal", theme.base05, theme.base00, nil, nil)
    highlight("Keyword", theme.base0E, nil, "Italic", nil)
    highlight("PMenu", theme.base05, theme.base00, "none", nil)
    -- highlight("RequireCall", theme.base0C, nil, "italic,bold", nil)
    highlight("CmpItemKindConstant", theme.base09, nil, nil, nil)
    -- highlight("FloatBorder", theme.base0D, nil, nil, nil)
    highlight("CmpItemKindFunction", theme.base0D, nil, nil, nil)
    highlight("CmpItemKindIdentifier", theme.base08, nil, "none", nil)
    highlight("CmpItemKindField", theme.base08, nil, "none", nil)
    highlight("CmpItemKindVariable", theme.base0E, nil, "italic", nil)
    highlight("CmpItemKindVariable", theme.base0E, nil, "italic", nil)
    highlight("Special", theme.base0C, nil, "italic", nil)
    highlight("CmpItemKindSnippet", theme.base0C, nil, "italic", nil)
    highlight("CmpItemKindText", theme.base0B, nil, nil, nil)
    highlight("CmpItemKindStructure", theme.base0E, nil, nil, nil)
    highlight("CmpItemKindType", theme.base0A, nil, "none", nil)
    highlight("markdownBold", theme.base0A, nil, "bold", nil)
end

return setmetatable({
    themes = function(name)
        name = "themes/" .. name .. "-base16"
        local present, theme_array = pcall(require, name)
        if present then
            return theme_array
        else
            error("No such base16 theme: " .. name)
        end
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
