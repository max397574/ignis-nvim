local lsp_custom = {}
function lsp_custom.VirttextDefinition()
    local position_params = vim.lsp.util.make_position_params()
    local lines
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.lsp.buf_request(
        0,
        "textDocument/definition",
        position_params,
        function(err, result, ...)
            vim.lsp.handlers["textDocument/definition"](err, result, ...)

            if result then
                local lines
                for _, temp in pairs(result) do
                    local bufnr = vim.uri_to_bufnr(temp.targetUri)
                    local start_line_nr = temp.targetRange.start.line
                    lines = vim.api.nvim_buf_get_lines(
                        bufnr,
                        start_line_nr,
                        start_line_nr + 1,
                        false
                    )
                end
                local ns = vim.api.nvim_create_namespace("virttext_definition")
                local line = lines[1]
                -- local line = "local line = lines[1]"
                local line_nr = cursor[1] - 1
                vim.api.nvim_win_set_cursor(0, cursor)
                vim.api.nvim_buf_set_extmark(
                    vim.fn.bufnr(),
                    ns,
                    line_nr,
                    1,
                    { virt_lines = { { { line, "NormalFloat" } } } }
                )
            else
                print("Can't find definition")
            end
        end
    )
end

local a
print(a)

function lsp_custom.RenameWithQuickfix()
    local old_name = vim.fn.expand("<cword>")
    local position_params = vim.lsp.util.make_position_params()
    local new_name = vim.fn.input("New Name > ", old_name)

    position_params.newName = new_name

    vim.lsp.buf_request(
        0,
        "textDocument/rename",
        position_params,
        function(err, result, ...)
            vim.lsp.handlers["textDocument/rename"](err, result, ...)

            print("result")
            dump(result)
            local entries = {}
            if result.changes then
                for uri, edits in pairs(result.changes) do
                    local bufnr = vim.uri_to_bufnr(uri)

                    for _, edit in ipairs(edits) do
                        local start_line = edit.range.start.line + 1
                        local line = vim.api.nvim_buf_get_lines(
                            bufnr,
                            start_line - 1,
                            start_line,
                            false
                        )[1]

                        table.insert(entries, {
                            bufnr = bufnr,
                            lnum = start_line,
                            col = edit.range.start.character + 1,
                            text = line,
                        })
                    end
                end
            end
            vim.fn.setqflist(entries, "r")
            vim.cmd([[copen]])
        end
    )
end

return lsp_custom
