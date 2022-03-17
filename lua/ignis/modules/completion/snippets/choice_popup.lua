local current_nsid = vim.api.nvim_create_namespace(
    "LuaSnipChoiceListSelections"
)
local current_win = nil
local choice_popup_timer = nil

local function window_for_choiceNode(choiceNode)
    local buf = vim.api.nvim_create_buf(false, true)
    local buf_text = {}
    local row_selection = 0
    local row_offset = 0
    local text
    for _, node in ipairs(choiceNode.choices) do
        text = node:get_docstring()
        -- find one that is currently showing
        if node == choiceNode.active_choice then
            -- current line is starter from buffer list which is length usually
            row_selection = #buf_text
            -- finding how many lines total within a choice selection
            row_offset = #text
        end
        vim.list_extend(buf_text, text)
    end

    vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, buf_text)
    local w, h = vim.lsp.util._make_floating_popup_size(buf_text)

    -- adding highlight so we can see which one is been selected.
    local extmark = vim.api.nvim_buf_set_extmark(
        buf,
        current_nsid,
        row_selection,
        0,
        { hl_group = "Incsearch", end_line = row_selection + row_offset }
    )

    -- shows window at a beginning of choiceNode.
    local win = vim.api.nvim_open_win(buf, false, {
        relative = "win",
        width = w,
        height = h,
        bufpos = choiceNode.mark:pos_begin_end(),
        style = "minimal",
        border = "rounded",
    })

    -- return with 3 main important so we can use them again
    return { win_id = win, extmark = extmark, buf = buf }
end

local win_is_open = false

function _G.choice_popup(choiceNode)
    -- build stack for nested choiceNodes.
    if current_win then
        local err, _ = pcall(vim.api.nvim_win_close, current_win.win_id, true)
        if err then
            return
        end
        vim.api.nvim_buf_del_extmark(
            current_win.buf,
            current_nsid,
            current_win.extmark
        )
    end
    win_is_open = true
    local create_win = window_for_choiceNode(choiceNode)
    current_win = {
        win_id = create_win.win_id,
        prev = current_win,
        node = choiceNode,
        extmark = create_win.extmark,
        buf = create_win.buf,
    }
    choice_popup_timer = vim.defer_fn(function()
        choice_popup_close()
        choice_popup_timer = nil
    end, 1000)
end

function _G.update_choice_popup(choiceNode)
    if choice_popup_timer and not vim.loop.is_closing(choice_popup_timer) then
        choice_popup_close()
        vim.loop.timer_stop(choice_popup_timer)
        choice_popup_timer = nil
    end
    if not win_is_open then
        choice_popup(choiceNode)
        return
    end
    if not current_win then
        return
    end
    -- vim.api.nvim_win_close(current_win.win_id, true)
    local err, _ = pcall(vim.api.nvim_win_close, current_win.win_id, true)
    if err then
        current_win = {}
        return
    end
    err, _ = pcall(
        vim.api.nvim_buf_del_extmark,
        current_win.buf,
        current_nsid,
        current_win.extmark
    )
    if err then
        return
    end
    local create_win = window_for_choiceNode(choiceNode)
    current_win.win_id = create_win.win_id
    current_win.extmark = create_win.extmark
    current_win.buf = create_win.buf
    choice_popup_timer = vim.defer_fn(function()
        choice_popup_close()
        choice_popup_timer = nil
    end, 1000)
end

function _G.choice_popup_close()
    if not current_win then
        return
    end
    win_is_open = false
    local err, _ = pcall(vim.api.nvim_win_close, current_win.win_id, true)
    if err then
        return
    end
    err, _ = pcall(
        vim.api.nvim_buf_del_extmark,
        current_win.buf,
        current_nsid,
        current_win.extmark
    )
    if err then
        return
    end
    -- now we are checking if we still have previous choice we were in after exit nested choice
    current_win = current_win.prev
    if current_win then
        -- reopen window further down in the stack.
        local create_win = window_for_choiceNode(current_win.node)
        current_win.win_id = create_win.win_id
        current_win.extmark = create_win.extmark
        current_win.buf = create_win.buf
    end
end

vim.cmd([[
    augroup choice_popup
    au!
    au User LuasnipChoiceNodeEnter lua choice_popup(require("luasnip").session.event_node)
    au User LuasnipChoiceNodeLeave lua choice_popup_close()
    " au InsertLeave * lua choice_popup_close()
    au User LuasnipChangeChoice lua update_choice_popup(require("luasnip").session.event_node)
    augroup END
]])
-- RELOAD("ignis.modules.completion.snippets")
