vim.cmd([[PackerLoad LuaSnip]])
vim.cmd([[PackerLoad lua-dev.nvim]])
local cmp = require("cmp")
local luasnip = require("luasnip")

luasnip.config.setup({
  region_check_events = "CursorMoved",
  delete_check_events = "TextChanged",
})

local icons = require("configs.lsp.kind").icons

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function check_backspace()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

local function get_kind(kind_type)
  return icons[kind_type]
end

cmp.setup({
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<c-space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<tab>"] = cmp.mapping(cmp.mapping.complete(), { "i" }),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<C-j>"] = cmp.mapping({
      i = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    }),
    ["<C-k>"] = cmp.mapping({
      i = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    }),
    ["<CR>"] = cmp.mapping.confirm({
      select = true,
      behavior = cmp.ConfirmBehavior.Insert,
    }),
    -- ["<Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     -- cmp.select_next_item {}
    --     cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
    --   elseif luasnip.expand_or_jumpable() then
    --     vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
    --   elseif check_backspace() then
    --     vim.fn.feedkeys(t("<Tab>"), "n")
    --   else
    --     vim.fn.feedkeys(t("<C-Space>")) -- Manual trigger
    --   end
    -- end, {
    --   "i",
    --   "s",
    --   -- "c",
    -- }),
    -- ["<S-Tab>"] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
    --   elseif luasnip.jumpable(-1) then
    --     vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
    --   else
    --     fallback()
    --   end
    -- end, {
    --   "i",
    --   "s",
    --   -- "c",
    -- }),
  },

  sources = {
    { name = "buffer", priority = 7, keyword_length = 4 },
    { name = "path", priority = 5 },
    { name = "emoji", priority = 3 },
    { name = "calc", priority = 4 },
    { name = "nvim_lsp", priority = 9 },
    { name = "luasnip", priority = 8 },
    { name = "neorg", priority = 6 },
    { name = "copilot", priority = 10 },
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format(
        "%s %s",
        get_kind(vim_item.kind),
        vim_item.kind
      )

      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        emoji = "[Emoji]",
        path = "[Path]",
        calc = "[Calc]",
        luasnip = "[Snip]",
        buffer = "[Buf]",
        neorg = "[Norg]",
        copilot = "[COP]",
        -- spell = "(Spell)",
      })[entry.source.name]
      vim_item.dup = ({
        buffer = 1,
        path = 1,
        nvim_lsp = 0,
      })[entry.source.name] or 0
      return vim_item
    end,
  },
  sorting = {
    comparators = cmp.config.compare.recently_used,
  },
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
})
cmp.setup.cmdline(":", {
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer", keyword_length = 1 },
  },
})
