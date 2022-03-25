local null_ls = require("null-ls")
--
local sources = {
    -- null_ls.builtins.formatting.clang_format, -- errors with offset encoding
    -- null_ls.builtins.formatting.latexindent,
    -- null_ls.builtins.formatting.prettier.with({
    --     filetypes = { "markdown" },
    -- filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "css", "scss", "less", "html", "json", "yaml", "markdown", "graphql" },
    -- }),
    null_ls.builtins.formatting.stylua.with({
        extra_args = { "--indent-type", "Spaces", "--indent-width", "4" },
    }),
    null_ls.builtins.formatting.rustfmt,
    -- null_ls.builtins.formatting.trim_whitespace, -- disable that for cpp
    -- null_ls.builtins.formatting.uncrustify,
    -- null_ls.builtins.diagnostics.cppcheck, -- errors with offset encoding
    -- null_ls.builtins.diagnostics.gitlint,
    -- null_ls.builtins.diagnostics.luacheck,
    -- null_ls.builtins.diagnostics.selene,
}

local cfg = {
    sources = sources,

    root_dir = require("lspconfig").util.root_pattern(
        ".venv", -- for python
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
        "node_modules",
        "xmake.lua",
        "CMakeLists.txt",
        ".null-ls-root",
        "Makefile",
        "package.json",
        "tsconfig.json",
        ".git"
    ),

    on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
            vim.cmd(
                "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()"
            )
        end
    end,
}

null_ls.setup(cfg)
