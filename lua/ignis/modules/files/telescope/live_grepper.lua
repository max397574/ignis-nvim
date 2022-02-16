-- This is just code taken from https://github.com/nvim-telescope/telescope.nvim which was modified
local lg = {}

local conf = require("telescope.config").values
local filter = vim.tbl_filter
local Path = require("plenary.path")
local finders = require("telescope.finders")
local flatten = vim.tbl_flatten
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local utils = require("telescope.utils")
local lookup_keys = {
    display = 1,
    ordinal = 1,
    value = 1,
}

local find = (function()
    if Path.path.sep == "\\" then
        return function(t)
            local start, _, filename, lnum, col, text = string.find(
                t,
                [[([^:]+):(%d+):(%d+):(.*)]]
            )

            -- Handle Windows drive letter (e.g. "C:") at the beginning (if present)
            if start == 3 then
                filename = string.sub(t.value, 1, 3) .. filename
            end

            return filename, lnum, col, text
        end
    else
        return function(t)
            local _, _, filename, lnum, col, text = string.find(
                t,
                [[([^:]+):(%d+):(%d+):(.*)]]
            )
            return filename, lnum, col, text
        end
    end
end)()

local parse = function(t)
    local filename, lnum, col, text = find(t.value)

    local ok
    ok, lnum = pcall(tonumber, lnum)
    if not ok then
        lnum = nil
    end

    ok, col = pcall(tonumber, col)
    if not ok then
        col = nil
    end

    t.filename = filename
    t.lnum = lnum
    t.col = col
    t.text = text

    return { filename, lnum, col, text }
end

local function gen_from_vimgrep(opts)
    local mt_vimgrep_entry

    opts = opts or {}

    local disable_devicons = opts.disable_devicons
    local disable_coordinates = opts.disable_coordinates
    local only_sort_text = opts.only_sort_text

    local execute_keys = {
        path = function(t)
            if Path:new(t.filename):is_absolute() then
                return t.filename, false
            else
                return Path:new({ t.cwd, t.filename }):absolute(), false
            end
        end,

        filename = function(t)
            return parse(t)[1], true
        end,

        lnum = function(t)
            return parse(t)[2], true
        end,

        col = function(t)
            return parse(t)[3], true
        end,

        text = function(t)
            return parse(t)[4], true
        end,
    }

    -- For text search only, the ordinal value is actually the text.
    if only_sort_text then
        execute_keys.ordinal = function(t)
            return t.text
        end
    end

    local display_string = "%s:%s%s"

    mt_vimgrep_entry = {
        cwd = vim.fn.expand(opts.cwd or vim.loop.cwd()),

        display = function(entry)
            local display_filename = utils.transform_path(opts, entry.filename)

            local coordinates = ""
            if not disable_coordinates then
                coordinates = string.format("%s:%s:", entry.lnum, entry.col)
            end

            local display, hl_group = utils.transform_devicons(
                entry.filename,
                string.format(
                    display_string,
                    display_filename,
                    coordinates,
                    entry.text
                ),
                disable_devicons
            )

            if hl_group then
                return display, { { { 1, 3 }, hl_group } }
            else
                return display
            end
        end,

        __index = function(t, k)
            local raw = rawget(mt_vimgrep_entry, k)
            if raw then
                return raw
            end

            local executor = rawget(execute_keys, k)
            if executor then
                local val, save = executor(t)
                if save then
                    rawset(t, k, val)
                end
                return val
            end

            return rawget(t, rawget(lookup_keys, k))
        end,
    }

    return function(line)
        return setmetatable({ line }, mt_vimgrep_entry)
    end
end

lg.live_grep = function(opts)
    local vimgrep_arguments = opts.vimgrep_arguments or conf.vimgrep_arguments
    local search_dirs = opts.search_dirs
    local grep_open_files = opts.grep_open_files
    opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()

    local filelist = {}

    if grep_open_files then
        local bufnrs = filter(function(b)
            if 1 ~= vim.fn.buflisted(b) then
                return false
            end
            return true
        end, vim.api.nvim_list_bufs())
        if not next(bufnrs) then
            return
        end

        for _, bufnr in ipairs(bufnrs) do
            local file = vim.api.nvim_buf_get_name(bufnr)
            table.insert(filelist, Path:new(file):make_relative(opts.cwd))
        end
    elseif search_dirs then
        for i, path in ipairs(search_dirs) do
            search_dirs[i] = vim.fn.expand(path)
        end
    end

    local additional_args = {}
    if
        opts.additional_args ~= nil
        and type(opts.additional_args) == "function"
    then
        additional_args = opts.additional_args(opts)
    end

    local live_grepper = finders.new_job(function(prompt)
        -- TODO: Probably could add some options for smart case and whatever else rg offers.

        if not prompt or prompt == "" then
            return nil
        end

        local search_list = {}

        if search_dirs then
            table.insert(search_list, search_dirs)
        end

        if grep_open_files then
            search_list = filelist
        end

        return flatten({
            vimgrep_arguments,
            additional_args,
            "--",
            prompt,
            search_list,
        })
    end, opts.entry_maker or gen_from_vimgrep(
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

return lg
