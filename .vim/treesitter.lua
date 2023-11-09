local ts_config = require 'nvim-treesitter.configs'

-- see https://github.com/nvim-treesitter/nvim-treesitter#available-modules
-- see :help treesitter
local options = {
    -- list of names or "all", for which parsers should be automatically
    -- installed when the plugin is loaded
    ensure_installed = {
        "vim", "bash", "c", "cpp", "cmake", "diff", "lua", "make", "markdown", "python", "yaml",
        "c_sharp", "css", "dockerfile", "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore", "html",
        "http", "ini", "javascript", "json", "json5", "latex", "markdown_inline", "meson", "ninja", "passwd", "regex",
        "sql", "vimdoc"
    },
    -- install synchronously (only ensure_installed)
    sync_install = true,
    -- automatically install missing parsers when entering buffer
    auto_install = true,
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
        enable = true,
        keymaps = {
            init_selection = "gti", -- set to `false` to disable one of the mappings
            node_incremental = "gtn",
            scope_incremental = "gts",
            node_decremental = "gtp",
        },
    },
    matchup = {
        enabled = true,               -- enable matchup integration
        disable = { "text" },         -- list of languages as strings for which matchup is disabled
        disable_virtual_text = false, -- disable virtual text for languages without explicit end markers (python)
        -- include_match_words = "",  -- match these regular expressions that are not detected by treesitter (like /* */)
    },
    autotag = {
        enable = true,
        enable_rename = true,
        enable_close = true,
        enable_close_on_slash = true,
        filetypes = {
            'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx',
            'rescript', 'xml', 'php', 'markdown', 'astro', 'glimmer', 'handlebars', 'hbs',
        },
    },
}

ts_config.setup(options)
