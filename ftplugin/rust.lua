local function on_attach(client, bufnr)
    require("ignis.modules.lsp.on_attach").setup(client, bufnr)
end

local extension_path = vim.fn.expand("~")
    .. "/.vscode/extensions/vadimcn.vscode-lldb-1.7.0/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
require("rust-tools").setup({
    dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(
            codelldb_path,
            liblldb_path
        ),
    },
    server = {
        on_attach = on_attach,
    },
})
