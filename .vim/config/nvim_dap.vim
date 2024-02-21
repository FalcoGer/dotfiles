" https://github.com/mfussenegger/nvim-dap
" help dap.txt

" commands
" Dap provides commands starting with Dap

" command! -nargs=0 Run           :lua require('dap').continue()
" command! -nargs=0 BreakPoint    :lua require('dap').toggle_breakpoint()
" command! -nargs=0 StepOver      :lua require('dap').step_over()
" command! -nargs=0 StepInto      :lua require('dap').step_into()
" command! -nargs=0 StepOut       :lua require('dap').step_out()
" command! -nargs=0 REPL          :lua require('dap').repl.open()
command! -nargs=0 DapRunLast                :lua require('dap').run_last()
command! -nargs=? DapPause                  :lua require('dap').pause(<f-args>)
command! -nargs=0 DapStepBack               :lua require('dap').step_back()
command! -nargs=0 DapStepIntoInstruction    :lua require('dap').step_into('instruction')
command! -nargs=0 DapStepOverInstruction    :lua require('dap').step_over('instruction')
command! -nargs=0 DapStepOutInstruction     :lua require('dap').step_out('instruction')
command! -nargs=0 DapStepBackInstruction    :lua require('dap').step_back('instruction')
command! -nargs=0 DapReverseContinue        :lua require('dap').reverse_continue()
command! -nargs=0 DapUp                     :lua require('dap').up()
command! -nargs=0 DapDown                   :lua require('dap').down()
command! -nargs=? DapGotoLine               :lua require('dap').goto_(<f-args>)
command! -nargs=0 DapFocusFrame             :lua require('dap').focus_frame()
command! -nargs=0 DapRunToCursor            :lua require('dap').run_to_cursor()
command! -nargs=0 DapListBreakpoints        :lua require('dap').list_breakpoints(0)
command! -nargs=0 DapClearBreakpoints       :lua require('dap').clear_breakpoints()

" Highlights for sign config
" highlight bg for text and number from .vimrc, SignColumn background
highlight BreakPointText ctermfg=9 ctermbg=234 cterm=bold guifg=#FF0000 guibg=#1C1C1C gui=bold
highlight BreakPointNum  ctermbg=9 cterm=bold guibg=#FF0000 gui=bold
highlight BreakPointLine ctermbg=52 guisp=#5F0000 gui=underdashed

highlight BreakPointCondText ctermfg=5 ctermbg=234 cterm=bold guifg=#800080 guibg=#1C1C1C gui=bold
highlight BreakPointCondNum  ctermbg=5 cterm=bold guibg=#800080 gui=bold
highlight BreakPointCondLine ctermbg=91 guisp=#8700AF gui=underdashed

highlight DapLogPointText ctermfg=12 ctermbg=234 cterm=bold guifg=#0000FF guibg=#1C1C1C gui=bold
highlight DapLogPointNum  ctermbg=12 cterm=bold guibg=#0000FF gui=bold
highlight DapLogPointLine ctermbg=17 guisp=#0000FF gui=underdashed

highlight DapStoppedText ctermfg=9 ctermbg=24 cterm=bold guifg=#FF0000 guibg=#005F78 gui=bold
highlight link DapStoppedNum DapStoppedText
highlight DapStoppedLine ctermbg=24 cterm=underline guisp=#005F78 gui=underdouble

highlight DapBreaPointRejectedText ctermfg=11 ctermbg=9 cterm=bold,undercurl guifg=#FFFF00 guisp=#FF0000 gui=bold,undercurl

lua <<EOF
    -- behavior
    local dap = require('dap')

    local list_breakpoints = function() require('dap').list_breakpoints(0) end
    local create_conditional_bp = function() require('dap').toggle_breakpoint(vim.fn.input('Breakpoint condtion:')) end
    local create_log_point = function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end

    -- :help dap.set_exception_breakpoints()
    -- dap.defaults.fallback.exception_breakpoints = {'raised', 'uncaught'}
    dap.defaults.fallback.exception_breakpoints = 'default'
    -- Key mappings

    vim.keymap.set('n', '<F5>', require('dap').continue, { silent = true, desc = "DAP - Continue", noremap = true })
    vim.keymap.set('n', '<F6>', require('dap').step_into, { silent = true, desc = "DAP - Step into", noremap = true })
    vim.keymap.set('n', '<F7>', require('dap').step_over, { silent = true, desc = "DAP - Step over", noremap = true })
    vim.keymap.set('n', '<F8>', require('dap').step_out, { silent = true, desc = "DAP - Step out", noremap = true })
    vim.keymap.set('n', '<F9>', require('dap').up, { silent = true, desc = "DAP - Stackframe up", noremap = true })
    vim.keymap.set('n', '<F10>', require('dap').down, { silent = true, desc = "DAP - Stackframe down", noremap = true })
    vim.keymap.set('n', '<Leader>lb', list_breakpoints, { silent = true, desc = "DAP - List breakpoints" })
    vim.keymap.set('n', '<Leader>b', require('dap').toggle_breakpoint, { silent = true, desc = "DAP - Toggle breakpoint", noremap = true })
    vim.keymap.set('n', '<Leader>cb', create_conditional_bp, { silent = true, desc = "DAP - Create conditional breakpoint", noremap = true })
    vim.keymap.set('n', '<Leader>lp', create_log_point, { silent = true, desc = "DAP - Create log point", noremap = true })
    vim.keymap.set('n', '<Leader>dr', require('dap').repl.open, { silent = true, desc = "DAP - REPL", noremap = true })
    -- vim.keymap.set('n', '<Leader>dl', require('dap').run_last, { silent = true, desc = "DAP - Run last", noremap = true })

    if not (vim.g.user_loaded_nvim_dap_ui ~= nil) then
        -- use dap hover only when dap_ui not loaded
        vim.keymap.set({'n', 'v'}, '<Leader>dh', require('dap.ui.widgets').hover(), { silent = true, desc = "DAP - Hover widget", noremap = true })
    end


    --vim.keymap.set({'n', 'v'}, '<Leader>dp', require('dap.ui.widgets').preview(), { silent = true, desc = "DAP - Preview Widget", noremap = true })
    local sidebar_frames = function()
      local widgets = require('dap.ui.widgets')
      local sidebar = widgets.sidebar(widgets.frames)
      sidebar.open()
    end
    vim.keymap.set('n', '<Leader>df', sidebar_frames, { silent = true, desc = "DAP - Sidebar Widget - Frames", noremap = true })

    local sidebar_scopes = function()
      local widgets = require('dap.ui.widgets')
      local sidebar = widgets.sidebar(widgets.scopes)
      sidebar.open()
    end
    vim.keymap.set('n', '<Leader>ds', sidebar_scopes, { silent = true, desc = "DAP - Sidebar Widget - Scopes", noremap = true })

    local sidebar_threads = function()
      local widgets = require('dap.ui.widgets')
      local sidebar = widgets.sidebar(widgets.threads)
      sidebar.open()
    end
    vim.keymap.set('n', '<Leader>dt', sidebar_threads, { silent = true, desc = "DAP - Sidebar Widget - Threads", noremap = true })

    local sidebar_sessions = function()
      local widgets = require('dap.ui.widgets')
      local sidebar = widgets.sidebar(widgets.sessions)
      sidebar.open()
    end
    vim.keymap.set('n', '<Leader>dd', sidebar_sessions, { silent = true, desc = "DAP - Sidebar Widget - Sessions", noremap = true })

    local sidebar_expressions = function()
      local widgets = require('dap.ui.widgets')
      local sidebar = widgets.sidebar(widgets.expression)
      sidebar.open()
    end
    vim.keymap.set('n', '<Leader>de', sidebar_expressions, { silent = true, desc = "DAP - Sidebar Widget - Expressions", noremap = true })


    -- ==============================================================
    -- Sign configs

    vim.fn.sign_define('DapBreakpoint', {text='', texthl='BreakpointText', linehl='BreakPointLine', numhl='BreakpointNum'})
    vim.fn.sign_define('DapBreakpointCondition', {text='', texthl='BreakPointCondText', linehl='BreakPointCondLine', numhl='BreakPointCondNum'})
    vim.fn.sign_define('DapLogPoint', {text='', texthl='DapLogPointText', linehl='DapLogPointLine', numhl='DapLogPointNum'})
    vim.fn.sign_define('DapStopped', {text='', texthl='DapStoppedText', linehl='DapStoppedLine', numhl='DapStoppedNum'})
    vim.fn.sign_define('DapBreakpointRejected', {text='', texthl='DapBreakpointRejectedText', linehl='', numhl=''})

    -- ==============================================================
    -- Adapter confguration
    -- :help dap-adapter
    -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#contents

    -- --------------------------------------------------------------
    -- GDB, requires gdb 14.0 or higher

    -- Workaround for https://github.com/mfussenegger/nvim-dap/issues/1088
    -- requires posix (sudo luarocks --lua-version=5.1 install luaposix)
    local posix = require('posix')
    posix.setenv("PWNDBG_DISABLE_COLORS", "1")

    -- local env = {PWNDBG_DISABLE_COLORS = "1"}
    dap.adapters.gdb = {
        type = "executable",
        command = "/usr/local/bin/gdb",
        args = { "--interpreter", "dap" },
        options = {
        --    env = env,
        },
    }

    -- debugee configuration
    dap.configurations.c = {
        {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        -- No docs. Requires debugger to support forwarding
        -- https://github.com/mfussenegger/nvim-dap/issues/1091
        -- https://github.com/mfussenegger/nvim-dap/issues/455
        args = function()
            return vim.fn.input('Arguments: ', '')
        end,
        -- env also no docs
        cwd = "${workspaceFolder}",
        },
    }

    if vim.g['user_loaded_nvim_dap_repl_highlight'] ~= nil then
        -- Needs TS grammar for gdb first: https://github.com/nvim-treesitter/nvim-treesitter/issues/5675
        -- dap.configurations.c[1]['repl_lang'] = 'gdb'
    end

    dap.configurations.cpp = dap.configurations.c
    dap.configurations.rust = dap.configurations.c

    -- --------------------------------------------------------------
    -- PHP
    dap.adapters.php = {
        type = 'executable',
        command = 'node',
        args = { '/home/paul/repositories/vim/vscode-php-debug/out/phpDebug.js' }
    }

    dap.configurations.php =
    {
        {
            type = 'php',
            request = 'launch',
            name = 'Listen for Xdebug',
            port = 9003
        }
    }

    -- --------------------------------------------------------------
    -- LUA
    dap.adapters["local-lua"] = {
      type = "executable",
      command = "node",
      args = {
        "/home/paul/repositories/vim/local-lua-debugger-vscode/extension/debugAdapter.js"
      },
      enrich_config = function(config, on_config)
        if not config["extensionPath"] then
          local c = vim.deepcopy(config)
          -- 💀 If this is missing or wrong you'll see
          -- "module 'lldebugger' not found" errors in the dap-repl when trying to launch a debug session
          c.extensionPath = "/home/paul/repositories/vim/local-lua-debugger-vscode/"
          on_config(c)
        else
          on_config(config)
        end
      end,
    }

    dap.configurations.lua =
    {
        {
            name = 'Current file (local-lua-dbg, lua)',
            type = 'local-lua',
            request = 'launch',
            cwd = '${workspaceFolder}',
            program =
            {
                lua = '/usr/bin/lua',
                file = '${file}',
            },
            args = {},
        },
    }


EOF

