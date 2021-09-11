require("bufferline").setup {
  options = {
    custom_areas = {
      right = function()
        local result = {}
        local error = vim.lsp.diagnostic.get_count(0, [[Error]])
        local warning = vim.lsp.diagnostic.get_count(0, [[Warning]])
        local info = vim.lsp.diagnostic.get_count(0, [[Information]])
        local hint = vim.lsp.diagnostic.get_count(0, [[Hint]])

        if error ~= 0 then
          table.insert(result, { text = "  " .. error, guifg = "#B30B00" })
        end

        if warning ~= 0 then
          table.insert(result, { text = "  " .. warning, guifg = "#FABD2F" })
        end

        if hint ~= 0 then
          table.insert(result, { text = "  " .. hint, guifg = "#207245" })
        end

        if info ~= 0 then
          table.insert(result, { text = "  " .. info, guifg = "#0048FF" })
        end
        return result
      end,
    },
  },
}
