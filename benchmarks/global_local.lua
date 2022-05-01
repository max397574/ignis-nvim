require("plenary/benchmark")("GLOBAL vs LOCAL", {
    warmup = 300,
    runs = 50000,
    fun = {
        {
            "global",
            function()
                for i = 1, 10000 do
                    local x = math.sin(i)
                end
            end,
        },
        {
            "local",
            function()
                local sin = math.sin
                for i = 1, 10000 do
                    local x = sin(i)
                end
            end,
        },
    },
})
