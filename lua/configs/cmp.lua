local cmp = require "cmp"
cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
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
      select = true,
    },
  },

  sources = {
    { name = "buffer" },
    { name = "path" },
    { name = "emoji" },
    { name = "calc" },
    { name = "nvim_lsp" },
    { name = "ultisnips" },
  },
  formatting = {
    format = function(entry, vim_item)
      local icons = require("configs/lsp_kind").icons
      vim_item.kind = icons[vim_item.kind]
      vim_item.menu = ({
        nvim_lsp = "[L]",
        emoji = "[E]",
        path = "[F]",
        calc = "[C]",
        buffer = "[B]",
        ultisnips = "[U]",
        -- add nvim_lua as well
      })[entry.source.name]
      vim_item.dup = ({
        buffer = 1,
        path = 1,
        nvim_lsp = 1,
      })[entry.source.name] or 0
      return vim_item
    end,
  },
}
