local tbl = {}

for i = 1, 10000 do
  table.insert(tbl, i)
end
require("plenary/benchmark")("IPAIRS vs PAIRS", {
  warmup = 300,
  runs = 50000,
  fun = {
    {
      "pairs",
      function()
        for _, v in pairs(tbl) do
          --
        end
      end,
    },
    {
      "ipairs",
      function()
        for _, v in ipairs(tbl) do
          --
        end
      end,
    },
  },
})
