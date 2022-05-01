local extras = {}
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local action_state = require("telescope.actions.state")
local exp = vim.fn.expand
local utils = require("ignis.utils")

extras.ts_theme_chooser = function()
    local themes = {
        {
            "custom_bottom_no_borders",
            "Custom Bottom Layout Strategy Without borders",
        },
        { "float_all_borders", "Float With All Borders" },
        { "float_prompt_border", "Float With Prompt Border Only" },
    }
    ---@type selection_popup
    local selection = require("selection_popup").new_selection(
        "telescope_theme_switcher",
        {}
    )
    selection:title("Telescope Theme Selector"):blank(2)
    for i, theme in ipairs(themes) do
        local f = require("selection_popup").create_flag(i)
        if not f then
            selection:text("Too much projects to display...")
            break
        end
        selection:flag(f, theme[2], {
            callback = function()
                require("custom.db").change_ts_layout(theme[1])
                selection:destroy()
            end,
        })
    end
end

local files = {
    python = "python3 -i " .. vim.fn.stdpath("data") .. "/temp",
    lua = "lua " .. vim.fn.stdpath("data") .. "/temp",
    applescript = "osascript " .. vim.fn.stdpath("data") .. "/temp",
    c = "gcc -o tmp "
        .. vim.fn.stdpath("data")
        .. "/temp"
        .. " && "
        .. vim.fn.stdpath("data")
        .. "/temp"
        .. "&& rm "
        .. vim.fn.stdpath("data")
        .. "/temp",
    cpp = "clang++ -o tmp "
        .. vim.fn.stdpath("data")
        .. "/temp"
        .. " && "
        .. vim.fn.stdpath("data")
        .. "/temp"
        .. "&& rm "
        .. vim.fn.stdpath("data")
        .. "/temp",
    -- java = "javac "
    --     .. vim.fn.stdpath("data").."/temp"
    --     .. " && java "
    --     .. vim.fn.stdpath("data").."/temp"
    --     .. " && rm *.class",
    rust = "cargo run",
    javascript = "node " .. exp("%:t"),
    typescript = "tsc " .. exp("%:t") .. " && node " .. exp("%:t:r") .. ".js",
}
local scratch_buf
local og_win

local function run_file()
    local lines = vim.api.nvim_buf_get_lines(scratch_buf, 0, -1, false)
    local file = io.open(vim.fn.stdpath("data") .. "/temp", "w")
    for _, line in ipairs(lines) do
        file:write(line)
    end
    file:close()
    local command = files[vim.bo.filetype]
    if command ~= nil then
        require("toggleterm.terminal").Terminal
            :new({ cmd = command, close_on_exit = false, direction = "float" })
            :toggle()
        print("Running: " .. command)
    end
end

local function open_scratch_buffer(language)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
    vim.api.nvim_buf_set_keymap(
        buf,
        "n",
        "q",
        "<cmd>q<CR>",
        { noremap = true, silent = true, nowait = true }
    )
    local width = vim.api.nvim_win_get_width(og_win)
    local height = vim.api.nvim_win_get_height(og_win)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "win",
        win = 0,
        width = math.floor(width * 0.8),
        height = math.floor(height * 0.8),
        col = math.floor(width * 0.1),
        row = math.floor(height * 0.1),
        border = "single",
        style = "minimal",
    })
    vim.api.nvim_win_set_option(win, "winblend", 20)
    vim.api.nvim_buf_set_option(buf, "filetype", language)
    scratch_buf = buf
    vim.keymap.set("n", "<leader>r", function()
        run_file()
    end, {
        noremap = true,
        buffer = buf,
        desc = false,
    })
end

local open_scratch = function()
    local entry = action_state.get_selected_entry()
    if entry ~= nil then
        open_scratch_buffer(entry[1])
    end
    vim.fn.feedkeys(utils.t("<ESC><ESC>"), "i")
end

extras.scratch_buf = function(args)
    og_win = vim.api.nvim_get_current_win()
    if args.fargs and args.fargs[1] ~= "" then
        open_scratch_buffer(args.fargs[1])
        return
    end
    local opts = {}
    opts.data = {
        "lua",
        "rust",
        "python",
        "c",
        "cpp",
        -- "java",
        "javascript",
        "typescrip",
        "plain",
        "norg",
    }
    pickers.new(opts, {
        prompt_title = "~ Scratch Picker ~",
        results_title = "~ Scratch Filetypes ~",
        layout_strategy = "custom_bottom",
        finder = finders.new_table(opts.data),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(_, map)
            map("i", "<CR>", open_scratch)
            map("n", "<CR>", open_scratch)
            return true
        end,
    }):find()
end

return extras
