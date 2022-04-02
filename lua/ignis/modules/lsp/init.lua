vim.cmd([[hi DiagnosticHeader gui=bold,italic guifg=#56b6c2]])
vim.cmd([[au CursorHold  * lua vim.diagnostic.open_float()]])

local util = require("ignis.utils")

local root_pattern = require("lspconfig.util").root_pattern

local lua_cmd = {
    vim.fn.expand("~") .. "/lua-language-server/bin/lua-language-server",
}

local lsp_conf = {}

function lsp_conf.preview_location(location, context, before_context)
    -- location may be LocationLink or Location (more useful for the former)
    context = context or 15
    before_context = before_context or 0
    local uri = location.targetUri or location.uri
    if uri == nil then
        return
    end
    local bufnr = vim.uri_to_bufnr(uri)
    if not vim.api.nvim_buf_is_loaded(bufnr) then
        vim.fn.bufload(bufnr)
    end

    local range = location.targetRange or location.range
    local contents = vim.api.nvim_buf_get_lines(
        bufnr,
        range.start.line - before_context,
        range["end"].line + 1 + context,
        false
    )
    local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
    return vim.lsp.util.open_floating_preview(
        contents,
        filetype,
        { border = "single" }
    )
end

function lsp_conf.preview_location_callback(_, result)
    local context = 15
    if result == nil or vim.tbl_isempty(result) then
        return nil
    end
    if vim.tbl_islist(result) then
        lsp_conf.floating_buf, lsp_conf.floating_win =
            lsp_conf.preview_location(
                result[1],
                context
            )
    else
        lsp_conf.floating_buf, lsp_conf.floating_win =
            lsp_conf.preview_location(
                result,
                context
            )
    end
end

function lsp_conf.PeekDefinition()
    if vim.tbl_contains(vim.api.nvim_list_wins(), lsp_conf.floating_win) then
        vim.api.nvim_set_current_win(lsp_conf.floating_win)
    else
        local params = vim.lsp.util.make_position_params()
        return vim.lsp.buf_request(
            0,
            "textDocument/definition",
            params,
            lsp_conf.preview_location_callback
        )
    end
end

function lsp_conf.PeekTypeDefinition()
    if vim.tbl_contains(vim.api.nvim_list_wins(), lsp_conf.floating_win) then
        vim.api.nvim_set_current_win(lsp_conf.floating_win)
    else
        local params = vim.lsp.util.make_position_params()
        return vim.lsp.buf_request(
            0,
            "textDocument/typeDefinition",
            params,
            lsp_conf.preview_location_callback
        )
    end
end

function lsp_conf.PeekImplementation()
    if vim.tbl_contains(vim.api.nvim_list_wins(), lsp_conf.floating_win) then
        vim.api.nvim_set_current_win(lsp_conf.floating_win)
    else
        local params = vim.lsp.util.make_position_params()
        return vim.lsp.buf_request(
            0,
            "textDocument/implementation",
            params,
            lsp_conf.preview_location_callback
        )
    end
end

local signs = { Error = "", Warn = "", Info = "", Hint = "" }
for sign, icon in pairs(signs) do
    vim.fn.sign_define("DiagnosticSign" .. sign, {
        text = icon,
        texthl = "Diagnostic" .. sign,
        linehl = false,
        numhl = "Diagnostic" .. sign,
    })
end
-- local border = {
--   { "┏", "FloatBorder" },
--   { "━", "FloatBorder" },
--   { "┓", "FloatBorder" },
--   { "┃", "FloatBorder" },
--   { "┛", "FloatBorder" },
--   { "━", "FloatBorder" },
--   { "┗", "FloatBorder" },
--   { "┃", "FloatBorder" },
-- }

-- local border = {
--     { "╔", "FloatBorder" },
--     { "═", "FloatBorder" },
--     { "╗", "FloatBorder" },
--     { "║", "FloatBorder" },
--     { "╝", "FloatBorder" },
--     { "═", "FloatBorder" },
--     { "╚", "FloatBorder" },
--     { "║", "FloatBorder" },
-- }

-- local border = {
--   { "🭽","FloatBorder"},
--   { "▔","FloatBorder"},
--   { "🭾","FloatBorder"},
--   { "▕","FloatBorder"},
--   { "🭿","FloatBorder"},
--   { "▁","FloatBorder"},
--   { "🭼","FloatBorder"},
--   { "▏","FloatBorder"},
-- }

-- local border = {
--   {  "▛","FloatBorder"},
--   {  "▀","FloatBorder"},
--   {  "▜","FloatBorder"},
--   {  "▐","FloatBorder"},
--   {  "▟","FloatBorder"},
--   {  "▄","FloatBorder"},
--   {  "▙","FloatBorder"},
--   {  "▌","FloatBorder"},
-- }

local border = {
    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" },
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = border }
)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = border }
)

local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport =
    true
capabilities.textDocument.completion.completionItem.tagSupport = {
    valueSet = { 1 },
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
}
capabilities.textDocument.codeAction = {
    dynamicRegistration = false,
    codeActionLiteralSupport = {
        codeActionKind = {
            valueSet = {
                "",
                "quickfix",
                "refactor",
                "refactor.extract",
                "refactor.inline",
                "refactor.rewrite",
                "source",
                "source.organizeImports",
            },
        },
    },
}

local function on_attach(client, bufnr)
    require("ignis.modules.lsp.on_attach").setup(client, bufnr)
end

local servers = {
    pyright = {},
    jedi_language_server = {},
    dockerls = {},
    tsserver = {},
    cssls = { cmd = { "css-languageserver", "--stdio" } },
    rnix = {},
    -- rust_analyzer = {
    --     root_dir = root_pattern("Cargo.toml", "rust-project.json", ".git"),
    -- },
    hls = {
        root_dir = root_pattern(
            ".git",
            "*.cabal",
            "stack.yaml",
            "cabal.project",
            "package.yaml",
            "hie.yaml"
        ),
    },
    texlab = require("configs.tex").config(),
    html = { cmd = { "html-languageserver", "--stdio" } },
    intelephense = {},
    vimls = {},
}

local sumneko_lua_server = {
    on_attach = on_attach,
    cmd = lua_cmd,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "dump", "hs", "lvim", "P", "RELOAD", "neorg" },
            },
            workspace = {
                maxPreload = 100000,
                preloadFileSize = 1000,
            },
        },
    },
}

local enable_lua_dev = true
local lua_dev_plugins = {
    "selection_popup",
    "sqlite.lua",
}
local runtime_path_completion = true
if not runtime_path_completion then
    sumneko_lua_server.settings.Lua.runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
        vim.fn.expand("~") .. "/.config/nvim_config/lua/?.lua",
    }
end

if enable_lua_dev then
    local luadev = require("lua-dev").setup({
        library = {
            vimruntime = true,
            types = true,
            plugins = lua_dev_plugins, -- toggle this to get completion for require of all plugins
        },
        runtime_path = runtime_path_completion,
        lspconfig = sumneko_lua_server,
    })

    lspconfig.sumneko_lua.setup(luadev)
else
    lspconfig.sumneko_lua.setup(sumneko_lua_server)
end

for server, config in pairs(servers) do
    lspconfig[server].setup(vim.tbl_deep_extend("force", {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        },
    }, config))
    local cfg = lspconfig[server]
    if not (cfg and cfg.cmd and vim.fn.executable(cfg.cmd[1]) == 1) then
        util.error(server .. ": cmd not found: " .. vim.inspect(cfg.cmd))
    end
end

local codes = {
    -- unused_assignment={
    --     messages="x",
    --     "unused_assignments"
    -- },
    no_matching_function = {
        message = " Can't find a matching function",
        "redundant-parameter",
        "ovl_no_viable_function_in_call",
    },
    empty_block = {
        message = " That shouldn't be empty here",
        "empty-block",
    },
    missing_symbol = {
        message = " Here should be a symbol",
        "miss-symbol",
    },
    expected_semi_colon = {
        message = " Remember the `;` or `,`",
        "expected_semi_declaration",
        "miss-sep-in-table",
        "invalid_token_after_toplevel_declarator",
    },
    redefinition = {
        message = " That variable was defined before",
        "redefinition",
        "redefined-local",
    },
    no_matching_variable = {
        message = " Can't find that variable",
        "undefined-global",
        "reportUndefinedVariable",
    },
    trailing_whitespace = {
        message = " Remove trailing whitespace",
        "trailing-whitespace",
        "trailing-space",
    },
    unused_variable = {
        message = " Don't define variables you don't use",
        "unused-local",
    },
    unused_function = {
        message = " Don't define functions you don't use",
        "unused-function",
    },
    useless_symbols = {
        message = " Remove that useless symbols",
        "unknown-symbol",
    },
    wrong_type = {
        message = " Try to use the correct types",
        "init_conversion_failed",
    },
    undeclared_variable = {
        message = " Have you delcared that variable somewhere?",
        "undeclared_var_use",
    },
    lowercase_global = {
        message = " Should that be a global? (if so make it uppercase)",
        "lowercase-global",
    },
}

vim.diagnostic.config({
    float = {
        focusable = false,
        border = border,
        scope = "cursor",
        format = function(diagnostic)
            -- dump(diagnostic)
            if diagnostic.user_data == nil then
                return diagnostic.message
            elseif vim.tbl_isempty(diagnostic.user_data) then
                return diagnostic.message
            end
            local code = diagnostic.user_data.lsp.code
            for _, table in pairs(codes) do
                if vim.tbl_contains(table, code) then
                    return table.message
                end
            end
            return diagnostic.message
        end,
        header = { "Cursor Diagnostics:", "DiagnosticHeader" },
        prefix = function(diagnostic, i, total)
            local icon, highlight
            if diagnostic.severity == 1 then
                icon = ""
                highlight = "DiagnosticError"
            elseif diagnostic.severity == 2 then
                icon = ""
                highlight = "DiagnosticWarn"
            elseif diagnostic.severity == 3 then
                icon = ""
                highlight = "DiagnosticInfo"
            elseif diagnostic.severity == 4 then
                icon = ""
                highlight = "DiagnosticHint"
            end
            return i .. "/" .. total .. " " .. icon .. "  ", highlight
        end,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    virtual_text = false,
    severity_sort = true,
})

configs.emmet_ls = {
    default_config = {
        cmd = { "ls_emmet", "--stdio" },
        filetypes = {
            "html",
            "css",
            "scss",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "haml",
            "xml",
            "xsl",
            "pug",
            "slim",
            "sass",
            "stylus",
            "less",
            "sss",
        },
        root_dir = function(fname)
            return vim.loop.cwd()
        end,
        settings = {},
    },
}

require("ignis.modules.lsp.null_ls")

lspconfig.emmet_ls.setup({ capabilities = capabilities })

return lsp_conf
