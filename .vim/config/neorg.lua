-- https://github.com/nvim-neorg/neorg
-- https://github.com/nvim-neorg/neorg/wiki

local neorg = require('neorg')

local options = {
    load = {
        ["core.defaults"] = {},  -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = {      -- Manages Neorg workspaces
            config = {
                workspaces = {
                    notes = "~/Documents/notes",
                },
            },
        },
        ["core.integrations.telescope"] = {}
    },
}

neorg.setup(options)

local neorg_callbacks = require("neorg.core.callbacks")

neorg_callbacks.on_event(
    "core.keybinds.events.enable_keybinds",
    function(_, keybinds)
        -- Map all the below keybinds only when the "norg" mode is active
        keybinds.map_event_to_mode("norg", {
            n = { -- Bind keys in normal mode
                { "<M-s>", "core.integrations.telescope.find_linkable" },
            },

            i = { -- Bind in insert mode
                { "<M-l>", "core.integrations.telescope.insert_link" },
            },
        }, {
            silent = true,
            noremap = true,
        })
    end
)
