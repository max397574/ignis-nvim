local map = vim.keymap.set
local nore_silent = { noremap = true, silent = true }
local nore = { noremap = true }
local utils = require("ignis.utils")

utils.load_ignis_module("keys", "mappings.which_key")

-- Windows
-- =======
-- easy split navigation
map(
    "n",
    "<c-j>",
    ":wincmd j<CR>",
    { noremap = true, silent = true, desc = "Move to split above" }
)
map(
    "n",
    "<c-h>",
    ":wincmd h<CR>",
    { noremap = true, silent = true, desc = "Move to split on left side" }
)
map(
    "n",
    "<c-k>",
    ":wincmd k<CR>",
    { noremap = true, silent = true, desc = "Move to split below" }
)
map(
    "n",
    "<c-l>",
    ":wincmd l<CR>",
    { noremap = true, silent = true, desc = "Move to split on right side" }
)
-- move windows with arrows
-- map("n", "<down>", ":wincmd J<CR>", nore_silent)
-- map("n", "<left>", ":wincmd H<CR>", nore_silent)
-- map("n", "<up>", ":wincmd K<CR>", nore_silent)
-- map("n", "<right>", ":wincmd L<CR>", nore_silent)

-- Telescope
-- =========
map("n", "<c-s>", function()
    require("ignis.modules.files.telescope").curbuf()
end, {
    desc = "Grep in current buffer",
})

-- Simple Commands (Improvements of commands)
-- ==========================================

-- reselect selection after shifting
map("x", "<", "<gv", nore)
map("x", ">", ">gv", nore)

-- move lines up and down in insert mode
-- map("i", "<C-j>", "<ESC>:m .+1<CR>==i<RIGHT>", nore)
-- map("i", "<C-k>", "<ESC>:m .-2<CR>==i<RIGHT>", nore)

-- remove highlighting from search
map("n", "nh", ":nohlsearch<CR>", nore_silent)
map("n", "<ESC>", "<cmd>nohl<CR>", nore_silent)
-- easier escape
map("v", "jk", "<ESC>", nore)

-- paste over selected text without overwriting yank register
map(
    "v",
    "<leader>p",
    '"_dP',
    { noremap = true, desc = "Paste without overwriting yank register" }
)

-- see registers
vim.keymap.set("n", "®", function()
    require("which-key").show("@", { mode = "n", auto = true })
end, {
    desc = "Show registers",
})

-- move visual blocks up and down
map(
    "v",
    "J",
    ":m '>+1<CR>gv=gv",
    { noremap = true, silent = true, desc = "Move visual block down" }
)
map(
    "v",
    "K",
    ": m'<-2<CR>gv=gv",
    { noremap = true, silent = true, desc = "Move visual block up" }
)

-- don't move cursor down when joining lines
map("n", "J", "mzJ`z", nore)
map("x", "<BS>", "x", nore)

-- substitute on visual selection
map("v", "<leader>s", ":s///g<LEFT><LEFT><LEFT>", nore)

-- Random
-- ======

-- move right in insert mode
map("i", "  ", "<RIGHT>", nore)

-- better undo
map("i", ",", ",<c-g>u", nore)
map("i", "!", "!<c-g>u", nore)
map("i", ".", ".<c-g>u", nore)
-- map("i", " ", " <c-g>u", nore)
map("i", " ", " ", nore)
map("i", "?", "?<c-g>u", nore)
map("i", "_", "_<c-g>u", nore)
map("i", "<CR>", "<CR><c-g>u", nore)

-- Close toggleterm
map("t", "<c-t>", "<cmd>ToggleTerm<CR>", nore_silent)
map("t", "<c-g>", "<cmd>ToggleTerm<CR>", nore_silent)

-- lsp
map("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", nore_silent)

-- help from ts with textobjects
map("o", "m", ":<C-U>lua require('tsht').nodes()<CR>", { silent = true })
map("x", "m", ":<C-U>lua require('tsht').nodes()<CR>", nore_silent)

-- open helpfile of word under cursor
map(
    "n",
    "<C-f>",
    ':lua vim.cmd(":vert :h "..vim.fn.expand("<cword>"))<CR>',
    nore_silent
)

-- jump to mark m
map("n", "M", "`m", nore_silent)

-- append comma and semicolon
map("n", ",,", function()
    require("ignis.utils").append_comma()
end, nore_silent)
map("n", ";;", function()
    require("ignis.utils").append_semicolon()
end, nore_silent)

-- change case of cword
map("n", "<C-U>", function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_feedkeys("b~", "n", true)
    vim.defer_fn(function()
        vim.api.nvim_win_set_cursor(0, cursor)
    end, 1)
end, nore_silent)
map("i", "<C-U>", "<ESC>b~A", nore_silent)

map("v", "<leader>n", ":norm ", nore_silent)

-- luasnip
map("i", "<leader><tab>", function()
    -- if require("luasnip").choice_active() then
    --     require("luasnip").change_choice(1)
    --     return
    -- end
    require("luasnip").expand_or_jump()
end, nore_silent)
map("s", "<leader><tab>", function()
    -- if require("luasnip").choice_active() then
    --     require("luasnip").change_choice(1)
    --     return
    -- end
    require("luasnip").expand_or_jump()
end, nore_silent)
-- add j and k with count to jumplist
map(
    "n",
    "j",
    [[(v:count > 1 ? "m'" . v:count : '') . 'j']],
    { noremap = true, expr = true }
)
map(
    "n",
    "k",
    [[(v:count > 1 ? "m'" . v:count : '') . 'k']],
    { noremap = true, expr = true }
)

map("n", "<Leader>?", ":TodoQuickFix<CR>", nore)

-- Refactor.nvim

-- local opts = { noremap = true, silent = true, expr = false }
--
-- map(
--     "n",
--     "<leader>Rp",
--     ":lua require('refactoring').debug.printf({below = false})<CR>",
--     { noremap = true }
-- )
--
-- -- Print var: this remap should be made in visual mode
-- map(
--     "v",
--     "<leader>Rv",
--     ":lua require('refactoring').debug.print_var({})<CR>",
--     { noremap = true }
-- )
--
-- map("v", "<leader>y", '"+y', nore_silent)
--
-- -- Cleanup function: this remap should be made in normal mode
-- vim.keymap.set("n", "<leader>Rc", function()
--     require("refactoring").debug.cleanup({})
-- end, {
--     noremap = true,
-- })
--
-- -- Remap to open the Telescope refactoring menu in visual mode
-- map(
--     "v",
--     "<Leader>Rt",
--     [[ <Esc><Cmd>lua require"configs.refactor".refactors()<CR>]],
--     opts
-- )
-- map(
--     "v",
--     "<Leader>Re",
--     [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
--     opts
-- )
-- map(
--     "v",
--     "<Leader>Rf",
--     [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
--     opts
-- )
-- map(
--     "v",
--     "<Leader>Rv",
--     [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
--     opts
-- )
--
-- map(
--     "v",
--     "<Leader>Ri",
--     [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
--     opts
-- )

local function toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd([[setlocal ve=all]])
        -- draw a line on HJKL keystokes
        vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "J",
            "<C-v>j:VBox<CR>",
            { noremap = true }
        )
        vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "K",
            "<C-v>k:VBox<CR>",
            { noremap = true }
        )
        vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "L",
            "<C-v>l:VBox<CR>",
            { noremap = true }
        )
        vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "H",
            "<C-v>h:VBox<CR>",
            { noremap = true }
        )
        -- draw a box by pressing "f" with visual selection
        vim.api.nvim_buf_set_keymap(
            0,
            "v",
            "f",
            ":VBox<CR>",
            { noremap = true }
        )
    else
        vim.cmd([[setlocal ve=]])
        vim.cmd([[mapclear <buffer>]])
        vim.b.venn_enabled = nil
    end
end

-- vim.keymap.set("c", "(", "()<left>", { noremap = true })
-- vim.keymap.set("c", "'", "''<left>", { noremap = true })
-- vim.keymap.set("c", "[", "[]<left>", { noremap = true })
-- vim.keymap.set("c", '"', '""<left>', { noremap = true })

vim.keymap.set("n", "†", function()
    require("ignis.utils").temp_buf()
end, {
    noremap = true,
})

-- toggle keymappings for venn using <leader>v
vim.keymap.set(
    "n",
    "<leader>V",
    toggle_venn,
    { noremap = true, desc = "Toggle Venn" }
)

-- reize windows with arrows
vim.keymap.set("n", "<left>", "<C-W>1<", nore_silent)
vim.keymap.set("n", "<down>", ":resize +1<CR>", nore_silent)
vim.keymap.set("n", "<right>", "<C-W>1>", nore_silent)
vim.keymap.set("n", "<up>", ":resize -1<CR>", nore_silent)
-- just <cr> -> if u use <cr> to confirm completion
vim.keymap.set("i", "<m-cr>", "<cr>", nore_silent)

vim.keymap.set("n", "¢", "bl~lhe", nore_silent)

-- highlight search result and center cursor
map("n", "n", "nzzzv", nore_silent)
map("n", "N", "Nzzzv", nore_silent)
vim.keymap.set({ "n", "x" }, "gg", function()
    require("cinnamon").Scroll("gg", 0, 0, 3)
end)
vim.keymap.set({ "n", "x" }, "G", function()
    require("cinnamon").Scroll("G", 0, 1, 3)
end)

vim.keymap.set("n", "n", function()
    require("cinnamon").Scroll("n", 1, 0, 3)
    vim.api.nvim_feedkeys("zzzv", "n", true)
end)

vim.keymap.set("n", "N", function()
    require("cinnamon").Scroll("N", 1, 0, 3)
    vim.api.nvim_feedkeys("zzzv", "n", true)
end)

-- vim.keymap.set("n", "<C-o>", function()
--     require("cinnamon").Scroll("<C-o>", 1, 0, 3)
-- end, nore_silent)
-- vim.keymap.set("n", "<C-i>", function()
--     require("cinnamon").Scroll("1<C-i>", 1, 0, 3)
-- end, nore_silent)
