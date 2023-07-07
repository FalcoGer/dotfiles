local nt = require('nvim-tree')

local function myAttach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
        return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true
        }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- Custom mappings
    vim.keymap.set('n', '<C-CR>',   api.tree.change_root_to_node,           opts('CD'))
    vim.keymap.set('n', '<F1>',     api.tree.toggle_help,                   opts('Help'))
    vim.keymap.set('n', '<F5>',     api.tree.reload,                        opts('Refresh'))
    -- make hidden filter toggle
    vim.keymap.del('n', 'H', { buffer = bufnr }) -- remove toggle dotfiles filter
    vim.keymap.set('n', 'h',        api.tree.toggle_hidden_filter,          opts('Toggle Dotfiles'))
    -- Swap S and s
    vim.keymap.set('n', 'S',        api.node.run.system,                    opts('Run system'))
    vim.keymap.set('n', 's',        api.tree.search_node,                   opts('Search'))
    -- redefine copy, cut, paste, rename and new to be in line with OS commands
    vim.keymap.del('n', 'c', { buffer = bufnr }) -- remove copy
    vim.keymap.set('n', '<C-x>',    api.fs.copy.node,                       opts('Copy'))
    vim.keymap.del('n', 'x', { buffer = bufnr }) -- remove cut
    vim.keymap.set('n', '<C-x>',    api.fs.cut,                             opts('Cut'))
    vim.keymap.del('n', 'p', { buffer = bufnr }) -- remove paste
    vim.keymap.set('n', '<C-v>',    api.fs.paste,                           opts('Paste'))
    vim.keymap.del('n', 'a', { buffer = bufnr }) -- remove create
    vim.keymap.set('n', '<C-n>',    api.fs.create,                          opts('Create'))
    vim.keymap.del('n', 'r', { buffer = bufnr }) -- remove rename (F2)
    vim.keymap.set('n', '<F2>',     api.fs.rename,                          opts('Rename'))

    -- remove weird 2 sequence stroke for copy path, replace with modifier key
    vim.keymap.del('n', 'gy', { buffer = bufnr }) -- remove copy absolute path (C-y)
    vim.keymap.set('n', '<C-y>',    api.fs.copy.absolute_path,              opts('Paste'))

    -- swap trash and delete to be safer and in line with OS
    vim.keymap.set('n', 'd',    api.fs.trash,                               opts('Trash'))
    vim.keymap.set('n', 'D',    api.fs.remove,                              opts('Delete'))

    -- key to go to parrent
    vim.keymap.set('n', '<BS>', api.tree.change_root_to_parent,             opts('Up'))

    -- info on i, it's not editable anyway
    vim.keymap.set('n', 'i', api.node.show_info_popup,                      opts('Info'))

    -- remove redundant and weird keys
    vim.keymap.del('n', '<C-]>', { buffer = bufnr }) -- remove CD (C-CR)
    vim.keymap.del('n', '<C-k>', { buffer = bufnr }) -- remove info (i)
    vim.keymap.del('n', 'R', { buffer = bufnr }) -- remove reload (F5)
    vim.keymap.del('n', 'g?', { buffer = bufnr }) -- remove help (F1)

end

local customSort = function(nodes)
    local sortFunc = function(a, b)
        if a.type == "directory" and b.type ~= "directory" then
             -- directories first
            return true
        end
        if b.type == "directory" and a.type ~= "directory" then
             -- directories first
            return false
        end

        if a.name:sub(1, 1) == '.' and b.name:sub(1, 1) ~= '.' then
            -- dotfiles last
            return false
        end
        if b.name:sub(1, 1) == '.' and a.name:sub(1, 1) ~= '.' then
            -- dotfiles last
            return true
        end
        -- otherwise just sort by name, case insensitive
        return a.name:upper() < b.name:upper()
    end

    table.sort(nodes, sortFunc)
end

-- :help nvim-tree-setup
options = {
    hijack_cursor = true, -- keep cursor on first letter
    sort_by = customSort, -- group directories first
    disable_netrw = true, -- does nothing?
    on_attach = myAttach,
    view = {
        width = 34,
    },
    renderer = {
        group_empty = true,                     -- folders that only contain a single folder are compacted
        add_trailing = true,                    -- add trailing slash to directories
        full_name = true,                       -- display full name in a floating window
        highlight_git = true,                   -- use NvimTreeGit* highlight groups
        highlight_opened_files = "name",        -- highlight opened files with the NvimTreeOpenedFile highlight group
        highlight_modified = "none",            -- highlight modified files with the NvimTreeModifiedFile highlight group
        indent_markers = {                      -- display arrows for open folders
            enable = true
        },
        icons = {
            show = {
                git = true,
                modified = true,
            },
            git_placement = "before",
            modified_placement = "before",
        },
        special_files = {                       -- these files get highlighted with the NvimTreeSpecialFile highlight group
            "Cargo.toml",
            "Makefile",
            "README.md",
            "readme.md"
        },
        symlink_destination = true,
    },
    git = {
        enable = true, -- enable git integration
        ignore = false, -- show files ignored by gitignore
        show_on_dirs = true, -- show status of children on directories when directory has none
        show_on_open_dirs = true, -- show status of children on open directories
        timeout = 800, -- kills git after this many ms, if this happens 10 times, git integration is disabled
    },
    filters = {
        dotfiles = false, -- display dotfiles
    },
    trash = {
        cmd = "trash"
    },
    actions = {
        expand_all = {
            exclude = {
                ".git"
            }
        },
        open_file = {
            quit_on_open = false, -- keep tree open after opening a file
        },
        remove_file = {
            close_window = false, -- keep file buffer open, even after deleting the file on disk
        }
    },
    live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = false, -- also filter folder names
    },
    tab = {
        sync = {
            open = true, -- sync tree being opened in all tabs
            close = true, -- sync tree being closed in all tabs
        }
    }
}

nt.setup(options)
