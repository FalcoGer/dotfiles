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

local extensions = {}

if vim.g['user_loaded_telescope_coc'] ~= nil then
    -- https://github.com/fannheyward/telescope-coc.nvim
    extensions['coc'] = {
        prefer_preview = true,
        prefer_locations = true,
    }

    vim.keymap.set('n', "<Space>a", require('telescope').extensions.coc.diagnostics, { silent = true, desc = "Open document coc-diagnostics list in telescope.", noremap = true })
    vim.keymap.set('n', "<Space>A", require('telescope').extensions.coc.workspace_diagnostics, { silent = true, desc = "Open workspace coc-diagnostics list in telescope.", noremap = true })
    vim.keymap.set('n', "<Space>s", require('telescope').extensions.coc.document_symbols, { silent = true, desc = "Open document coc-symbol list in telescope.", noremap = true })
    vim.keymap.set('n', "<Space>S", require('telescope').extensions.coc.workspace_symbols, { silent = true, desc = "Open workspace coc-symbol list in telescope.", noremap = true })
    vim.keymap.set('n', "<Space>c", require('telescope').extensions.coc.commands, { silent = true, desc = "Open coc-extensions list in telescope.", noremap = true })
    vim.keymap.set('n', "<Space>x", require('telescope').extensions.coc.references, { silent = true, desc = "Open coc-references list in telescope.", noremap = true })
    vim.keymap.set('n', "<Space>X", require('telescope').extensions.coc.references_used, { silent = true, desc = "Open coc-used-references list in telescope.", noremap = true })
    vim.keymap.set('n', "<Space>d", require('telescope').extensions.coc.declarations, { silent = true, desc = "Open coc-declarations list in telescope.", noremap = true })
    vim.keymap.set('n', "<Space>D", require('telescope').extensions.coc.definitions, { silent = true, desc = "Open coc-definitions list in telescope.", noremap = true })
    vim.keymap.set('n', "<Space>i", require('telescope').extensions.coc.implementations, { silent = true, desc = "Open coc-implemetations list in telescope.", noremap = true })
end

if vim.g['user_loaded_telescope_fzf'] then
    extensions['fzf'] = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case",       -- "smart_case", "ignore_case" or "respect_case"
                                        -- the default case_mode is "smart_case"
    }
end

if vim.g['user_loaded_telescope_dap'] then
    extensions['dap'] = {
        layout_strategy = "vertical",
    }
    vim.keymap.set("n", "<Leader>lb", require('telescope').extensions.dap.list_breakpoints, { silent = true, desc = "Open dap breapoints list in telescope.", noremap = true })
    vim.keymap.set("n", "<Leader>dv", require('telescope').extensions.dap.variables, { silent = true, desc = "Open dap varaibles list in telescope.", noremap = true })
    vim.keymap.set("n", "<Leader>df", require('telescope').extensions.dap.frames, { silent = true, desc = "Open dap frames list in telescope.", noremap = true })
    vim.keymap.set("n", "<Leader>dc", require('telescope').extensions.dap.commands, { silent = true, desc = "Open dap command list in telescope.", noremap = true })
    vim.keymap.set("n", "<Leader>dC", require('telescope').extensions.dap.configurations, { silent = true, desc = "Open dap configurations list in telescope.", noremap = true })
end

if vim.g['user_loaded_telescope_http'] then
    extensions['http'] = {
        -- How the mozilla url is opened. By default will be configured based on OS:
        -- open_url = 'xdg-open %s' -- UNIX
        -- open_url = 'open %s' -- OSX
        -- open_url = 'start %s' -- Windows
    }
    vim.keymap.set('n', "<Space>H", require('telescope').extensions.http.list, { silent = true, desc = "Open HTTP status code list in telescope.", noremap = true })
end

if vim.g['user_loaded_telescope_emoji'] then
    extensions['emoji'] = {
        action = function(emoji)
            -- argument emoji is a table.
            -- {name="", value="", cagegory="", description=""}

            -- vim.fn.setreg("*", emoji.value)
            -- print([[Press p or "*p to paste this emoji]] .. emoji.value)

            -- insert emoji when picked
            vim.api.nvim_put({ emoji.value }, 'c', false, true)
        end,
    }
    vim.keymap.set('n', "<Space>E", require('telescope').extensions.emoji.emoji, { silent = true, desc = "Open emoji list in telescope.", noremap = true })
end

if vim.g['user_loaded_telescope_glyph'] then
    extensions['glyph'] = {
        action = function(glyph)
            vim.api.nvim_put({glyph.value}, 'c', false, true)
        end
    }
    vim.keymap.set('n', "<Space>G", require('telescope').extensions.glyph.glyph, { silent = true, desc = "Open glyph list in telescope.", noremap = true })
end

if vim.g['user_loaded_telescope_color_names'] then
    extensions['color_names'] = {}
    vim.keymap.set('n', "<Space>C", require('telescope').extensions.color_names.color_names, { silent = true, desc = "Open color name list in telescope.", noremap = true })
end

if vim.g['user_loaded_noice'] then
    extensions['noice'] = {}
    vim.keymap.set('n', '<Space>n', ':Telescope noice<CR>', { silent = true, desc = "Open noice history in telescope.", noremap = true })
end

options['extensions'] = extensions

telescope.setup(options)

if vim.g['user_loaded_telescope_coc'] ~= nil then
    telescope.load_extension('coc')
end

if vim.g['user_loaded_telescope_fzf'] then
    telescope.load_extension('fzf')
end

if vim.g['user_loaded_telescope_dap'] then
    telescope.load_extension('dap')
end

if vim.g['user_loaded_telescope_http'] then
    telescope.load_extension('http')
end

if vim.g['user_loaded_telescope_emoji'] then
    telescope.load_extension('emoji')
end

if vim.g['user_loaded_telescope_glyph'] then
    telescope.load_extension('glyph')
end

if vim.g['user_loaded_telescope_color_names'] then
    telescope.load_extension('color_names')
end


if vim.g['user_loaded_noice'] then
    telescope.load_extension('noice')
end
