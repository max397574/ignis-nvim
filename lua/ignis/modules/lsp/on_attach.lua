local on_attach = {}

local function lsp_highlight_document(client, bufnr)
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
        vim.api.nvim_create_autocmd("CursorHold", {
            callback = function()
                vim.lsp.buf.document_highlight()
            end,
            buffer = bufnr,
        })
        vim.api.nvim_create_autocmd("CursorMoved", {
            callback = function()
                vim.lsp.buf.clear_references()
            end,
            buffer = bufnr,
        })
    end
end

function on_attach.setup(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, opts)
    vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<C-d>", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<C-f>", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "<Leader>fs", vim.lsp.buf.formatting_sync, opts)
    lsp_highlight_document(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
        -- vim.api.nvim_create_autocmd("BufWritePre", {
        --     buffer = bufnr,
        --     callback = function()
        --         if not vim.bo.ft == "lua" then
        --             print("formatting")
        --             vim.lsp.buf.format()
        --         end
        --     end,
        -- })
    end
end

return on_attach
