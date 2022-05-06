local exp = vim.fn.expand
local nore_silent = { noremap = true, silent = true }

require("toggleterm").setup({
    hide_numbers = true,
    start_in_insert = true,
    insert_mappings = true,
    open_mapping = [[<c-t>]],
    shade_terminals = true,
    shading_factor = "3",
    persist_size = true,
    close_on_exit = false,
    direction = "float",
    float_opts = {
        -- border = "shadow",
        border = require"ignis.utils".border(),
        winblend = 0,
        highlights = {
            border = "FloatBorder",
            background = "NormalFloat",
        },
    },
})
local files = {
    python = "python3 -i " .. exp("%:t"),
    lua = "lua " .. exp("%:t"),
    applescript = "osascript " .. exp("%:t"),
    c = "gcc -o temp " .. exp("%:t") .. " && ./temp && rm ./temp",
    cpp = "clang++ -o temp " .. exp("%:t") .. " && ./temp && rm ./temp",
    java = "javac "
        .. exp("%:t")
        .. " && java "
        .. exp("%:t:r")
        .. " && rm *.class",
    rust = "cargo run",
    javascript = "node " .. exp("%:t"),
    typescript = "tsc " .. exp("%:t") .. " && node " .. exp("%:t:r") .. ".js",
}

local function Run_file()
    vim.cmd([[w]])
    local command = files[vim.bo.filetype]
    if command ~= nil then
        require("toggleterm.terminal").Terminal
            :new({ cmd = command, close_on_exit = false })
            :toggle()
        print("Running: " .. command)
    end
end

vim.keymap.set("n", "<leader>r", Run_file, nore_silent)

local function toggle_lazygit()
    require("toggleterm.terminal").Terminal
        :new({ cmd = "lazygit", close_on_exit = true })
        :toggle()
end

vim.keymap.set("n", "<c-g>", toggle_lazygit, nore_silent)
