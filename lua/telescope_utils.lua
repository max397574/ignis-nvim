-- This is mostly code taken from https://github.com/nvim-telescope/telescope.nvim which was modified
local tc_utils = {}

local previewers = require("telescope.previewers")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local resolve = require("telescope.config.resolve")
local p_window = require("telescope.pickers.window")
local if_nil = vim.F.if_nil

local calc_tabline = function(max_lines)
    local tbln = (vim.o.showtabline == 2)
        or (vim.o.showtabline == 1 and #vim.api.nvim_list_tabpages() > 1)
    if tbln then
        max_lines = max_lines - 1
    end
    return max_lines, tbln
end

local get_border_size = function(opts)
    if opts.window.border == false then
        return 0
    end

    return 1
end

local calc_size_and_spacing =
    function(cur_size, max_size, bs, w_num, b_num, s_num)
        local spacing = s_num * (1 - bs) + b_num * bs
        cur_size = math.min(cur_size, max_size)
        cur_size = math.max(cur_size, w_num + spacing)
        return cur_size, spacing
    end

function tc_utils.set_options()
    require("telescope.pickers.layout_strategies").custom_bottom =
        function(self, max_columns, max_lines, layout_config)
            local initial_options = p_window.get_initial_window_options(self)
            local results = initial_options.results
            local prompt = initial_options.prompt
            local preview = initial_options.preview
            layout_config = {
                anchor = "S",
                -- preview_width = 0.6,
                bottom_pane = {
                    height = 0.5,
                    preview_cutoff = 20,
                    prompt_position = "top",
                },
                custom_bottom = {
                    height = 0.5,
                    preview_cutoff = 20,
                    -- preview_width = 0.6,
                    prompt_position = "top",
                },
                center = {
                    height = 0.5,
                    preview_cutoff = 20,
                    prompt_position = "top",
                    width = 0.99,
                },
                cursor = {
                    height = 0.5,
                    preview_cutoff = 20,
                    width = 0.99,
                },
                flex = {
                    horizontal = {},
                    preview_width = 0.65,
                },
                height = 0.5,
                horizontal = {
                    height = 0.5,
                    preview_cutoff = 20,
                    preview_width = 0.65,
                    prompt_position = "top",
                    width = 0.99,
                },
                preview_cutoff = 20,
                prompt_position = "top",
                vertical = {
                    height = 0.95,
                    preview_cutoff = 20,
                    preview_height = 0.5,
                    preview_width = 0.65,
                    prompt_position = "top",
                    width = 0.9,
                },
                width = 0.99,
            }

            local tbln
            max_lines, tbln = calc_tabline(max_lines)

            local height = if_nil(
                resolve.resolve_height(layout_config.height)(
                    self,
                    max_columns,
                    max_lines
                ),
                25
            )
            local width_opt = layout_config.width

            local width = resolve.resolve_width(width_opt)(
                self,
                max_columns,
                max_lines
            )

            -- local height = 21
            if
                type(layout_config.height) == "table"
                and type(layout_config.height.padding) == "number"
            then
                -- Since bottom_pane only has padding at the top, we only need half as much padding in total
                -- This doesn't match the vim help for `resolve.resolve_height`, but it matches expectations
                height = math.floor((max_lines + height) / 2)
            end
            prompt.border = results.border

            local bs = get_border_size(self)

            -- Cap over/undersized height
            height, _ = calc_size_and_spacing(height, max_lines, bs, 2, 3, 0)

            -- Height
            prompt.height = 2
            results.height = height - prompt.height - (2 * bs)
            preview.height = results.height - bs

            -- Width
            local w_space

            preview.width = 0
            prompt.width = max_columns - 2 * bs
            if
                self.previewer
                and max_columns >= layout_config.preview_cutoff
            then
                -- Cap over/undersized width (with preview)
                width, w_space = calc_size_and_spacing(
                    max_columns,
                    max_columns,
                    bs,
                    2,
                    4,
                    0
                )

                preview.width = resolve.resolve_width(
                    if_nil(layout_config.preview_width, 0.6)
                )(self, width, max_lines)
                results.width = width - preview.width - w_space
                prompt.width = results.width
                results.width = results.width
            else
                width, w_space = calc_size_and_spacing(
                    width,
                    max_columns,
                    bs,
                    1,
                    2,
                    0
                )
                preview.width = 0
                results.width = width - preview.width - w_space
                prompt.width = results.width
            end

            -- Line
            if layout_config.prompt_position == "top" then
                prompt.line = max_lines - results.height - (1 + bs) + 1
                results.line = prompt.line + 1
                preview.line = prompt.line + 1
                if results.border == true then
                    results.border = { 0, 1, 1, 1 }
                end
                if type(results.title) == "string" then
                    results.title = { { pos = "S", text = results.title } }
                end
            elseif layout_config.prompt_position == "bottom" then
                results.line = max_lines - results.height - (1 + bs) + 1
                results.line = prompt.line + 1
                preview.line = results.line
                prompt.line = max_lines - bs
                if type(prompt.title) == "string" then
                    prompt.title = { { pos = "S", text = prompt.title } }
                end
                if results.border == true then
                    results.border = { 1, 1, 0, 1 }
                end
            else
                error(
                    "Unknown prompt_position: "
                        .. tostring(self.window.prompt_position)
                        .. "\n"
                        .. vim.inspect(layout_config)
                )
            end
            local width_padding = math.floor((max_columns - width) / 2)

            -- Col
            prompt.col = 0 -- centered
            if layout_config.mirror and preview.width > 0 then
                results.col = preview.width + (3 * bs)
                preview.col = bs + 1
                prompt.col = results.col
            else
                preview.col = prompt.width + width_padding + bs + 1

                results.col = bs + 1
                prompt.col = preview.col + preview.width + bs
            end

            if tbln then
                -- prompt.line = prompt.line + 1
                results.line = results.line + 1
                preview.line = preview.line
                prompt.line = prompt.line
            else
                results.line = results.line + 1
            end
            prompt.line = prompt.line + 1
            results.line = results.line + 1
            preview.col = preview.col + 1
            preview.height = preview.height - 2
            prompt.col = 2
            results.height = results.height - 1
            preview.height = prompt.height + results.height
            -- preview.title = "~ Preview ~"
            -- results.title = {
            --     {
            --         pos = "S",
            --         text = "~ Results ~",
            --     },
            -- }
            results.col = 2
            -- print("preview:")
            -- dump(preview)
            -- print("prompt:")
            -- dump(prompt)
            -- print("results:")
            -- dump(results)

            return {
                preview = self.previewer and preview.width > 0 and preview,
                prompt = prompt,
                results = results,
            }
        end
end

local function reloader()
    RELOAD("plenary")
    RELOAD("telescope")
    tc_utils.set_options()
    RELOAD("configs.telescope")
    tc_utils.set_options()
end

reloader()

---Creates a telescope picker with contents as results and preview
---@param contents table The contents in the format
-- {
--   "Title: Entry 1",
--   "Name: Test Entry",
--   "Length: 120",
-- },
--   results_name = {"Entry 1"},
--   },
--   {
--     contents = {
--       "Title: Entry 2",
--       "Name: Another Entry",
--       "Length: 60",
--     },
--     results_name = {"Entry 2"},
--   },
--
--Where results_name will be used as entry in `results` and `contents` will be the lines in the preview
---@param opts table Options for telescope picker
function tc_utils.entry_preview(contents, opts)
    opts = opts or nil
    reloader()
    local config = require("telescope.config").values
    local entry_display = require("telescope.pickers.entry_display")
    local displayer = entry_display.create({
        separator = " ",
        items = {
            { width = 60 },
            { remaining = true },
        },
    })
    local function make_display(entry)
        local to_display = entry.results_name
        -- local to_display = entry.name
        return displayer(to_display)
    end

    local function entry_maker(entry)
        return {
            display = make_display,
            results_name = entry.results_name,
            contents = entry.contents,
            filetype = "markdown",
            ordinal = table.concat(entry.contents, "\n"),
            -- TODO seem to be needed
            name = "name",
            value = "value", -- TODO what to put value to, affects sorting?
        }
    end

    local previewer = previewers.new_buffer_previewer({
        define_preview = function(self, entry, status)
            vim.api.nvim_buf_set_lines(
                self.state.bufnr,
                0,
                -1,
                true,
                entry.contents
            )
            vim.bo[self.state.bufnr].filetype = entry.filetype
        end,
    })

    pickers.new(opts, {
        prompt_title = "My Test Prompt",
        finder = finders.new_table({
            results = contents,
            entry_maker = entry_maker,
        }),
        previewer = previewer,
        sorter = config.generic_sorter(opts),
    }):find()
end

return tc_utils
