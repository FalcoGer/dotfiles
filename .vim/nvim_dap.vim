" https://github.com/mfussenegger/nvim-dap
" help dap.txt

" commands

command! -nargs=0 Run           :lua require('dap').continue()
command! -nargs=0 BreakPoint    :lua require('dap').toggle_breakpoint()
command! -nargs=0 StepOver      :lua require('dap').step_over()
command! -nargs=0 StepInto      :lua require('dap').step_into()
command! -nargs=0 StepOut       :lua require('dap').step_out()
command! -nargs=0 REPL          :lua require('dap').repl.open()
command! -nargs=0 RunLast       :lua require('dap').run_last()

" Highlights for sign config

highlight BreakpointText ctermfg=9 cterm=bold guifg=#FF0000 gui=bold
highlight link BreakpointNum BreakpointText
highlight BreakPointLine ctermbg=52 guibg=#5f0000
highlight BreakpointCondText ctermfg=5 cterm=bold guifg=#800080 gui=bold
highlight link BreakPointCondNum BreakpointCondText
highlight BreakPointCondLine ctermbg=53 guibg=#5f0000
highlight DapLogPointText ctermfg=12 cterm=bold guifg=#0000ff gui=bold
highlight link DapLogPointNum DapLogPointText
highlight DapLogPointLine ctermbg=17 guibg=#00005f
highlight DapStoppedText ctermbg=11 cterm=bold guibg=#ffff00 gui=bold
highlight link DapStoppedNum DapStoppedText
highlight DapStoppedLine ctermbg=23 cterm=underline guibg=#005f5f guisp=#875f00 gui=underdouble
highlight DapBreapointRejectedText ctermbg=9 ctermfg=11 cterm=bold,undercurl guifg=#ffff00 guisp=#FF0000 gui=bold,undercurl

lua <<EOF

    -- Key mappings

    vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
    vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
    vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
    vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
    vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
    vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
    vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
    vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
    vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
      require('dap.ui.widgets').hover()
    end)
    vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
      require('dap.ui.widgets').preview()
    end)
    vim.keymap.set('n', '<Leader>df', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.frames)
    end)
    vim.keymap.set('n', '<Leader>ds', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.scopes)
    end)

    -- ============================================================
    -- Sign configs

    vim.fn.sign_define('DapBreakpoint', {text='', texthl='BreakpointText', linehl='BreakPointLine', numhl='BreakpointNum'})
    vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='BreakPointCondText', linehl='BreakPointCondLine', numhl='BreakpointNum'})
    vim.fn.sign_define('DapLogPoint', {text='', texthl='DapLogPointText', linehl='DapLogPointLine', numhl='DapLogPointNum'})
    vim.fn.sign_define('DapStopped', {text='', texthl='DapStoppedText', linehl='DapStoppedLine', numhl='DapStoppedNum'})
    vim.fn.sign_define('DapBreakpointRejected', {text='', texthl='DapBreakpointRejectedText', linehl='', numhl=''})

    -- ============================================================
    -- Adapter confguration
    -- :help dap-adapter
    -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#contents

    -- ------------------------------------------------------------
    -- GDB, requires gdb 14.0 or higher
    local dap = require("dap")

    dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "-i", "dap" }
    }

    -- debugee configuration
    dap.configurations.c =
    {
        {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}",
        },
    }
    dap.configurations.cpp = dap.configurations.c
    dap.configurations.rust = dap.configurations.c


EOF

