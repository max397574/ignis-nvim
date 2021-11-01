local lsp_kind = {}

lsp_kind.icons = {
  Class = "  ",
  Color = "  ",
  Constant = "  ",
  Constructor = "  ",
  Enum = " 了 ",
  EnumMember = "  ",
  Event = "  ",
  Field = "ﰠ ",
  -- File = " ",
  File = "  ",
  Folder = "  ",
  Function = "  ",
  Interface = "ﰮ ",
  Keyword = "  ",
  Method = " ƒ ",
  Module = "  ",
  Operator = "  ",
  Property = "  ",
  Reference = " ",
  Snippet = "  ",
  Struct = " ",
  Text = " ",
  TypeParameter = "",
  Unit = " 塞",
  Value = "  ",
  Variable = "  ",
}

function lsp_kind.setup()
  local kinds = vim.lsp.protocol.CompletionItemKind
  for i, kind in ipairs(kinds) do
    kinds[i] = lsp_kind.icons[kind] or kind
  end
end

return lsp_kind
