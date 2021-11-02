vim.cmd([[PackerLoad nvim-cmp]])
vim.cmd([[PackerLoad telescope.nvim]])
require("neorg").setup({
  load = {
    ["core.defaults"] = {}, -- Load all the default modules
    ["core.norg.concealer"] = {
      config = {
        icon_preset = "diamond",
        icons = {
          marker = {
            icon = " ",
          },
        },
      },
    },
    ["core.keybinds"] = {
      config = {
        default_keybinds = true,
        neorg_leader = "<Leader>o",
      },
    },
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    },
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          my_workspace = "~/neorg",
          startup = "~/startup.nvim",
          gtd = "~/gtd"
        },
      },
    },
    ["core.gtd.base"] = {
      config = {
        workspace = {"gtd","startup"}
      },
    },
    ["core.integrations.telescope"] = {},
  },
})
