require("popup_menu").setup()
require("popup_menu").new_menu("test", {
    "menu title",
    {
        {
            "first item",
            function()
                print("yes")
            end,
        },
        {
            "second item",
            {
                "title",
                {
                    {
                        "another item",
                        function()
                            print("yes another one")
                        end,
                    },
                    {
                        "nested items are cool",
                        {
                            "super nested title",
                            {
                                {
                                    "nest madness",
                                    function()
                                        print("ok I'll stop")
                                    end,
                                },
                            },
                        },
                    },
                },
            },
        },
    },
})
-- require("popup_menu").new_menu("test2", { "test table" })
