local efm = {}

local stylua = { formatCommand = "stylua -", formatStdin = true }

local luaformat = { formatCommand = "lua-format -i", formatStdin = true }

local selene = {
    lintCommand = "selene --display-style quiet -",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = { "%f:%l:%c: %tarning%m", "%f:%l:%c: %tarning%m" },
}

efm.config = {
    init_options = { documentFormatting = true },
    settings = {
        rootMarkers = { "package.json", ".git" },
        languages = {
            lua = {
                selene,
                stylua,
                luaformat,
            },
        },
    },
}

return efm
