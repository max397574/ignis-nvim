local exp = vim.fn.expand
local this = vim.api.nvim_get_current_buf
local nore_silent = { noremap = true, silent = true }

require("toggleterm").setup({
  hide_numbers = true,
  start_in_insert = true,
  insert_mappings = true,
  open_mapping = [[<c-t>]],
  shade_terminals = true,
  shading_factor = "3",
  persist_size = true,
  close_on_exit = false,
  direction = "float",
  float_opts = {
    -- border = require("utils").border_thin_rounded,
    border = "shadow",
    winblend = 0,
    highlights = {
      border = "FloatBorder",
      background = "NormalFloat",
    },
  },
})
local files = {
  python = "python3 -i " .. exp("%:t"),
  lua = "lua " .. exp("%:t"),
  c = "gcc -o temp " .. exp("%:t") .. " && ./temp && rm ./temp",
  cpp = "clang++ -o temp " .. exp("%:t") .. " && ./temp && rm ./temp",
  java = "javac "
    .. exp("%:t")
    .. " && java "
    .. exp("%:t:r")
    .. " && rm *.class",
  rust = "cargo run",
  javascript = "node " .. exp("%:t"),
  typescript = "tsc " .. exp("%:t") .. " && node " .. exp("%:t:r") .. ".js",
}

local file_extenstions = {
  ["typescript"] = "ts",
  ["python"] = "py",
  ["java"] = "java",
  ["html"] = "html",
  ["css"] = "css",
  ["javascript"] = "js",
  ["javascriptreact"] = "jsx",
  ["markdown"] = "md",
  ["sh"] = "sh",
  ["zsh"] = "zsh",
  ["vim"] = "vim",
  ["rust"] = "rs",
  ["cpp"] = "cpp",
  ["c"] = "c",
  ["go"] = "go",
  ["lua"] = "lua",
  ["conf"] = "conf",
  ["haskel"] = "hs",
  ["ruby"] = "rb",
  ["txt"] = "txt",
}

function Run_file()
  local command = files[vim.bo.filetype]
  if command ~= nil then
    require("toggleterm.terminal").Terminal:new({ cmd = command, close_on_exit = false }):toggle()
    print("Running: " .. command)
  end
end
vim.api.nvim_buf_set_keymap(
  this(),
  "n",
  "<leader>r",
  [[:w<CR>:lua Run_file()<CR>]],
  nore_silent
)

local function toggle_lazygit()
require("toggleterm.terminal").Terminal:new{cmd="lazygit", close_on_exit=true}:toggle()
end

vim.keymap.set(
  "n",
  "<c-g>",
  toggle_lazygit,
  nore_silent
)
