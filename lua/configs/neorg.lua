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
          todo = {
            enable = true,
            pending = {
              -- icon = ""
              icon = "",
            },
            uncertaint = {
              icon = "?",
            },
            urgent = {
              icon = "",
            },
            on_hold = {
              icon = "",
            },
            cancelled = {
              icon = "",
            },
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
          startup = "~/startup.nvim",
          example_ws = "~/example_workspaces/gtd/",
          gtd = "~/gtd",
          dany_gtd = "~/dany_gtd/",
        },
      },
    },
    ["core.gtd.base"] = {
      config = {
        workspace = "gtd",
        -- workspace = "example_ws",
        -- workspace = "dany_gtd",
        -- exclude = { "gtd.norg", "neogen.norg", "kenaos.norg"},
      },
    },
    ["core.integrations.telescope"] = {},
    -- ["core.norg.journal"] = {
    --   config = {
    --     -- workspace = "dany_gtd",
    --     journal_folder = "my_journal",
    --     use_folders = false,
    --   }
    -- }
  },
})
