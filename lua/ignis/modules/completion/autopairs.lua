local Rule = require("nvim-autopairs.rule")
local npairs = require("nvim-autopairs")
require("nvim-autopairs").setup({})
npairs.add_rule(Rule("$", "$", "tex"))
