-- https://github.com/Weissle/persistent-breakpoints.nvim

local persistent_bp = require('persistent-breakpoints')

local options = {
    save_dir = vim.fn.stdpath('cache') .. '/breakpoints',
    -- when to load the breakpoints? "BufReadPost" is recommanded.
    load_breakpoints_event = { 'BufReadPost' },
    -- record the performance of different function. run :lua require('persistent-breakpoints.api').print_perf_data() to see the result.
    perf_record = false,
    -- perform callback when loading a persisted breakpoint
    --- @param opts DAPBreakpointOptions options used to create the breakpoint ({condition, logMessage, hitCondition})
    --- @param buf_id integer the buffer the breakpoint was set on
    --- @param line integer the line the breakpoint was set on
    on_load_breakpoint = nil,
}

persistent_bp.setup(options)

-- add autocommand on file save
vim.api.nvim_exec(
        [[
    augroup persistent
        autocmd!
        autocmd BufWritePost * lua require('persistent-breakpoints.api').store_breakpoints()
    augroup END
    ]],
    true
)
