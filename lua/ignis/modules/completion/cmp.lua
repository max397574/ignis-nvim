local cmp = require("cmp")
local types = require("cmp.types")
local luasnip = require("luasnip")
local neogen = require("neogen")
local util = require("luasnip.util.util")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done({ map_char = { tex = "" } })
)

local ls_types = require("luasnip.util.types")

local str = require("cmp.utils.str")

local kind = require("ignis.modules.lsp.kind")
-- vim.cmd([[PackerLoad LuaSnip]])
require("ignis.modules.completion.snippets")

local function t(string)
    return vim.api.nvim_replace_termcodes(string, true, true, true)
end

-- local border = {
--     "╔",
--     "═",
--     "╗",
--     "║",
--     "╝",
--     "═",
--     "╚",
--     "║",
-- }
local border = {
    { "╭", "CmpBorder" },
    { "─", "CmpBorder" },
    { "╮", "CmpBorder" },
    { "│", "CmpBorder" },
    { "╯", "CmpBorder" },
    { "─", "CmpBorder" },
    { "╰", "CmpBorder" },
    { "│", "CmpBorder" },
}

cmp.setup({
    window = {
        completion = {
            border = border,
            -- scrollbar = "┃",
            scrollbar = "║",
        },
        documentation = {
            border = border,
            scrollbar = "║",
            -- scrollbar = "┃",
        },
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-f>"] = cmp.mapping(function(fallback)
            if cmp.visible() and cmp.get_selected_entry() then
                cmp.scroll_docs(4)
            elseif luasnip.choice_active() then
                require("luasnip").change_choice(1)
                -- require("luasnip.extras.select_choice")()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<C-d>"] = cmp.mapping(function(fallback)
            if cmp.visible() and cmp.get_selected_entry() then
                cmp.scroll_docs(-4)
            elseif luasnip.choice_active() then
                require("luasnip").change_choice(-1)
                -- choice_popup(require("luasnip").session.event_node)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),

        ["<c-j>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                -- cmp.select_next_item()
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            elseif luasnip.jumpable(1) then
                luasnip.jump(1)
            elseif neogen.jumpable(1) then
                neogen.jump_next()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),

        ["<c-k>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                -- cmp.select_prev_item()
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            elseif neogen.jumpable(-1) then
                vim.fn.feedkeys(
                    t("<cmd>lua require('neogen').jump_prev()<CR>"),
                    ""
                )
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),

        ["<c-space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),

        ["<CR>"] = cmp.mapping({
            i = cmp.mapping.confirm({
                select = true,
                behavior = cmp.ConfirmBehavior.Insert,
            }),
            c = cmp.mapping.confirm({
                select = false,
                behavior = cmp.ConfirmBehavior.Insert,
            }),
        }),
        -- ["<cr>"] = cmp.mapping({
        --     i = cmp.mapping.confirm({
        --         select = true,
        --         behavior = cmp.ConfirmBehavior.Insert,
        --     }),
        --     c=
        -- }),
        ["<tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                -- cmp.select_next_item()
            end
        end, {
            "c",
        }),
        ["<s-tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            end
        end, {
            "c",
        }),
        ["<C-l>"] = cmp.mapping(function(fallback)
            if luasnip.choice_active() then
                require("luasnip").change_choice(1)
            elseif neogen.jumpable() then
                vim.fn.feedkeys(
                    t("<cmd>lua require('neogen').jump_next()<CR>"),
                    ""
                )
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<C-h>"] = cmp.mapping(function(fallback)
            if luasnip.choice_active() then
                require("luasnip").change_choice(-1)
            elseif neogen.jumpable(-1) then
                vim.fn.feedkeys(
                    t("<cmd>lua require('neogen').jump_prev()<CR>"),
                    ""
                )
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    },

    sources = {
        { name = "buffer", priority = 7, keyword_length = 4 },
        { name = "path", priority = 5 },
        { name = "emoji", priority = 3 },
        { name = "greek", priority = 1 },
        { name = "calc", priority = 4 },
        { name = "cmdline", priority = 4 },
        -- { name = "copilot", priority = 8 },
        -- { name = "cmp_tabnine", priority = 8 },
        { name = "nvim_lsp", priority = 9 },
        { name = "luasnip", priority = 8 },
        { name = "neorg", priority = 6 },
        { name = "latex_symbols", priority = 1 },
        { name = "nvim_lsp_signature_help", priority = 10 },
    },
    enabled = function()
        if vim.bo.ft == "TelescopePrompt" then
            return false
        end
        -- if vim.bo.ft == "dashboard" then
        --     return false
        -- end
        if vim.bo.ft == "lua" then
            return true
        end
        local lnum, col =
            vim.fn.line("."), math.min(vim.fn.col("."), #vim.fn.getline("."))
        for _, syn_id in ipairs(vim.fn.synstack(lnum, col)) do
            syn_id = vim.fn.synIDtrans(syn_id) -- Resolve :highlight links
            if vim.fn.synIDattr(syn_id, "name") == "Comment" then
                return false
            end
        end
        if string.find(vim.api.nvim_buf_get_name(0), "neorg://") then
            return false
        end
        if string.find(vim.api.nvim_buf_get_name(0), "s_popup:/") then
            return false
        end
        return true
    end,
    formatting = {
        fields = {
            cmp.ItemField.Kind,
            cmp.ItemField.Abbr,
            cmp.ItemField.Menu,
        },
        format = kind.cmp_format({
            with_text = false,
            before = function(entry, vim_item)
                -- Get the full snippet (and only keep first line)
                local word = entry:get_insert_text()
                if
                    entry.completion_item.insertTextFormat
                    == types.lsp.InsertTextFormat.Snippet
                then
                    word = vim.lsp.util.parse_snippet(word)
                end
                word = str.oneline(word)

                -- concatenates the string
                local max = 50
                if string.len(word) >= max then
                    local before = string.sub(
                        word,
                        1,
                        math.floor((max - 3) / 2)
                    )
                    word = before .. "..."
                end

                if
                    entry.completion_item.insertTextFormat
                        == types.lsp.InsertTextFormat.Snippet
                    and string.sub(vim_item.abbr, -1, -1) == "~"
                then
                    word = word .. "~"
                end
                vim_item.abbr = word

                vim_item.dup = ({
                    buffer = 1,
                    path = 1,
                    nvim_lsp = 0,
                })[entry.source.name] or 0

                return vim_item
            end,
        }),
    },
    sorting = {
        comparators = cmp.config.compare.recently_used,
    },
    experimental = {
        ghost_text = true,
    },
})

cmp.setup.cmdline(":", {
    sources = {
        { name = "cmdline", group_index = 1 },
        -- { name = "cmdline" },
        { name = "cmdline_history", group_index = 2 },
    },
    view = {
        entries = { name = "wildmenu", separator = " | " },
    },
})

cmp.setup.cmdline("/", {
    sources = {
        { name = "cmdline_history" },
        { name = "buffer" },
    },
    view = {
        entries = { name = "wildmenu", separator = " | " },
    },
})

local neorg = require("neorg")

local function load_completion()
    neorg.modules.load_module("core.norg.completion", nil, {
        engine = "nvim-cmp",
    })
end

if neorg.is_loaded() then
    load_completion()
else
    neorg.callbacks.on_event("core.started", load_completion)
end

vim.cmd([[hi NormalFloat guibg=none]])
