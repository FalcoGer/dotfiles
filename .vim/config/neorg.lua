-- https://github.com/nvim-neorg/neorg
-- https://github.com/nvim-neorg/neorg/wiki

local neorg = require('neorg')

local dirman = require('neorg').modules.get_module("core.dirman")

CreateNote = function()
    local dirman = require('neorg').modules.get_module("core.dirman")
    local noteName = vim.fn.input("New Note: ")

    if noteName ~= nil and noteName ~= "" then
        dirman.create_file(noteName, "notes", {
            no_open  = false, -- open file after creation?
            force    = false, -- overwrite file if exists
            metadata = {} -- key-value table for metadata fields
        })
    end
end

vim.keymap.set('n', '<Leader>N', ':lua CreateNote()<CR>', { silent = true, desc = "Neorg new note."})

local options = {
    load = {
        ["core.defaults"] = {},  -- Loads default behaviour
        ["core.concealer"] = {
            config = {
                folds = true,
                icon_preset = "varied", -- "basic", "diamond", "varied"
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
