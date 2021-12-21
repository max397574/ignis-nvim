local action_state = require("telescope.actions.state")
local action_mt = require("telescope.actions.mt")
local ts_utils = require("nvim-treesitter.ts_utils")

local my_actions = {}

-- recursively asscend up until passed node
local get_node_recursively = function(opts)
  opts = opts or {}
  opts.win_id = vim.F.if_nil(opts.win_id, 0)
  opts.type = vim.F.if_nil(opts.type, "carryover_tag_set")
  local current_node = ts_utils.get_node_at_cursor(opts.win_id)
  print("current_node:")
  dump(current_node)
  if not current_node then
    return ""
  end
  local expr = current_node

  while expr:type() ~= opts.type do
    expr = expr:parent()
  end
  local ret = ts_utils.node_to_lsp_range(expr)
  return ret
end

local find_buffer_by_name = function(filename)
  local bufs = vim.api.nvim_list_bufs()
  for _, buf in ipairs(bufs) do
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if buf_name:find(filename) then
      return buf
    end
  end
end

local load_file = function(filename)
  vim.cmd(string.format("bad %s", filename))
  local buf_nr = find_buffer_by_name(filename)
  vim.fn.bufload(buf_nr)
  return buf_nr
end

local append_lines_to_buf = function(lines, bufnr, opts)
  opts = opts or {}
  opts.with_space = vim.F.if_nil(opts.with_space, true)
  if opts.with_space then
    table.insert(lines, 1, "")
  end
  local buf_line_count = vim.api.nvim_buf_line_count(bufnr)
  vim.api.nvim_buf_set_lines(
    bufnr,
    buf_line_count,
    buf_line_count + #lines,
    false,
    lines
  )
  vim.api.nvim_buf_call(bufnr, function()
    vim.cmd([[write! ]])
  end)
end

my_actions.append_task = function(prompt_bufnr)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local original_win_id = current_picker.original_win_id
  local original_buf_nr = vim.api.nvim_win_get_buf(original_win_id)

  local node_range = get_node_recursively({
    win_id = original_win_id,
    type = "carryover_tag_set",
  })

  local task_lines = vim.api.nvim_buf_get_lines(
    original_buf_nr,
    node_range["start"].line,
    node_range["end"].line + 1,
    false
  )
  local filename = vim.loop.cwd()
    .. "/"
    .. action_state.get_selected_entry().value
  -- local filename = vim.loop.cwd() .. "/" .. action_state.get_selected_entry().value:sub(3, -1)
  local buf_nr = load_file(filename)
  append_lines_to_buf(task_lines, buf_nr)

  vim.api.nvim_buf_call(original_buf_nr, function()
    vim.cmd(
      string.format(
        "%s,%sdelete",
        node_range["start"].line + 1,
        node_range["end"].line + 1
      )
    )
  end)
end

return action_mt.transform_mod(my_actions)
