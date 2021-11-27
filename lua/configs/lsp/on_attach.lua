local on_attach = {}

local function lsp_highlight_document(client)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

function on_attach.setup(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local opts = { noremap = true, silent = true }
  buf_set_keymap("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap(
    "i",
    "<C-k>",
    "<cmd>lua vim.lsp.buf.signature_help()<CR>",
    opts
  )
  buf_set_keymap(
    "n",
    "<C-b>",
    "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>",
    opts
  )
  buf_set_keymap(
    "n",
    "<C-n>",
    "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
    opts
  )
  buf_set_keymap(
    "n",
    "<Leader>fs",
    ":lua vim.lsp.buf.formatting_sync()<CR>",
    opts
  )
  require("configs.lsp.border")
  lsp_highlight_document(client)
end
return on_attach
