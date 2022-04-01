local dashboard = {}

local function center(dict)
    local new_dict = {}
    for _, v in pairs(dict) do
        local padding = vim.fn.max(vim.fn.map(dict, "strwidth(v:val)"))
        local spacing = (" "):rep(math.floor((vim.o.columns - padding) / 2))
            .. v
        table.insert(new_dict, spacing)
    end
    return new_dict
end

local header = {
    "",
    "",
    "",
    "",
    "",
    [[⠀⠀⠀⠀▀▄▄▄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀                                              ]],
    [[⠀⠀⠀⠀⠀⠀████▄▄⠀⠀⠀⠀⠀⠀⠀      ██▓  ▄████  ███▄    █  ██▓  ██████     ]],
    [[⠀⠀⠀⠀⠀▐██▓▓██▄⠀⠀⠀⠀⠀⠀     ▓██▒ ██▒ ▀█▒ ██ ▀█   █ ▓██▒▒██    ▒     ]],
    [[⠀⠀⠀⠀▐██▓▓▓▓██▄ ⠀⠀⠀⠀     ▒██▒▒██░▄▄▄░▓██  ▀█ ██▒▒██▒░ ▓██▄       ]],
    [[⠀⠀ ▄██▓▓▓▓▓▓▓██▄⠀⠀⠀     ░██░░▓█  ██▓▓██▒  ▐▌██▒░██░  ▒   ██▒    ]],
    [[⠀▄██▓▓▓▓▓▒▓▓▓▓███⠀⠀     ░██░░▒▓███▀▒▒██░   ▓██░░██░▒██████▒▒    ]],
    [[▐█▓▓▓▓▓▓▒░▒▓▓▓▓██▌⠀     ░▓   ░▒   ▒ ░ ▒░   ▒ ▒ ░▓  ▒ ▒▓▒ ▒ ░    ]],
    [[▐█▓▓▓▓▓▒░░▒▒▓▓▓██▌⠀      ▒ ░  ░   ░ ░ ░░   ░ ▒░ ▒ ░░ ░▒  ░ ░    ]],
    [[▐██▓▓▒▒░░░░▒▒▓▓▓██▌      ▒ ░░ ░   ░    ░   ░ ░  ▒ ░░  ░  ░      ]],
    [[⠀▀██▓▒░░░░░░▒▓▓██▀⠀      ░        ░          ░  ░        ░      ]],
    [[⠀⠀⠀▀█▓▒░░░░▒▓▓▌ ⠀⠀⠀                                             ]],
}

function dashboard.display()
    if
        not (
            (
                vim.api.nvim_buf_get_number(0) > 1
                or vim.api.nvim_buf_get_lines(0, 0, 1, false)[1]:len() == 0
            ) and vim.api.nvim_buf_get_name(0):len() == 0
        )
    then
        return
    end
    vim.defer_fn(function()
        pcall(vim.cmd, "NeorgStart silent=true")
    end, 200)
    -- local buf = vim.api.nvim_create_buf(false, false)
    -- vim.api.nvim_win_set_buf(0, buf)
    vim.api.nvim_buf_set_option(0, "bufhidden", "wipe")
    vim.api.nvim_buf_set_option(0, "buftype", "nofile")
    vim.api.nvim_put(center(header), "l", true, true)
    vim.cmd([[1]])
    vim.cmd(
        -- [[silent! setlocal nonu nornu autochdir ft=dashboard nocul laststatus=0 nowrap]]
        [[silent! setlocal nonu nornu autochdir ft=dashboard nocul nowrap]]
    )

    vim.api.nvim_set_hl(0, "FireYellow", { fg = "#E1DE24" })
    vim.api.nvim_set_hl(0, "FireOrange", { fg = "#EC9000" })
    vim.api.nvim_set_hl(0, "FireRed", { fg = "#E90000" })
    vim.api.nvim_set_hl(0, "FireDarkRed", { fg = "#780000" })
    vim.fn.matchadd("FireYellow", "[░]")
    vim.fn.matchadd("FireOrange", "[▒]")
    vim.fn.matchadd("FireRed", "[▓]")
    vim.fn.matchadd("FireDarkRed", "[█▄▀▐▌]")
    vim.api.nvim_buf_set_keymap(
        0,
        "n",
        "q",
        "<cmd>q!<CR>",
        { noremap = true, silent = true }
    )
end

return dashboard
