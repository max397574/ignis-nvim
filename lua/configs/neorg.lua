local neorg_callbacks = require("neorg.callbacks")
-- neorg_callbacks.on_event("core.autocommands.events.bufenter", function(event, event_content)
vim.cmd([[PackerLoad nvim-cmp]])
neorg_callbacks.on_event("core.started", function(event, event_content)
  vim.cmd([[PackerLoad telescope.nvim]])
  vim.cmd([[PackerLoad zen-mode.nvim]])
  vim.cmd([[PackerLoad neorg-telescope]])
  require("neorg").setup({
    load = {
      ["core.integrations.telescope"] = {},
    },
  })
  require("telescope").setup({
    pickers = {
      find_files = {
        mappings = {
          i = {
            ["<C-t>"] = require("custom.telescope").append_task,
          },
          n = {
            ["<C-t>"] = require("custom.telescope").append_task,
          },
        },
      },
    },
  })
end)

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
            uncertain = {
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
    ["core.presenter"] = {
      config = {
        zen_mode = "zen-mode",
      },
    },
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    },
    ["core.keybinds"] = {
      config = {
        default_keybinds = true,
        neorg_leader = "<Leader>o",
      },
    },
    -- ["core.norg.completion"] = {
    --   config = {
    --     engine = "nvim-cmp",
    --   },
    -- },
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
        -- exclude = { "" },
      },
    },
    -- ["core.norg.journal"] = {
    --   config = {
    --     -- workspace = "dany_gtd",
    --     journal_folder = "my_journal",
    --     use_folders = false,
    --   }
    -- }
  },
})

local neorg_callbacks = require("neorg.callbacks")

neorg_callbacks.on_event(
  "core.keybinds.events.enable_keybinds",
  function(_, content)
    content.map_to_mode("traverse-heading", {
      n = {
        {
          "<C-s>",
          '<cmd>lua require"telescope".extensions.neorg.search_headings({theme="ivy"})<CR>',
        },
      },
    }, {
      silent = true,
    })
  end
)
