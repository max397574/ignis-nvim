local Rule = require("nvim-autopairs.rule")
local npairs = require("nvim-autopairs")
require("nvim-autopairs").setup({
    -- ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
    ignored_next_char = "",
    map_c_w = true,
})
npairs.add_rule(Rule("$", "$", "tex"))
