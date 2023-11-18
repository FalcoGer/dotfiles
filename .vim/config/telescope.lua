-- https://github.com/nvim-telescope
-- https://github.com/nvim-telescope/telescope.nvim#pickers

local telescope = require('telescope')

vim.keymap.set('n', "<Space>t", require('telescope.builtin').builtin)
vim.keymap.set('n', "<Space>h", require('telescope.builtin').help_tags)
vim.keymap.set('n', "<Space>m", require('telescope.builtin').man_pages)
vim.keymap.set('n', "<Space>/", require('telescope.builtin').current_buffer_fuzzy_find)

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

    vim.keymap.set('n', "<Space>a", require('telescope').extensions.coc.diagnostics)
    vim.keymap.set('n', "<Space>A", require('telescope').extensions.coc.workspace_diagnostics)
    vim.keymap.set('n', "<Space>s", require('telescope').extensions.coc.document_symbols)
    vim.keymap.set('n', "<Space>S", require('telescope').extensions.coc.workspace_symbols)
    vim.keymap.set('n', "<Space>c", require('telescope').extensions.coc.commands)
    vim.keymap.set('n', "<Space>x", require('telescope').extensions.coc.references)
    vim.keymap.set('n', "<Space>X", require('telescope').extensions.coc.references_used)
    vim.keymap.set('n', "<Space>d", require('telescope').extensions.coc.declarations)
    vim.keymap.set('n', "<Space>D", require('telescope').extensions.coc.definitions)
    vim.keymap.set('n', "<Space>i", require('telescope').extensions.coc.implementations)
end

if vim.g['user_loaded_telescope_dap'] then
    extensions['dap'] = {
        layout_strategy = "vertical",
    }
    vim.keymap.set("n", "<Leader>lb", require('telescope').extensions.dap.list_breakpoints)
    vim.keymap.set("n", "<Leader>dv", require('telescope').extensions.dap.variables)
    vim.keymap.set("n", "<Leader>df", require('telescope').extensions.dap.frames)
    vim.keymap.set("n", "<Leader>dc", require('telescope').extensions.dap.commands)
    vim.keymap.set("n", "<Leader>dC", require('telescope').extensions.dap.configurations)
end

if vim.g['user_loaded_telescope_http'] then
    extensions['http'] = {
        -- How the mozilla url is opened. By default will be configured based on OS:
        -- open_url = 'xdg-open %s' -- UNIX
        -- open_url = 'open %s' -- OSX
        -- open_url = 'start %s' -- Windows
    }
    vim.keymap.set('n', "<Space>H", require('telescope').extensions.http.list)
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
    vim.keymap.set('n', "<Space>E", require('telescope').extensions.emoji.emoji)
end

if vim.g['user_loaded_telescope_glyph'] then
    extensions['glyph'] = {
        action = function(glyph)
            vim.api.nvim_put({glyph.value}, 'c', false, true)
        end
    }
    vim.keymap.set('n', "<Space>G", require('telescope').extensions.glyph.glyph)
end

if vim.g['user_loaded_telescope_color_names'] then
    extensions['color_names'] = {}
    vim.keymap.set('n', "<Space>C", require('telescope').extensions.color_names.color_names)
end

if vim.g['user_loaded_chatgpt'] then
    -- https://github.com/jackMort/ChatGPT.nvim
    extensions['chatgpt'] = {}
end

options['extensions'] = extensions

telescope.setup(options)

if vim.g['user_loaded_telescope_coc'] ~= nil then
    telescope.load_extension('coc')
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
