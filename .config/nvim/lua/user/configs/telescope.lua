-- https://github.com/nvim-telescope
-- https://github.com/nvim-telescope/telescope.nvim#pickers

local telescope = require('telescope')

vim.keymap.set('n', "<Space>t", require('telescope.builtin').builtin, { silent = true, desc = "Open telescope default lists.", noremap = true })
vim.keymap.set('n', "<Space>h", require('telescope.builtin').help_tags, { silent = true, desc = "Open help topic list in telescope.", noremap = true })
vim.keymap.set('n', "<Space>m", require('telescope.builtin').man_pages, { silent = true, desc = "Open man page list in telescope.", noremap = true })
vim.keymap.set('n', "<Space>/", require('telescope.builtin').current_buffer_fuzzy_find, { silent = true, desc = "Open telescope fuzzy finder for current buffer.", noremap = true })

-- :help telescope.setup()
local options = {
    defaults = {
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<F1>"] = "which_key",
                ["?"] = "which_key",
            }
        },
        layout_strategy = 'horizontal',
        layout_config = {
            bottom_pane = {
                height = 25,
                preview_cutoff = 120,
                prompt_position = "top"
            },
            center = {
                height = 0.4,
                preview_cutoff = 40,
                prompt_position = "top",
                width = 0.5
            },
            cursor = {
                height = 0.9,
                preview_cutoff = 40,
                width = 0.8
            },
            horizontal = {
                height = 0.9,
                preview_cutoff = 120,
                prompt_position = "bottom",
                width = 0.95
            },
            vertical = {
                height = 0.9,
                preview_cutoff = 40,
                prompt_position = "bottom",
                width = 0.8
            },
        },
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        dynamic_preview_title = true,
    },
}

-- Load extensons
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Extensions


telescope.setup(options)

