-- This is just code taken from https://github.com/nvim-telescope/telescope.nvim which was modified
vim.cmd([[PackerLoad telescope-fzf-native.nvim]])
vim.cmd([[PackerLoad telescope-symbols.nvim]])
vim.cmd([[PackerLoad telescope-emoji.nvim]])

vim.cmd([[PackerLoad telescope-file-browser.nvim]])
local pickers = require("telescope.pickers")
local make_entry = require("telescope.make_entry")
local entry_display = require("telescope.pickers.entry_display")
local conf = require("telescope.config").values
local finders = require("telescope.finders")
local ts = {}

local actions = require("telescope.actions")
local flatten = vim.tbl_flatten
local Path = require("plenary.path")
local action_layout = require("telescope.actions.layout")
local fb_actions = require("telescope._extensions.file_browser.actions")
local actions_layout = require("telescope.actions.layout")
local action_state = require("telescope.actions.state")
local themes = require("telescope.themes")
local builtin = require("telescope.builtin")
local tele_utils = require("telescope.utils")
local previewers = require("telescope.previewers")
local utils = require("ignis.utils")
local sorters = require("telescope.sorters")

local set_options = require("telescope_utils").set_options

local function reloader()
    RELOAD("plenary")
    RELOAD("telescope")
    set_options()
    RELOAD("ignis.modules.files.telescope")
    set_options()
    vim.cmd("normal! m'")
end

function ts.reloader()
    reloader()
end

reloader()

--- Pick any picker and use `cwd` as `cwd`
---@param cwd string The `cwd` to use
local function pick_pickers(cwd)
    local opts = {}
    if not cwd then
        return
    end
    print(cwd)
    opts.include_extensions = true

    local objs = {}

    for k, v in pairs(require("telescope.builtin")) do
        local debug_info = debug.getinfo(v)
        table.insert(objs, {
            filename = string.sub(debug_info.source, 2),
            text = k,
        })
    end

    local title = "Telescope Builtin"

    if opts.include_extensions then
        title = "Telescope Pickers"
        for ext, funcs in pairs(require("telescope").extensions) do
            for func_name, func_obj in pairs(funcs) do
                -- Only include exported functions whose name doesn't begin with an underscore
                if
                    type(func_obj) == "function"
                    and string.sub(func_name, 0, 1) ~= "_"
                then
                    local debug_info = debug.getinfo(func_obj)
                    table.insert(objs, {
                        filename = string.sub(debug_info.source, 2),
                        text = string.format("%s : %s", ext, func_name),
                    })
                end
            end
        end
    end

    pickers.new(opts, {
        prompt_title = title,
        finder = finders.new_table({
            results = objs,
            entry_maker = function(entry)
                return {
                    value = entry,
                    text = entry.text,
                    display = entry.text,
                    ordinal = entry.text,
                    filename = entry.filename,
                }
            end,
        }),
        previewer = previewers.builtin.new(opts),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(_)
            actions.select_default:replace(function(_)
                local selection = action_state.get_selected_entry()
                if not selection then
                    print("[telescope] Nothing currently selected")
                    return
                end

                -- we do this to avoid any surprises
                opts.include_extensions = nil
                opts.cwd = cwd

                if string.match(selection.text, " : ") then
                    -- Call appropriate function from extensions
                    local split_string = vim.split(selection.text, " : ")
                    local ext = split_string[1]
                    local func = split_string[2]
                    require("telescope").extensions[ext][func](opts)
                else
                    -- Call appropriate telescope builtin
                    require("telescope.builtin")[selection.text](opts)
                end
            end)
            return true
        end,
    }):find()
end

local picker_selection_as_cwd = function(prompt_bufnr)
    reloader()
    local get_target_dir = function(finder)
        local entry_path
        local entry = action_state.get_selected_entry()
        if finder.files == false then
            entry_path = entry and entry.value -- absolute path
        end
        return finder.files and finder.path or entry_path
    end
    local current_picker = action_state.get_current_picker(prompt_bufnr)
    local finder = current_picker.finder

    local dir = get_target_dir(finder)
    actions.close(prompt_bufnr)
    pick_pickers(dir)
end

local live_grep_selected = function(prompt_bufnr)
    local opts = {
        border = true,
        disable_coordinates = true,
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
        layout_config = {
            height = 0.5,
            prompt_position = "top",
            width = 0.99,
        },
        preview = {
            hide_on_startup = false,
        },
        preview_title = "~ Location Preview ~ ",
        prompt_title = "~ Find String ~",
        results_title = "~ Occurrences ~",
        shorten_path = false,
    }
    local picker = action_state.get_current_picker(prompt_bufnr)
    local entries = picker:get_multi_selection()
    opts.cwd = entries[1].cwd
    local search_list = {}

    for _, entry in ipairs(entries) do
        table.insert(search_list, entry[1])
    end
    actions.close(prompt_bufnr)
    local live_grepper = finders.new_job(function(prompt)
        -- TODO: Probably could add some options for smart case and whatever else rg offers.

        if not prompt or prompt == "" then
            return nil
        end

        local vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        }

        local additional_args = {}

        return flatten({
            vimgrep_arguments,
            additional_args,
            "--",
            prompt,
            search_list,
        })
    end, make_entry.gen_from_vimgrep(
        opts
    ), opts.max_results, opts.cwd)

    pickers.new(opts, {
        prompt_title = "Live Grep",
        finder = live_grepper,
        previewer = conf.grep_previewer(opts),
        -- TODO: It would be cool to use `--json` output for this
        -- and then we could get the highlight positions directly.
        sorter = sorters.highlighter_only(opts),
    }):find()
end

local set_prompt_to_entry_value = function(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    if not entry or not type(entry) == "table" then
        return
    end

    action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end
local configs

local ts_layout = require("custom.db").get_ts_layout()

if ts_layout == "custom_bottom_no_borders" then
    configs = {
        defaults = themes.get_ivy({
            -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
            selection_caret = " ??? ",
            get_status_text = function(self)
                -- local xx = (self.stats.processed or 0) - (self.stats.filtered or 0)
                -- local yy = self.stats.processed or 0
                -- if xx == 0 and yy == 0 then
                --   return ""
                -- end
                --
                -- -- local status_icon
                -- -- if opts.completed then
                -- --   status_icon = "??????"
                -- -- else
                -- --   status_icon = "*"
                -- -- end
                -- return string.format("%s / %s", xx, yy)
                return ""
            end,
            -- layout_strategy = "horizontal",
            -- custom layout strategy
            layout_strategy = "custom_bottom",
            results_title = "~ Results ~",
            -- cursor resets after new sort (changing prompt)
            selection_strategy = "reset",
            -- remove stuff from paths when possible so names are still clear
            -- path_display = { "smart" },
            -- path_display["shorten"] = 2,
            prompt_prefix = " ??? ",
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
                    ["<C-s>"] = live_grep_selected,
                    ["<C-n>"] = require("telescope.actions").cycle_history_next,
                    ["<C-u>"] = require("telescope.actions").cycle_history_prev,
                    ["<a-cr>"] = picker_selection_as_cwd,
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
                    ["<C-s>"] = live_grep_selected,
                    ["<C-n>"] = require("telescope.actions").cycle_history_next,
                    ["<C-u>"] = require("telescope.actions").cycle_history_prev,
                    ["<a-cr>"] = picker_selection_as_cwd,
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
    }
elseif ts_layout == "float_all_borders" then
    configs = {
        defaults = {
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = "ascending",
            layout_strategy = "horizontal",
            prompt_prefix = " ???  ",
            selection_caret = " ??? ",
            get_status_text = function(self)
                return ""
            end,
            layout_config = {
                width = 0.85,
                height = 0.9,
                preview_cutoff = 20,
                prompt_position = "bottom",
                vertical = { mirror = false },
                horizontal = {
                    mirror = false,
                    preview_width = 0.6,
                },
            },
            generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
            winblend = 0,
            scroll_strategy = "cycle",
            border = {},
            borderchars = {
                "???",
                "???",
                "???",
                "???",
                "???",
                "???",
                "???",
                "???",
            },
            -- borderchars = {
            --     "???",
            --     "???",
            --     "???",
            --     "???",
            --     "???",
            --     "???",
            --     "???",
            --     "???",
            -- },
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
                    ["<C-s>"] = live_grep_selected,
                    ["<C-n>"] = require("telescope.actions").cycle_history_next,
                    ["<C-u>"] = require("telescope.actions").cycle_history_prev,
                    ["<a-cr>"] = picker_selection_as_cwd,
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
                    ["<C-s>"] = live_grep_selected,
                    ["<C-n>"] = require("telescope.actions").cycle_history_next,
                    ["<C-u>"] = require("telescope.actions").cycle_history_prev,
                    ["<a-cr>"] = picker_selection_as_cwd,
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
        },
    }
end

require("telescope").setup(configs)

local _bad = { ".*%.md" } -- Put all filetypes that slow you down in this array
local bad_files = function(filepath)
  for _, v in ipairs(_bad) do
    if filepath:match(v) then
      return false
    end
  end

  return true
end

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  if opts.use_ft_detect == nil then opts.use_ft_detect = true end
  opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
  previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

require("telescope").setup {
  defaults = {
    buffer_previewer_maker = new_maker,
  }
}

function ts.entry_preview(contents, opts)
    require("hubble").entry_preview(contents, opts)
end

require("telescope").load_extension("fzf")

require("telescope").load_extension("luasnip")
require("telescope").load_extension("emoji")

function ts.file_browser()
    reloader()
    require("telescope").load_extension("file_browser")
    local opts

    opts = {
        sorting_strategy = "ascending",
        scroll_strategy = "cycle",
        prompt_prefix = " ??? ",
        layout_config = {
            prompt_position = "top",
        },
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
        prompt_title = "~ Neovim Plugins ~",
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
        -- preview_title = "~ Diff ~ ",
        results_title = "~ Available Actions ~",
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
    local opts = {
        border = true,
        shorten_path = false,
        prompt_title = "~ Find String ~",
        preview_title = "~ Location Preview ~ ",
        results_title = "~ Occurrences ~",
        disable_coordinates = true,
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
            -- "%.md" -- gives segfaults
        },
        preview = {
            hide_on_startup = false,
        },
    }
    -- winblend = 15,
    builtin.live_grep(opts)
    -- require("ignis.modules.files.telescope.live_grepper").live_grep(opts)
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
        preview_title = "~ Location Preview~ ",
        results_title = "~ Lines ~",
        layout_config = { prompt_position = "top", height = 0.4 },
    }
    require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

function ts.git_status()
    reloader()
    local opts = {
        -- layout_strategy = "horizontal",
        git_icons = {
            added = "???",
            changed = "???",
            copied = "???",
            deleted = "???",
            renamed = "???",
            unmerged = "???",
            untracked = "???",
        },
        border = true,
        prompt_title = "~ Git Status ~",
        preview_title = "~ Diff Preview ~ ",
        results_title = "~ Changed Files ~",
        layout_config = {
            width = 0.99,
            height = 0.69,
            preview_width = 0.7,
            prompt_position = "top",
        },
        preview = {
            hide_on_startup = true,
        },
    }
    require("telescope.builtin").git_status(opts)
end

function ts.git_diff()
    reloader()
    local cwd = vim.fn.expand(vim.loop.cwd())
    local function entry_maker()
        return function(entry)
            local mod, file = string.match(entry, "(..).*%s[->%s]?(.+)")
            return {
                value = file,
                status = mod,
                ordinal = entry,
                display = file,
                path = Path:new({ cwd, file }):absolute(),
            }
        end
    end

    local git_cmd = { "git", "status", "-s", "--", "." }
    local output = require("telescope.utils").get_os_command_output(
        git_cmd,
        cwd
    )
    local opts = {
        -- layout_strategy = "horizontal",
        finder = finders.new_table({
            results = output,
            entry_maker = entry_maker(),
        }),
        border = true,
        prompt_title = "~ Git Diff ~",
        preview_title = "~ Diff ~ ",
        results_title = "~ Changed Files ~",
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
        prompt_title = "~ Colorscheme Picker ~",
        results_title = "~ Colorschemes ~",
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

local function lsp_ref_from_qf(opts)
    opts = opts or {}

    local displayer = entry_display.create({
        -- separator = "???",
        separator = " ",
        items = {
            { width = 8 },
            { width = 20 },
            { remaining = true },
        },
    })

    local make_display = function(entry)
        local filename = require("telescope.utils").transform_path(
            opts,
            entry.filename
        )

        local line_info = {
            -- table.concat({ entry.lnum, entry.col }, ":"),
            "(" .. entry.lnum .. ")",
            "TelescopeResultsLineNr",
        }
        -- if #filename > 20 then
        --     filename = filename:sub(-20, -1)
        -- end

        return displayer({
            line_info,
            -- entry.text:gsub(".* | ", ""),
            -- string.rep(" ", 30 - #vim.trim(entry.text)),
            vim.trim(entry.text),
            filename,
        })
    end

    return function(entry)
        local filename = entry.filename
            or vim.api.nvim_buf_get_name(entry.bufnr)

        return {
            valid = true,

            value = entry,
            ordinal = (not opts.ignore_filename and filename or "")
                .. " "
                .. entry.text,
            display = make_display,

            bufnr = entry.bufnr,
            filename = filename,
            lnum = entry.lnum,
            col = entry.col,
            text = entry.text,
            start = entry.start,
            finish = entry.finish,
        }
    end
end

function ts.lsp_references()
    reloader()
    local opts = themes.get_dropdown({
        -- local opts = themes.get_ivy({
        prompt_title = "~ LSP References ~",
        preview_title = "~ File Preview ~ ",
        results_title = "~ References ~",
        layout_config = {
            -- preview_width = 0.5,
            height = 0.6,
            anchor = "S",
        },
        preview = {
            hide_on_startup = false,
        },
    })
    local params = vim.lsp.util.make_position_params()
    params.context = { includeDeclaration = true }

    vim.lsp.buf_request(
        0,
        "textDocument/references",
        params,
        function(err, result, _ctx, _config)
            if err then
                vim.api.nvim_err_writeln(
                    "Error when finding references: " .. err.message
                )
                return
            end

            local locations = {}
            if result then
                vim.list_extend(
                    locations,
                    vim.lsp.util.locations_to_items(result) or {}
                )
            end

            if vim.tbl_isempty(locations) then
                return
            end

            pickers.new(opts, {
                finder = finders.new_table({
                    results = locations,
                    entry_maker = lsp_ref_from_qf(),
                }),
                previewer = conf.qflist_previewer(opts),
                sorter = conf.generic_sorter(opts),
            }):find()
        end
    )
end

function ts.find_files()
    reloader()
    local opts = {
        prompt_title = "~ Find Files ~",
        preview_title = "~ File Preview ~",
        results_title = "~ Files ~",
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
