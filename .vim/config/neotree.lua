-- https://github.com/nvim-neo-tree/neo-tree.nvim/
-- :help neo-tree

local nt = require('neo-tree')

vim.cmd("cnoreabbrev nt Neotree")

-- ==================================================================
-- highlights

-- NeoTreeTabInactive
-- NeoTreeTabActive
-- NeoTreeTabInactive
-- NeoTreeTabSeparatorInactive
-- NeoTreeTabSeparatorActive
-- NeoTreeIndentMarker
-- NeoTreeExpander
-- NeoTreeModified
-- NeoTreeFileName


-- ==================================================================
-- Buffer and filetypes not to open documents in
local open_files_do_not_replace_types = {
    "terminal",
    "trouble",
    "qf",
    "dapui_watches",
    "dapui_stacks",
    "dapui_breakpoints",
    "dapui_scopes",
    "dap-repl",
    "dapui_console",
    "undotree",
    "diff",
    "tagbar",
    "help",
    "fugitive",
    "floggraph",
    "git",
    "list",
    "unite",
}


-- ==================================================================
-- mappings

local window_mapping_options = {
    noremap = true,
    nowait = true,
}

local window_mapping_mappings = {
    ["<space>"] = {
        "toggle_node",
        -- nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
    },
    ["<2-LeftMouse>"] = "open",
    ["<cr>"] = "open",
    -- ["<cr>"] = { "open", config = { no_expand_file = true } }, -- open top file instead of expanding when nested
    ["<esc>"] = "cancel", -- close preview or floating neo-tree window
    ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
    ["l"] = "focus_preview",
    ["s"] = "open_split",
    -- ["S"] = "split_with_window_picker",
    ["v"] = "open_vsplit",
    -- ["s"] = "vsplit_with_window_picker",
    ["t"] = "open_tabnew",
    -- ["<cr>"] = "open_drop",
    -- ["t"] = "open_tab_drop",
    ["w"] = "open_with_window_picker",
    ["C"] = "close_node",
    ["z"] = "close_all_subnodes",
    --["Z"] = "expand_all_nodes",
    ["R"] = "refresh",
    -- ["<F5>"] = "refresh", -- conflicts debugging
    ["a"] = {
        "add",
        -- some commands may take optional config options, see `:h neo-tree-mappings` for details
        config = {
            show_path = "absolute", -- "none", "relative", "absolute"
        }
    },
    ["A"] = "add_directory", -- also accepts the config.show_path and config.insert_as options.
    ["<DEL>"] = "delete",
    ["r"] = "rename",
    ["y"] = "copy_to_clipboard",
    ["x"] = "cut_to_clipboard",
    ["p"] = "paste_from_clipboard",
    ["c"] = "copy", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
    ["m"] = "move", -- takes text input for destination, also accepts the config.show_path and config.insert_as options
    ["e"] = "toggle_auto_expand_width",
    ["q"] = "close_window",
    ["?"] = "show_help",
    ["<"] = "prev_source",
    [">"] = "next_source",
}

local filesystem_window = {
    mappings = {
        ["H"] = "toggle_hidden",
        ["/"] = "fuzzy_finder",
        ["d"] = "fuzzy_finder_directory",
        --["/"] = "filter_as_you_type", -- this was the default until v1.28
        ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
        ["D"] = "fuzzy_sorter_directory",
        ["f"] = "filter_on_submit",
        ["F"] = "clear_filter",
        ["<bs>"] = "navigate_up",
        ["."] = "set_root",
        ["<C-CR>"] = "set_root",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
        ["i"] = "show_file_details",
        ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
        ["oc"] = { "order_by_created", nowait = false },
        ["od"] = { "order_by_diagnostics", nowait = false },
        ["og"] = { "order_by_git_status", nowait = false },
        ["om"] = { "order_by_modified", nowait = false },
        ["on"] = { "order_by_name", nowait = false },
        ["os"] = { "order_by_size", nowait = false },
        ["ot"] = { "order_by_type", nowait = false },
    },
    -- define keymaps for filter popup window in fuzzy_finder_mode
    fuzzy_finder_mappings = {
        ["<down>"] = "move_cursor_down",
        ["<up>"] = "move_cursor_up",
    },
}

local buffers_window_mappings = {
    ["<bs>"] = "navigate_up",
    ["."] = "set_root",
    ["<C-CR>"] = "set_root",
    ["bd"] = "buffer_delete",
    ["i"] = "show_file_details",
    ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
    ["oc"] = { "order_by_created", nowait = false },
    ["od"] = { "order_by_diagnostics", nowait = false },
    ["om"] = { "order_by_modified", nowait = false },
    ["on"] = { "order_by_name", nowait = false },
    ["os"] = { "order_by_size", nowait = false },
    ["ot"] = { "order_by_type", nowait = false },
}

local gitstatus_window_mappings = {
    ["A"] = "git_add_all",
    ["gu"] = "git_unstage_file",
    ["ga"] = "git_add_file",
    ["gr"] = "git_revert_file",
    ["gc"] = "git_commit",
    ["gp"] = "git_push",
    ["gg"] = "git_commit_and_push",
    ["i"] = "show_file_details",
    ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
    ["oc"] = { "order_by_created", nowait = false },
    ["od"] = { "order_by_diagnostics", nowait = false },
    ["om"] = { "order_by_modified", nowait = false },
    ["on"] = { "order_by_name", nowait = false },
    ["os"] = { "order_by_size", nowait = false },
    ["ot"] = { "order_by_type", nowait = false },
}

local documents_symbols_window_mappings = {
    ["<cr>"] = "jump_to_symbol",
    ["o"] = "jump_to_symbol",
    ["A"] = "noop", -- also accepts the config.show_path and config.insert_as options.
    ["<del>"] = "noop",
    ["y"] = "noop",
    ["x"] = "noop",
    ["p"] = "noop",
    ["c"] = "noop",
    ["m"] = "noop",
    ["a"] = "noop",
    ["/"] = "filter",
    ["f"] = "filter_on_submit",
}

-- ==================================================================
-- sources for neo-tree
local showDocumentSymbolsSource = false

local sources = {
    "filesystem",
    "buffers",
    "git_status",
}

local sources_display = {
    {
        source = "filesystem",
        display_name = " 󰉓 Files ",
    },
    {
        source = "buffers",
        display_name = " 󰈚 Buffers ",
    },
    {
        source = "git_status",
        display_name = " 󰊢 Git ",
    },
}


if showDocumentSymbolsSource then
    table.insert(sources, "document_symbols")
    table.insert(sources_display,{
        source = "document_symbols",
        display_name = "  Symbols "
    })
end

if vim.g['user_loaded_neotree_diagnostics'] ~= nil then
    table.insert(sources, "diagnostics")
    table.insert(sources_display,
    {
        source = "diagnostics",
        display_name = "  Diagnostics "
    })
end

if vim.g['user_loaded_netman'] then
    table.insert(sources, "netman.ui.neo-tree")
    table.insert(sources_display,
    {
        source = "remote",
        display_name = " 󰲁 NetMan "
    })
end


-- ==================================================================
-- Diagnostics plugin
local diagnostics = {
    auto_preview = { -- May also be set to `true` or `false`
        enabled = true, -- Whether to automatically enable preview mode
        preview_config = { use_float = true }, -- Config table to pass to auto preview (for example `{ use_float = true }`)
        event = "neo_tree_buffer_enter", -- The event to enable auto preview upon (for example `"neo_tree_window_after_open"`)
    },
    bind_to_cwd = true,
    diag_sort_function = "severity", -- "severity" means diagnostic items are sorted by severity in addition to their positions.
    -- "position" means diagnostic items are sorted strictly by their positions.
    -- May also be a function.
    follow_current_file = { -- May also be set to `true` or `false`
        enabled = true, -- This will find and focus the file in the active buffer every time
        always_focus_file = false, -- Focus the followed file, even when focus is currently on a diagnostic item belonging to that file
        expand_followed = true, -- Ensure the node of the followed file is expanded
        leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        leave_files_open = false, -- `false` closes auto expanded files, such as with `:Neotree reveal`
    },
    group_dirs_and_files = true, -- when true, empty folders and files will be grouped together
    group_empty_dirs = true, -- when true, empty directories will be grouped together
    show_unloaded = true, -- show diagnostics from unloaded buffers
    refresh = {
        delay = 300, -- Time (in ms) to wait before updating diagnostics. Might resolve some issues with Neovim hanging.
        event = "vim_diagnostic_changed", -- Event to use for updating diagnostics (for example `"neo_tree_buffer_enter"`)
        -- Set to `false` or `"none"` to disable automatic refreshing
        max_items = 1000, -- The maximum number of diagnostic items to attempt processing
        -- Set to `false` for no maximum
    },
}

-- ==================================================================
-- signs
vim.fn.sign_define(
    "DiagnosticSignError",
    { text = "󰡅 ", texthl = "DiagnosticSignError" }
)
vim.fn.sign_define(
    "DiagnosticSignWarn",
    { text = " ", texthl = "DiagnosticSignWarn" }
)
vim.fn.sign_define(
    "DiagnosticSignInfo",
    { text = " ", texthl = "DiagnosticSignInfo" }
)
vim.fn.sign_define(
    "DiagnosticSignHint",
    { text = "󰌵 ", texthl = "DiagnosticSignHint" }
)

local diagnostics_signs = {
    symbols = {
        error = "󰡅 ",
        warn = " ",
        info = " ",
        hint = "󰌵 ",
    },
    highlights = {
        error = "DiagnosticSignError",
        warn = "DiagnosticSignWarn",
        info = "DiagnosticSignInfo",
        hint = "DiagnosticSignHint",
    }
}

local git_status = {
    symbols = {
        -- Change type
        added     = " ", -- NOTE: you can set any of these to an empty string to not show them
        deleted   = " ",
        modified  = " ",
        renamed   = " ",
        -- Status type
        untracked = " ",
        ignored   = " ",
        unstaged  = "󰄱 ",
        staged    = " ",
        -- conflict  = "󰦦 ",
        conflict  = " "
    },
    align = "right",
}

-- ==================================================================
-- custom find

local find_command = "find"
local find_args = function(cmd, path, search_term, args)
    -- local file = io.open("/home/paul/Desktop/lualog.txt", "w")
    -- io.output(file)
    -- io.write("find function\n")
    if cmd == "fd" then
        --maybe you want to force the filter to always include hidden files:
        table.insert(args, "--hidden")
        -- but no one ever wants to see .git files
        table.insert(args, "--exclude")
        table.insert(args, ".git")
        -- or node_modules
        table.insert(args, "--exclude")
        table.insert(args, "node_modules")
    elseif cmd == "find" then
        -- io.write("calling find for \"" .. tostring(search_term) .. "\" in " .. tostring(path) .. "\n")
        -- io.write("Default arguments: ")

        -- for k,v in pairs(args) do
        --     if k ~= 1 then
        --         io.write(" ")
        --     end
        --     io.write(tostring(v))
        -- end
        -- -- io.write("\n")
        -- io.flush()

        -- remove default arguments, they're in the wrong positions
        local defaultArgs = args
        args = {}

        -- enable the query optimizer
        table.insert(args, "-O3")

        -- where to search
        table.insert(args, tostring(path))

        -- can't remove stars because if search term contains stars
        -- it doesn't append stars automatically to be removed
        -- -- remove leading star from search_term
        -- search_term = string.gsub(search_term, "^*", "")
        -- -- remove trailing star from search term
        -- search_term = string.gsub(search_term, "*$", "")

        -- only search current directory for short search terms
        -- two stars are appended
        if search_term ~= nil and (string.len(search_term) - 2) < 3 then
            table.insert(args, "-maxdepth")
            table.insert(args, "0")
        end

        -- prune unwanted directories
        table.insert(args, "-type")
        table.insert(args, "d")

        table.insert(args, "(")

        -- ignore dotdirectories
        table.insert(args, "-name")
        table.insert(args, ".*")

        table.insert(args, "-o")
        table.insert(args, "-name")
        table.insert(args, ".git")

        table.insert(args, "-o")
        table.insert(args, "-name")
        table.insert(args, ".svn")

        table.insert(args, "-o")
        table.insert(args, "-name")
        table.insert(args, "node_modules")

        table.insert(args, "-o")
        table.insert(args, "-name")
        table.insert(args, "__pycache__")

        table.insert(args, ")")
        table.insert(args, "-prune")

        table.insert(args, "-o")

        if search_term == nil then
            -- fuzzy search
            -- args:
            -- /home/paul/ -type f -not -path */.* -regextype sed -regex .*..*b.*a.*s.*h.*r.*c.*
            table.insert(args, "-type")
            table.insert(args, "f")
            table.insert(args, "-regextype")
            table.insert(args, "sed")
            table.insert(args, "-regex")
            table.insert(args, tostring(defaultArgs[#defaultArgs]))
        else
            -- search case insensitive
            table.insert(args, "-iname")
            table.insert(args, search_term)
        end
        table.insert(args, "-print")

    end
    -- for k, v in pairs(args) do
    --     if k ~= 1 then
    --         io.write(" ")
    --     end
    --     io.write(tostring(v))
    -- end
    -- io.write("\n")
    -- io.close(file)
    -- io.output(io.stdout)
    return args
end


-- ==================================================================
-- Sort function for files
local sortFunc = function(a, b)
    -- keys of a and b
    -- not documented anywhere
    --   parent_path:           full, absolute path of parent directory
    --   type:                  "directory" (even for links), or "file"
    --   path:                  full, absolute path, no trailing slash
    --   name:                  file name
    --   is_link                bool is a symlink
    --   is_reveal_target       bool ??
    --   link_to                full, absolute path to link target
    --   loaded                 bool if file is loaded in editor
    --   id                     seems to be same as path
    --   children               type of a/b table, directories only
    --   exts                   file extension  ??, files only
    --   ext                    file extension  ??, filey only
    --   name_lcase             name, but lowercase, files only?

    -- workaround till https://github.com/nvim-neo-tree/neo-tree.nvim/issues/1226 is solved
    if a.name == nil then
        return false
    end

    if b.name == nil then
        return true
    end

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

local event_handlers = {
-- {
--   event = "before_render",
--   handler = function (state)
--     -- add something to the state that can be used by custom components
--   end
-- },
-- {
--   event = "file_opened",
--   handler = function(file_path)
--     --auto close
--     require("neo-tree.command").execute({ action = "close" })
--   end
-- },
-- {
--   event = "neo_tree_popup_input_ready",
--   handler = function(input)
--     -- enter input popup with normal mode by default.
--     vim.cmd("stopinsert");
--   end,
-- },
-- {
--   event = "file_opened",
--   handler = function(file_path)
--     --clear search after opening a file
--     require("neo-tree.sources.filesystem").reset_search()
--   end
-- },
-- {
--   event = "file_renamed",
--   handler = function(args)
--     -- fix references to file
--     print(args.source, " renamed to ", args.destination)
--   end
-- },
-- {
--   event = "file_moved",
--   handler = function(args)
--     -- fix references to file
--     print(args.source, " moved to ", args.destination)
--   end
-- },
-- {
--   event = "neo_tree_buffer_enter",
--   handler = function()
--     vim.cmd 'highlight! Cursor blend=100'
--   end
-- },
-- {
--   event = "neo_tree_buffer_leave",
--   handler = function()
--     vim.cmd 'highlight! Cursor guibg=#5f87af blend=0'
--   end
-- },
-- {
--   event = "neo_tree_window_before_open",
--   handler = function(args)
--     print("neo_tree_window_before_open", vim.inspect(args))
--   end
-- },
-- {
--   event = "neo_tree_window_after_open",
--   handler = function(args)
--     vim.cmd("wincmd =")
--   end
-- },
-- {
--   event = "neo_tree_window_before_close",
--   handler = function(args)
--     print("neo_tree_window_before_close", vim.inspect(args))
--   end
-- },
-- {
--   event = "neo_tree_window_after_close",
--   handler = function(args)
--     vim.cmd("wincmd =")
--   end
-- }
}

-- config options

local config = {
    -- If a user has a sources list it will replace this one.
    -- Only sources listed here will be loaded.
    -- You can also add an external source by adding it's name to this list.
    -- The name used here must be the same name you would use in a require() call.
    sources = sources,
    add_blank_line_at_top = false, -- Add a blank line at the top of the tree.
    auto_clean_after_session_restore = false, -- Automatically clean up broken neo-tree buffers saved in sessions
    close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
    -- popup_border_style is for input and confirmation dialogs.
    -- Configurtaion of floating window is done in the individual source sections.
    -- "NC" is a special style that works well with NormalNC set
    default_source = "filesystem", -- you can choose a specific source `last` here which indicates the last used source
    enable_diagnostics = true,
    enable_git_status = true,
    enable_modified_markers = true, -- Show markers for files with unsaved changes.
    enable_opened_markers = true,   -- Enable tracking of opened files. Required for `components.name.highlight_opened_files`
    enable_refresh_on_write = true, -- Refresh the tree when a file is written. Only used if `use_libuv_file_watcher` is false.
    git_status_async = true,
    -- These options are for people with VERY large git repos
    git_status_async_options = {
        batch_size = 1000, -- how many lines of git status results to process at a time
        batch_delay = 10,  -- delay in ms between batches. Spreads out the workload to let other processes run.
        max_lines = 10000, -- How many lines of git status results to process. Anything after this will be dropped.
        -- Anything before this will be used. The last items to be processed are the untracked files.
    },
    hide_root_node = false, -- Hide the root node.
    retain_hidden_root_indent = false, -- IF the root node is hidden, keep the indentation anyhow.
    -- This is needed if you use expanders because they render in the indent.
    log_level = "info", -- "trace", "debug", "info", "warn", "error", "fatal"
    log_to_file = false, -- true, false, "/path/to/file.log", use :NeoTreeLogs to show the file
    open_files_in_last_window = true,                                          -- false = open files in top left window
    open_files_do_not_replace_types = open_files_do_not_replace_types,    popup_border_style = "NC", -- "double", "none", "rounded", "shadow", "single" or "solid"
    resize_timer_interval = 500, -- in ms, needed for containers to redraw right aligned and faded content
    -- set to -1 to disable the resize timer entirely
    --                           -- NOTE: this will speed up to 50 ms for 1 second following a resize
    sort_case_insensitive = true, -- used when sorting files and directories in the tree
    sort_function = sortFunc , -- uses a custom function for sorting files and directories in the tree
    use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.
    use_default_mappings = false,
    -- source_selector provides clickable tabs to switch between sources.
    source_selector = {
        winbar = true, -- toggle to show selector on winbar
        statusline = false, -- toggle to show selector on statusline
        show_scrolled_off_parent_node = false, -- this will replace the tabs with the parent path
        -- of the top visible node when scrolled down.
        sources = sources_display,
        content_layout = "start", -- only with `tabs_layout` = "equal", "focus"
        --                start  : |/ 󰓩 bufname     \/...
        --                end    : |/     󰓩 bufname \/...
        --                center : |/   󰓩 bufname   \/...
        tabs_layout = "equal", -- start, end, center, equal, focus
        --             start  : |/  a  \/  b  \/  c  \            |
        --             end    : |            /  a  \/  b  \/  c  \|
        --             center : |      /  a  \/  b  \/  c  \      |
        --             equal  : |/    a    \/    b    \/    c    \|
        --             active : |/  focused tab    \/  b  \/  c  \|
        truncation_character = "…", -- character to use when truncating the tab label
        tabs_min_width = nil, -- nil | int: if int padding is added based on `content_layout`
        tabs_max_width = nil, -- this will truncate text even if `text_trunc_to_fit = false`
        padding = 0, -- can be int or table
        -- padding = { left = 2, right = 0 },
        -- separator = "▕", -- can be string or table, see below
        separator = { left = "▏", right= "▕" },
        -- separator = { left = "/", right = "\\", override = nil },     -- |/  a  \/  b  \/  c  \...
        -- separator = { left = "/", right = "\\", override = "right" }, -- |/  a  \  b  \  c  \...
        -- separator = { left = "/", right = "\\", override = "left" },  -- |/  a  /  b  /  c  /...
        -- separator = { left = "/", right = "\\", override = "active" },-- |/  a  / b:active \  c  \...
        -- separator = "|",                                              -- ||  a  |  b  |  c  |...
        separator_active = nil, -- set separators around the active tab. nil falls back to `source_selector.separator`
        show_separator_on_edge = false,
        --                       true  : |/    a    \/    b    \/    c    \|
        --                       false : |     a    \/    b    \/    c     |
        highlight_tab = "NeoTreeTabInactive",
        highlight_tab_active = "NeoTreeTabActive",
        highlight_background = "NeoTreeTabInactive",
        highlight_separator = "NeoTreeTabSeparatorInactive",
        highlight_separator_active = "NeoTreeTabSeparatorActive",
    },
    event_handlers = event_handlers,
    default_component_configs = {
        container = {
            enable_character_fade = true,
            width = "100%",
            right_padding = 0,
        },
        diagnostics = diagnostics_signs,
        indent = {
            indent_size = 2,
            padding = 1,
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
        },
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰉖",
            folder_empty_open = "󰷏",
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "",
            highlight = "NeoTreeFileIcon"
        },
        modified = {
            symbol = "",
            highlight = "NeoTreeModified",
        },
        name = {
            trailing_slash = true,
            highlight_opened_files = false, -- Requires `enable_opened_markers = true`.
            -- Take values in { false (no highlight), true (only loaded),
            -- "all" (both loaded and unloaded)}. For more information,
            -- see the `show_unloaded` config of the `buffers` source.
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
        },
        git_status = git_status,
        -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
        file_size = {
            enabled = true,
            required_width = 25, -- min width of window required to show this column
        },
        symlink_target = {
            enabled = true,
            required_width = 35,
        },
        last_modified = {
            enabled = true,
            required_width = 60, -- min width of window required to show this column
        },
        created = {
            enabled = false,
            required_width = 80, -- min width of window required to show this column
        },
        type = {
            enabled = true,
            required_width = 100, -- min width of window required to show this column
        },
    },
    renderers = {
        directory = {
            { "indent" },
            { "icon" },
            { "current_filter" },
            {
                "container",
                content = {
                    { "name", zindex = 10 },
                    {
                        "symlink_target",
                        zindex = 10,
                        highlight = "NeoTreeSymbolicLinkTarget",
                    },
                    { "clipboard", zindex = 10 },
                    { "diagnostics", errors_only = true, zindex = 20, align = "right", hide_when_expanded = true },
                    { "git_status", zindex = 10, align = "right", hide_when_expanded = true },
                    { "file_size", zindex = 10, align = "right" },
                    { "type", zindex = 10, align = "right" },
                    { "last_modified", zindex = 10, align = "right" },
                    { "created", zindex = 10, align = "right" },
                },
            },
        },
        file = {
            { "indent" },
            { "icon" },
            {
                "container",
                content = {
                    {
                        "name",
                        zindex = 10
                    },
                    {
                        "symlink_target",
                        zindex = 10,
                        highlight = "NeoTreeSymbolicLinkTarget",
                    },
                    { "clipboard", zindex = 10 },
                    { "bufnr", zindex = 10 },
                    { "modified", zindex = 20, align = "right" },
                    { "diagnostics",  zindex = 20, align = "right" },
                    { "git_status", zindex = 10, align = "right" },
                    { "file_size", zindex = 10, align = "right" },
                    { "type", zindex = 10, align = "right" },
                    { "last_modified", zindex = 10, align = "right" },
                    { "created", zindex = 10, align = "right" },
                },
            },
        },
        message = {
            { "indent", with_markers = false },
            { "name", highlight = "NeoTreeMessage" },
        },
        terminal = {
            { "indent" },
            { "icon" },
            { "name" },
            { "bufnr" }
        }
    },
    nesting_rules = {},
    -- Global custom commands that will be available in all sources (if not overridden in `opts[source_name].commands`)
    --
    -- You can then reference the custom command by adding a mapping to it:
    --    globally    -> `opts.window.mappings`
    --    locally     -> `opt[source_name].window.mappings` to make it source specific.
    --
    -- commands = {              |  window {                 |  filesystem {
    --   hello = function()      |    mappings = {           |    commands = {
    --     print("Hello world")  |      ["<C-c>"] = "hello"  |      hello = function()
    --   end                     |    }                      |        print("Hello world in filesystem")
    -- }                         |  }                        |      end
    --
    -- see `:h neo-tree-custom-commands-global`
    commands = {}, -- A list of functions

    window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
        -- possible options. These can also be functions that return these options.
        position = "float", -- left, right, top, bottom, float, current
        width = 70, -- applies to left and right positions
        height = 15, -- applies to top and bottom positions
        auto_expand_width = false, -- expand the window when file exceeds the window width. does not work with position = "float"
        popup = { -- settings that apply to float position only
            size = {
                height = "80%",
                width = "65%",
            },
            position = "15%", -- 50% means center it
            -- you can also specify border here, if you want a different setting from
            -- the global popup_border_style.
        },
        same_level = false, -- Create and paste/move files/directories on the same level as the directory under cursor (as opposed to within the directory under cursor).
        insert_as = "sibling", -- Affects how nodes get inserted into the tree during creation/pasting/moving of files if the node under the cursor is a directory:
        -- "child":   Insert nodes as children of the directory under cursor.
        -- "sibling": Insert nodes  as siblings of the directory under cursor.
        -- Mappings for tree window. See `:h neo-tree-mappings` for a list of built-in commands.
        -- You can also create your own commands by providing a function instead of a string.
        mapping_options = window_mapping_options,
        mappings = window_mapping_mappings,
    },
    filesystem = {
        window = filesystem_window,
        async_directory_scan = "auto", -- "auto"   means refreshes are async, but it's synchronous when called from the Neotree commands.
        -- "always" means directory scans are always async.
        -- "never"  means directory scans are never async.
        scan_mode = "shallow", -- "shallow": Don't scan into directories to detect possible empty directory a priori
        -- "deep": Scan into directories to detect empty or grouped empty directories a priori.
        bind_to_cwd = true, -- true creates a 2-way binding between vim's cwd and neo-tree's root
        cwd_target = {
            sidebar = "tab",   -- sidebar is when position = left or right
            current = "window" -- current is when position = current
        },
        check_gitignore_in_search = true, -- check gitignore status for files/directories when searching
        -- setting this to false will speed up searches, but gitignored
        -- items won't be marked if they are visible.
        -- The renderer section provides the renderers that will be used to render the tree.
        --   The first level is the node type.
        --   For each node type, you can specify a list of components to render.
        --       Components are rendered in the order they are specified.
        --         The first field in each component is the name of the function to call.
        --         The rest of the fields are passed to the function as the "config" argument.
        filtered_items = {
            visible = true, -- when true, they will just be displayed differently than normal items
            force_visible_in_empty_folder = true, -- when true, hidden files will be shown if the root folder is otherwise empty
            show_hidden_count = true, -- when true, the number of hidden items in each folder will be shown as the last entry
            hide_dotfiles = true,
            hide_gitignored = false,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
                ".DS_Store",
                "thumbs.db"
                --"node_modules",
            },
            hide_by_pattern = { -- uses glob style patterns
                --"*.meta",
                --"*/src/*/tsconfig.json"
            },
            always_show = { -- remains visible even if other settings would normally hide it
                --".gitignored",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                --".DS_Store",
                --"thumbs.db"
            },
            never_show_by_pattern = { -- uses glob style patterns
                --".null-ls_*",
            },
        },
        find_by_full_path_words = false,  -- `false` means it only searches the tail of a path.
        -- `true` will change the filter into a full path
        -- search with space as an implicit ".*", so
        -- `fi init`
        -- will match: `./sources/filesystem/init.lua
        find_command = find_command, -- this is determined automatically, you probably don't need to set it
        --find_args = {  -- you can specify extra args to pass to the find command.
        --  fd = {
        --  "--exclude", ".git",
        --  "--exclude",  "node_modules"
        --  }
        --},
        ---- or use a function instead of list of strings
        find_args = find_args,
        group_empty_dirs = false, -- when true, empty folders will be grouped together
        search_limit = 50, -- max number of search results when using filters
        follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
        -- in whatever position is specified in window.position
        -- "open_current",-- netrw disabled, opening a directory opens within the
        -- window like netrw would, regardless of window.position
        -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
        use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
        -- instead of relying on nvim autocmd events.
    },
    buffers = {
        bind_to_cwd = true,
        follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --              -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        group_empty_dirs = true,  -- when true, empty directories will be grouped together
        show_unloaded = false,    -- When working with sessions, for example, restored but unfocused buffers
        -- are mark as "unloaded". Turn this on to view these unloaded buffer.
        terminals_first = true,  -- when true, terminals will be listed before file buffers
        window = {
            mappings = buffers_window_mappings,
        },
    },
    git_status = {
        window = {
            mappings = gitstatus_window_mappings,
        },
    },
    document_symbols = {
        follow_cursor = true,
        client_filters = "first",
        renderers = {
            root = {
                {"indent"},
                {"icon", default="C" },
                {"name", zindex = 10},
            },
            symbol = {
                {"indent", with_expanders = true},
                {"kind_icon", default="?" },
                {"container", content = {
                        {"name", zindex = 10},
                        {"kind_name", zindex = 20, align = "right"},
                    }
                }
            },
        },
        window = {
            mappings = documents_symbols_window_mappings,
        },
        custom_kinds = {
            -- define custom kinds here (also remember to add icon and hl group to kinds)
            -- ccls
            -- [252] = 'TypeAlias',
            -- [253] = 'Parameter',
            -- [254] = 'StaticMethod',
            -- [255] = 'Macro',
        },
        kinds = {
            Unknown = { icon = "?", hl = "" },
            Root = { icon = "", hl = "NeoTreeRootName" },
            File = { icon = "󰈙", hl = "Tag" },
            Module = { icon = "", hl = "Exception" },
            Namespace = { icon = "󰌗", hl = "Include" },
            Package = { icon = "󰏖", hl = "Label" },
            Class = { icon = "󰌗", hl = "Include" },
            Method = { icon = "", hl = "Function" },
            Property = { icon = "󰆧", hl = "@property" },
            Field = { icon = "", hl = "@field" },
            Constructor = { icon = "", hl = "@constructor" },
            Enum = { icon = "󰒻", hl = "@number" },
            Interface = { icon = "", hl = "Type" },
            Function = { icon = "󰊕", hl = "Function" },
            Variable = { icon = "", hl = "@variable" },
            Constant = { icon = "", hl = "Constant" },
            String = { icon = "󰀬", hl = "String" },
            Number = { icon = "󰎠", hl = "Number" },
            Boolean = { icon = "", hl = "Boolean" },
            Array = { icon = "󰅪", hl = "Type" },
            Object = { icon = "󰅩", hl = "Type" },
            Key = { icon = "󰌋", hl = "" },
            Null = { icon = "", hl = "Constant" },
            EnumMember = { icon = "", hl = "Number" },
            Struct = { icon = "󰌗", hl = "Type" },
            Event = { icon = "", hl = "Constant" },
            Operator = { icon = "󰆕", hl = "Operator" },
            TypeParameter = { icon = "󰊄", hl = "Type" },

            -- ccls
            -- TypeAlias = { icon = ' ', hl = 'Type' },
            -- Parameter = { icon = ' ', hl = '@parameter' },
            -- StaticMethod = { icon = '󰠄 ', hl = 'Function' },
            -- Macro = { icon = ' ', hl = 'Macro' },
        }
    },
    diagnostics = diagnostics,
    example = {
        renderers = {
            custom = {
                {"indent"},
                {"icon", default="C" },
                {"custom"},
                {"name"}
            }
        },
        window = {
            mappings = {
                ["<cr>"] = "toggle_node",
                ["<C-e>"] = "example_command",
                ["d"] = "show_debug_info",
            },
        },
    },
}

-- ==================================================================
-- optional modules

-- ==================================================================
-- Setup


nt.setup(config)
