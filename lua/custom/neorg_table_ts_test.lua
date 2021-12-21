local M = {}

local parsers = require("nvim-treesitter.parsers")

local ts_utils = require("nvim-treesitter.ts_utils")

function M.test()
  local current_node = ts_utils.get_node_at_cursor()
  print("current_node:")
  dump(current_node)
  local node_txt = tostring(current_node)
  print("node_txt:")
  dump(node_txt)
  local expr = current_node
  print("expr:")
  dump(expr)
  for u, c in current_node:iter_children() do
    print("c:")
    dump(c)
    print("u:")
    dump(u)
    while expr:type() ~= "ranged_tag_content" do
      expr = expr:parent()
    end
  end
  local ret = ts_utils.node_to_lsp_range(expr)
  print("ret:")
  dump(ret)
  return ret
end

function M.get_top_node_at_cursor()
  local bufnr = vim.api.nvim_get_current_buf()
  -- assert(parsers.has_parsers(parsers.get_buf_lang(bufnr)), "File has no parsers")
  local root = parsers.get_tree_root(0)

  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1]
  local col = cursor[2]

  return root:named_descendant_for_range(row - 1, col, row - 1, col)
end

return M
