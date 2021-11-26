local map = vim.api.nvim_set_keymap
local exp = vim.fn.expand
local this = vim.api.nvim_get_current_buf
local nore_silent = { noremap = true, silent = true }

Open_term = require("toggleterm.terminal").Terminal

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
    border = require("utils").border_thin_rounded,
    winblend = 10,
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
    Open_term:new({ cmd = command, close_on_exit = false }):toggle()
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
