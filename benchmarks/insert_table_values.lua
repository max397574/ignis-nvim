require("plenary/benchmark")("lenght + 1 vs table.insert", {
    warmup = 300,
    runs = 50000,
    fun = {
        {
            "table.insert",
            function()
                local x = {}
                for i = 1, 1000, 1 do
                    table.insert(x, i)
                end
                return x
            end,
        },
        {
            "lenght + 1",
            function()
                local x = {}
                for i = 1, 1000, 1 do
                    x[#x + 1] = i
                end
                return x
            end,
        },
    },
})
