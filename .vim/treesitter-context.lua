local tsc = require 'treesitter-context'
local options = {
    enable = true,
    max_lines = 6,           -- how many lines are in the context at maximum
    min_window_height = 12,  -- how big the window is at minimum for the context to show
    line_numbers = true,     -- if line numbers are to be shown in the context
    multiline_threshold = 5, -- Maximum number of lines to collapse for a single context line
    trim_scope = 'outer',    -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode = 'cursor',         -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-' or nil.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
    zindex = 20,     -- The Z-index of the context window
    on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

tsc.setup(options)

-- vim.keymap.set("n", "<M-Up>",
--     function()
--         require("treesitter-context").go_to_context()
--     end,
--     { silent = true }
-- )

vim.keymap.set("n", "<S-c>", ':TSContextToggle<CR>', { silent = true })

-- Highlights (Default):
--   TreesitterContext (NormalFloat)
--   TreesitterContextLineNumber (LineNr)
--   TreesitterContextSeparator (FloatBoarder)
--   TreesitterContextBottom (NONE)

vim.cmd [[highlight TreesitterContextBottom cterm=underdouble gui=underdouble guisp=Grey]]
