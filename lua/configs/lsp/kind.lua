local M = {}

M.icons = {
  Class = " ",
  Color = " ",
  Constant = " ",
  Constructor = " ",
  Enum = "了 ",
  EnumMember = " ",
  Event = "",
  -- Field = " ",
  Field = "ﰠ",
  -- File = " ",
  File = "",
  Folder = " ",
  Function = " ",
  Interface = "ﰮ ",
  Keyword = " ",
  Method = "ƒ ",
  Module = " ",
  Operator = "",
  Property = " ",
  Reference = "",
  Snippet = "﬌ ",
  Struct = " ",
  -- Text = " ",
  Text = "",
  TypeParameter = "",
  -- Unit = " ",
  Unit = "塞",
  Value = " ",
  -- Variable = " ",
  Variable = "",
}

function M.setup()
  local kinds = vim.lsp.protocol.CompletionItemKind
  for i, kind in ipairs(kinds) do
    kinds[i] = M.icons[kind] or kind
  end
end

return M

