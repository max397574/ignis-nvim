vim.cmd([[PackerLoad telescope-fzf-native.nvim]])
vim.cmd([[PackerLoad telescope-symbols.nvim]])
vim.cmd([[PackerLoad telescope-file-browser.nvim]])
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local ts = {}

local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local fb_actions = require("telescope._extensions.file_browser.actions")
local actions_layout = require("telescope.actions.layout")
local action_state = require("telescope.actions.state")
local themes = require("telescope.themes")
local builtin = require("telescope.builtin")
local tele_utils = require("telescope.utils")
local previewers = require("telescope.previewers")
---@type nvim_config.utils
local utils = require("utils")

local set_options = require("telescope_utils").set_options

local function reloader()
    RELOAD("plenary")
    RELOAD("telescope")
    set_options()
    RELOAD("configs.telescope")
    set_options()
end

function ts.reloader()
    reloader()
end

reloader()

local set_prompt_to_entry_value = function(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    if not entry or not type(entry) == "table" then
        return
    end

    action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

require("telescope").setup({
    defaults = themes.get_ivy({
        -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
        selection_caret = "  ",
        get_status_text = function(self)
            -- local xx = (self.stats.processed or 0) - (self.stats.filtered or 0)
            -- local yy = self.stats.processed or 0
            -- if xx == 0 and yy == 0 then
            --   return ""
            -- end
            --
            -- -- local status_icon
            -- -- if opts.completed then
            -- --   status_icon = "✔️"
            -- -- else
            -- --   status_icon = "*"
            -- -- end
            -- return string.format("%s / %s", xx, yy)
            return ""
        end,
        -- layout_strategy = "horizontal",
        -- custom layout strategy
        layout_strategy = "custom_bottom",
        -- cursor resets after new sort (changing prompt)
        selection_strategy = "reset",
        -- remove stuff from paths when possible so names are still clear
        -- path_display = { "smart" },
        prompt_prefix = "  ",
        shorten_path = true,
        preview = {
            hide_on_startup = true,
        },
        entry_prefix = " ",
        layout_config = {
            width = 0.99,
            height = 0.5,
            -- anchor = "S",
            preview_cutoff = 20,
            prompt_position = "top",
            horizontal = {
                preview_width = 0.65,
                -- preview_width = function(_, cols, _)
                --   if cols > 200 then
                --     return math.floor(cols * 0.5)
                --   else
                --     return math.floor(cols * 0.6)
                --   end
                -- end,
            },
            vertical = {
                preview_width = 0.65,
                width = 0.9,
                height = 0.95,
                preview_height = 0.5,
            },

            flex = {
                preview_width = 0.65,
                horizontal = {
                    -- preview_width = 0.9,
                },
            },
        },
        -- winblend = 20,
        mappings = {
            n = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-o>"] = actions.select_vertical,
                ["<C-q>"] = actions.send_selected_to_qflist
                    + actions.open_qflist,
                ["<C-a>"] = actions.send_to_qflist + actions.open_qflist,
                ["<C-h>"] = "which_key",
                ["<C-l>"] = actions_layout.toggle_preview,
                ["<C-y>"] = set_prompt_to_entry_value,
                ["<C-d>"] = actions.preview_scrolling_up,
                ["<C-f>"] = actions.preview_scrolling_down,
                ["<C-n>"] = require("telescope.actions").cycle_history_next,
                ["<C-u>"] = require("telescope.actions").cycle_history_prev,
            },
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<c-p>"] = action_layout.toggle_prompt_position,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-y>"] = set_prompt_to_entry_value,
                ["<C-o>"] = actions.select_vertical,
                ["<C-q>"] = actions.send_selected_to_qflist
                    + actions.open_qflist,
                ["<C-a>"] = actions.send_to_qflist + actions.open_qflist,
                ["<C-h>"] = "which_key",
                ["<C-l>"] = actions_layout.toggle_preview,
                ["<C-d>"] = actions.preview_scrolling_up,
                ["<C-f>"] = actions.preview_scrolling_down,
                ["<C-n>"] = require("telescope.actions").cycle_history_next,
                ["<C-u>"] = require("telescope.actions").cycle_history_prev,
            },
        },
        extensions = {
            file_browser = {
                -- theme = "ivy",
                mappings = {
                    ["i"] = {
                        ["<C-o>"] = actions.select_vertical,
                        ["<C-b>"] = fb_actions.toggle_browser,
                    },
                    ["n"] = {},
                },
            },
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = false, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            },
        },
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    }),
})

function ts.entry_preview(contents, opts)
    require("telescope_utils").entry_preview(contents, opts)
end

require("telescope").load_extension("fzf")

function ts.cheatsheets() end

function ts.entry_preview_test()
    ts.entry_preview({
        {
            contents = {
                "Title: Entry 1",
                "Name: Test Entry",
                "Length: 120",
            },
            results_name = { "Entry 1" },
        },
        {
            contents = {
                "Title: Entry 2",
                "Name: Another Entry",
                "Length: 60",
            },
            results_name = { "Entry 2" },
        },
    })
end

function ts.file_browser()
    reloader()
    require("telescope").load_extension("file_browser")
    local opts

    opts = {
        --   sorting_strategy = "ascending",
        --   scroll_strategy = "cycle",
        --   prompt_prefix = "  ",
        --   layout_config = {
        --     prompt_position = "top",
        --   },
    }

    require("telescope").extensions.file_browser.file_browser(opts)
end

function ts.find_notes()
    reloader()
    local opts = {
        cwd = "~/notes",
        prompt_title = "~ Notes ~",
    }
    require("telescope.builtin").find_files(opts)
end

function ts.search_config()
    reloader()
    local opts = {
        cwd = "~/.config/nvim_config",
        prompt_title = "~ Neovim Config ~",
    }
    require("telescope.builtin").find_files(opts)
end

function ts.search_plugins()
    reloader()
    local opts = {
        cwd = "~/neovim_plugins/",
        prompt_title = "~ Neovim Config ~",
    }
    require("telescope.builtin").find_files(opts)
end

function ts.help_tags()
    reloader()
    -- local opts = themes.get_ivy({
    local opts = {
        prompt_title = "~ Help Tags ~",
        initial_mode = "insert",
        sorting_strategy = "ascending",
        layout_config = {
            prompt_position = "top",
            preview_width = 0.75,
            -- horizontal = {
            --   preview_width = 0.55,
            --   results_width = 0.8,
            -- },
            -- vertical = {
            --   mirror = false,
            -- },
            -- width = 0.87,
            height = 0.6,
        },
        preview = {
            preview_cutoff = 120,
            preview_width = 80,
            hide_on_startup = false,
        },
    }
    builtin.help_tags(opts)
end

function ts.code_actions()
    reloader()
    local opts = {
        -- winblend = 10,
        prompt_title = "~ Code Actions ~",
        border = true,
        previewer = false,
        shorten_path = false,
    }
    builtin.lsp_code_actions(themes.get_dropdown(opts))
end

function ts.highlights()
    reloader()
    local opts = {
        --   -- winblend = 10,
        prompt_title = "~ Highlights ~",
        --   border = false,
        --   previewer = false,
        --   shorten_path = false,
    }
    builtin.highlights(opts)
end

function ts.find_string()
    reloader()
    -- local opts = themes.get_ivy({
    local opts = {
        border = true,
        shorten_path = false,
        prompt_title = "~ Live Grep ~",
        -- layout_strategy = "flex",
        layout_config = {
            width = 0.99,
            height = 0.5,
            prompt_position = "top",
            -- horizontal = { width = { padding = 0.05 } },
            -- vertical = { preview_height = 0.75 },
        },
        file_ignore_patterns = {
            "vendor/*",
            "node_modules",
            "%.jpg",
            "%.jpeg",
            "%.png",
            "%.svg",
            "%.otf",
            "%.ttf",
        },
        preview = {
            hide_on_startup = false,
        },
    }
    -- winblend = 15,
    builtin.live_grep(opts)
end

function ts.grep_last_search(opts)
    reloader()
    opts = opts or {}

    -- \<getreg\>\C
    -- -> Subs out the search things
    local register = vim.fn.getreg("/")
        :gsub("\\<", "")
        :gsub("\\>", "")
        :gsub("\\C", "")

    opts.path_display = { "shorten" }
    opts.word_match = "-w"
    opts.search = register
    opts.prompt_title = "~ Last Search Grep ~"

    require("telescope.builtin").grep_string(opts)
end

function ts.curbuf()
    reloader()
    -- local opts = themes.get_ivy({
    local opts = {
        -- winblend = 10,
        -- border = false,
        -- previewer = false,
        shorten_path = false,
        prompt_position = "top",
        prompt_title = "~ Current Buffer ~",
        layout_config = { prompt_position = "top", height = 0.4 },
    }
    require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

function ts.git_diff()
    reloader()
    local opts = {
        -- layout_strategy = "horizontal",
        border = true,
        prompt_title = "~ Git Diff ~",
        layout_config = {
            width = 0.99,
            height = 0.69,
            preview_width = 0.7,
            prompt_position = "top",
        },
        preview = {
            hide_on_startup = false,
        },
    }
    require("telescope.builtin").git_status(opts)
end

local function base_16_finder(opts)
    reloader()
    opts = opts or {}
    local conf = require("telescope.config").values
    local change_theme = function()
        local entry = action_state.get_selected_entry()
        if entry ~= nil then
            require("colors").init(entry[1])
            require("colorscheme_switcher").new_scheme()
        end
        vim.fn.feedkeys(utils.t("<ESC><ESC>"), "i")
    end

    -- buffer number and name
    local bufnr = vim.api.nvim_get_current_buf()
    local bufname = vim.api.nvim_buf_get_name(bufnr)

    local previewer

    -- in case its not a normal buffer
    if vim.fn.buflisted(bufnr) ~= 1 then
        local deleted = false
        local function del_win(win_id)
            if win_id and vim.api.nvim_win_is_valid(win_id) then
                tele_utils.buf_delete(vim.api.nvim_win_get_buf(win_id))
                pcall(vim.api.nvim_win_close, win_id, true)
            end
        end

        previewer = previewers.new({
            preview_fn = function(_, entry, status)
                if not deleted then
                    deleted = true
                    del_win(status.preview_win)
                    del_win(status.preview_border_win)
                end
                require("colors").init(entry.value)
            end,
        })
    else
        -- show current buffer content in previewer
        previewer = previewers.new_buffer_previewer({
            define_preview = function(self, entry)
                local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
                vim.api.nvim_buf_set_lines(
                    self.state.bufnr,
                    0,
                    -1,
                    false,
                    lines
                )
                local filetype = require("plenary.filetype").detect(bufname)
                    or "diff"

                require("telescope.previewers.utils").highlighter(
                    self.state.bufnr,
                    filetype
                )
                require("colors").init(entry.value)
            end,
        })
    end

    pickers.new(opts, {
        prompt_title = "~ Base 16 Colorschemes ~",
        layout_strategy = "custom_bottom",
        finder = finders.new_table(opts.data),
        sorter = conf.generic_sorter(opts),
        previewer = previewer,
        attach_mappings = function(_, map)
            map("i", "<CR>", change_theme)
            map("n", "<CR>", change_theme)
            return true
        end,
    }):find()
end

function ts.find_files()
    reloader()
    local opts = {
        prompt_title = "~ Find Files ~",
        find_command = {
            "rg",
            "-g",
            "!.git",
            "--files",
            "--hidden",
            "--no-ignore",
        },
        layout_config = {
            prompt_position = "top",
        },
    }
    require("telescope.builtin").find_files(opts)
end

function ts.colorschemes()
    reloader()
    local opts = themes.get_ivy({
        data = utils.get_themes(),
        layout_strategy = "custom_bottom",
        layout_config = {
            width = 0.99,
            height = 0.5,
            -- anchor = "S",
            preview_cutoff = 20,
            prompt_position = "top",
        },
    })
    reloader()
    base_16_finder(opts)
end

return ts
