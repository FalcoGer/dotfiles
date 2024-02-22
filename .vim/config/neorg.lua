-- https://github.com/nvim-neorg/neorg
-- https://github.com/nvim-neorg/neorg/wiki

local neorg = require('neorg')

local options = {
    load = {
        ["core.defaults"] = {},  -- Loads default behaviour
        ["core.concealer"] = {
            config = {
                folds = true,
                icon_preset = "varied", -- "basic", "diamond", "varied"
                icons = {
                    code_block = {
                        conceal = true,     -- hide @code and @end tags
                        content_only = false, -- darken only content or also @code and @end tags
                        padding = {
                            left = 8,
                            right = 0,
                        },
                        spell_check = false,
                        width = "fullwidth", -- "fullwidth" or "content"
                    },
                },
            }
        }, -- Adds pretty icons to your documents
        ["core.dirman"] = {      -- Manages Neorg workspaces
            config = {
                workspaces = {
                    notes = "~/Documents/notes",
                },
                default_workspace = "notes",
            },
        },
        ["core.integrations.telescope"] = {},
        ["core.looking-glass"] = {}, -- code block editing
        ["core.keybinds"] = {
            config = {
                hook = function(keybinds)
                    keybinds.unmap("norg", "n", keybinds.leader .. "nn")

                    keybinds.map_event_to_mode("norg", {
                        n = { -- Bind keys in normal mode
                            { "<M-l>", "core.integrations.telescope.find_linkable" },
                            { "<Leader>N", "core.dirman.new.note" },
                            { "<C-CR>", "core.looking-glass.magnify-code-block" }
                        },

                        i = { -- Bind in insert mode
                            { "<M-l>", "core.integrations.telescope.insert_link" },
                        },
                    }, {
                        silent = true,
                        noremap = true,
                    })
                end,
            },
        },
    },
}

neorg.setup(options)

