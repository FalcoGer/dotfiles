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

highlight BreakPointText ctermfg=9 cterm=bold guifg=#FF0000 gui=bold
highlight BreakPointNum  ctermbg=9 cterm=bold guibg=#FF0000 gui=bold
highlight BreakPointLine ctermbg=52 guisp=#5F0000 gui=underdashed

highlight BreakPointCondText ctermfg=5 cterm=bold guifg=#800080 gui=bold
highlight BreakPointCondNum  ctermbg=5 cterm=bold guibg=#800080 gui=bold
highlight BreakPointCondLine ctermbg=91 guisp=#8700AF gui=underdashed

highlight DapLogPointText ctermfg=12 cterm=bold guifg=#0000FF gui=bold
highlight DapLogPointNum  ctermbg=12 cterm=bold guibg=#0000FF
highlight DapLogPointLine ctermbg=17 guisp=#0000FF gui=underdashed

highlight DapStoppedText ctermfg=9 ctermbg=3 cterm=bold guifg=#FF0000 guibg=#808000 gui=bold
highlight link DapStoppedNum DapStoppedText
highlight DapStoppedLine ctermbg=23 cterm=underline guisp=#875F00 gui=underline

highlight DapBreaPointRejectedText ctermbg=9 ctermfg=11 cterm=bold,undercurl guifg=#FFFF00 guisp=#FF0000 gui=bold,undercurl

lua <<EOF
    -- behavior
    local dap = require('dap')

    -- :help dap.set_exception_breakpoints()
    -- dap.defaults.fallback.exception_breakpoints = {'raised', 'uncaught'}
    dap.defaults.fallback.exception_breakpoints = 'default'
    -- Key mappings

    vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
    vim.keymap.set('n', '<F6>', function() require('dap').step_into() end)
    vim.keymap.set('n', '<F7>', function() require('dap').step_over() end)
    vim.keymap.set('n', '<F8>', function() require('dap').step_out() end)
    vim.keymap.set('n', '<F9>', function() require('dap').up() end)
    vim.keymap.set('n', '<F10>', function() require('dap').down() end)
    vim.keymap.set('n', '<Leader>lb', function() require('dap').list_breakpoints(0) end)
    vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
    vim.keymap.set('n', '<Leader>cb', function() require('dap').toggle_breakpoint(vim.fn.input('Breakpoint condtion:')) end)
    vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
    -- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)

    if not (vim.g.user_loaded_nvim_dap_ui ~= nil) then
        -- use dap hover only when dap_ui not loaded
        vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
            require('dap.ui.widgets').hover()
        end)
    end


    --vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
    --  require('dap.ui.widgets').preview()
    --end)
    vim.keymap.set('n', '<Leader>df', function()
      local widgets = require('dap.ui.widgets')
      local sidebar = widgets.sidebar(widgets.frames)
      sidebar.open()
    end)
    vim.keymap.set('n', '<Leader>ds', function()
      local widgets = require('dap.ui.widgets')
      local sidebar = widgets.sidebar(widgets.scopes)
      sidebar.open()
    end)
    vim.keymap.set('n', '<Leader>dt', function()
      local widgets = require('dap.ui.widgets')
      local sidebar = widgets.sidebar(widgets.threads)
      sidebar.open()
    end)
    vim.keymap.set('n', '<Leader>dd', function()
      local widgets = require('dap.ui.widgets')
      local sidebar = widgets.sidebar(widgets.sessions)
      sidebar.open()
    end)
    vim.keymap.set('n', '<Leader>de', function()
      local widgets = require('dap.ui.widgets')
      local sidebar = widgets.sidebar(widgets.expression)
      sidebar.open()
    end)


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

    -- local env = {"PWNDBG_DISABLE_COLORS=1"}
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

