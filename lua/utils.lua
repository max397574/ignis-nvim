local M = {}
local cmd = vim.cmd

function M.create_augroup(autocmds, name)
    cmd('augroup ' .. name)
    cmd('autocmd!')
    for _, autocmd in ipairs(autocmds) do
        cmd('autocmd ' .. autocmd)
    end
    cmd('augroup END')
end

M.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

return M
