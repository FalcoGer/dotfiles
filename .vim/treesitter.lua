local ts_config = require'nvim-treesitter.configs'

-- see https://github.com/nvim-treesitter/nvim-treesitter#available-modules
-- see :help treesitter
local options = {
    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = true,
    },
    indent = {
        -- experimental
        -- indent based on = operator
        enable = false,
    },
    incremental_selection = {
        enable = false,
        keymaps = {
            init_selection = "gnn", -- set to `false` to disable one of the mappings
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    matchup = {
        enabled = true,               -- enable matchup integration
        disable = {},                 -- list of languages as strings for which matchup is disabled
        disable_virtual_text = false, -- disable virtual text for languages without explicit end markers (python)
        -- include_match_words = "",  -- match these regular expressions that are not detected by treesitter (like /* */)
    },
}

ts_config.setup(options)
