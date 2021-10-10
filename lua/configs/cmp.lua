local cmp = require "cmp"
local luasnip = require "luasnip"

local icons = require("configs.lsp.kind").icons

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function get_kind(kind_type)
  return icons[kind_type]
end

cmp.setup {
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  -- You can set mapping if you want.
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = false,
    },
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(t "<Plug>luasnip-expand-or-jump", "")
      else
        fallback()
      end
    end,
  },

  sources = {
    { name = "buffer", priority = 7 },
    { name = "path", priority = 5 },
    { name = "emoji", priority = 3 },
    { name = "calc", priority = 4 },
    { name = "nvim_lsp", priority = 9 },
    { name = "luasnip", priority = 8 },
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format(
        "%s %s",
        get_kind(vim_item.kind),
        vim_item.kind
      )

      vim_item.menu = ({
        nvim_lsp = "(LSP)",
        emoji = "(Emoji)",
        path = "(Path)",
        calc = "(Calc)",
        vsnip = "(Snippet)",
        luasnip = "(Snippet)",
        buffer = "(Buffer)",
      })[entry.source.name]
      vim_item.dup = ({
        buffer = 1,
        path = 1,
        nvim_lsp = 0,
      })[entry.source.name] or 0
      return vim_item
    end,
  },
}
