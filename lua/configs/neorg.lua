local neorg_callbacks = require("neorg.callbacks")
-- neorg_callbacks.on_event("core.autocommands.events.bufenter", function(event, event_content)
-- vim.cmd([[PackerLoad nvim-cmp]])
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
    ["core.norg.completion"] = {
      config = {
        engine = "nvim-cmp",
      },
    },
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
    ["core.keybinds"] = {
      config = {
        default_keybinds = true,
        neorg_leader = "<Leader>o",
      },
    },
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          startup = "~/startup.nvim",
          example_ws = "~/example_workspaces/gtd/",
          gtd = "~/gtd",
          dany_gtd = "~/dany_gtd/",
          notes = "~notes",
        },
      },
    },
    ["core.gtd.base"] = {
      config = {
        workspace = "gtd",
        -- workspace = "example_ws",
        -- exclude = { "" },
      },
    },
    -- ["core.norg.qol.toc"] = {
    --   config = {
    --     close_split_on_jump = false,
    --     toc_split_placement = "left",
    --   },
    -- },
    ["core.norg.journal"] = {
      config = {
        journal_folder = "my_journal",
        use_folders = false,
      },
    },
  },
})

neorg_callbacks.on_event(
  "core.keybinds.events.enable_keybinds",
  function(_, content)
    content.map_to_mode("traverse-heading", {
      n = {
        {
          "<C-s>",
          [[<cmd>lua require"telescope".extensions.neorg.search_headings({theme="ivy",border = true,previewer = false,shorten_path = false,prompt_prefix = " ◈  ",layout_config = {prompt_position = "top"}})<CR>]],
        },
      },
    }, {
      silent = true,
    })
  end
)
