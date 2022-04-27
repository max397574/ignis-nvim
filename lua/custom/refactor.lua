local function place_sign(line)
    vim.fn.sign_define(
        "else_warn",
        { text = " ඞ", texthl = "DiagnosticError" }
    )
    vim.fn.sign_place(
        line,
        "",
        "else_warn",
        vim.fn.expand("%:p"),
        { lnum = line + 1 }
    )
end

local refact = {}

function refact.find_else()
    if vim.api.nvim_buf_line_count(0) > 100 then
        return
    end

    local lines = vim.api.nvim_buf_get_lines(0, 1, -1, false)
    vim.cmd([[ hi Sus guifg=#eb6c76 gui=bold ]]) -- gui=underline

    for l, line in ipairs(lines) do
        if line:match("else ") then
            place_sign(l)
        end
    end
end

function refact.find_big_files()
    require("toggleterm.terminal").Terminal
        :new({
            cmd = "find . -name '*.lua' | xargs wc -l | sort -n -r | head -n 10",
            close_on_exit = false,
            direction = "float",
        })
        :toggle()
end

return refact
