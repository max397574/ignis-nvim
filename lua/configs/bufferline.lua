require("bufferline").setup({
  options = {
    diagnostics = "nvim_diagnostic",
    custom_areas = {
      right = function()
        local warning
        local error
        local info
        local hint
        local diagnostics = vim.diagnostic.get(0)
        local count = { 0, 0, 0, 0 }
        for _, diagnostic in ipairs(diagnostics) do
          count[diagnostic.severity] = count[diagnostic.severity] + 1
        end
        local result = {}

        if count[1] ~= 0 then
          table.insert(result, { text = "  " .. count[1], guifg = "#B30B00" })
        end

        if count[2] ~= 0 then
          table.insert(result, { text = "  " .. count[2], guifg = "#FABD2F" })
        end

        if count[4] ~= 0 then
          table.insert(result, { text = "  " .. count[4], guifg = "#207245" })
        end

        if count[3] ~= 0 then
          table.insert(result, { text = "  " .. count[3], guifg = "#0048FF" })
        end
        return result
      end,
    },
  },
})
