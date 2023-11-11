-- https://github.com/rcarriga/nvim-dap-ui
-- :h dapui.setup()

local dap = require('dap')
local dapui = require("dapui")

-- setup
local options =
{
    controls = {
        element = "repl",
        enabled = true,
        icons = {
            disconnect = "",
            pause = "",
            play = "",
            run_last = "",
            step_back = "",
            step_into = "",
            step_out = "",
            step_over = "",
            terminate = ""
        }
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
        border = "single",
        mappings =
        {
            close = { "q", "<Esc>" }
        }
    },
    force_buffers = true,
    icons = {
        collapsed = "",
        current_frame = "",
        expanded = ""
    },
    layouts = {
        {
            elements = {
                {
                id = "scopes",
                size = 0.30
                },
                {
                    id = "breakpoints",
                    size = 0.20
                },
                {
                    id = "stacks",
                    size = 0.25
                },
                {
                    id = "watches",
                    size = 0.25
                },
            },
            position = "left",
            size = 40
        },
        {
            elements = {
                {
                    id = "repl",
                    size = 0.5
                },
                {
                    id = "console",
                    size = 0.5
                },
            },
            position = "bottom",
            size = 10
        },
    },
    mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t"
    },
    render = {
        indent = 1,
        max_value_lines = 100
    }
}


dapui.setup(options)

-- keybinds
vim.keymap.set('n', '<Leader>du', function() require('dapui').toggle() end)

vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
    require('dapui').eval()
end)
vim.keymap.set({'n', 'v'}, '<M-k>', function()
    require('dapui').eval()
end)

-- commands
vim.cmd([[command! -nargs=0 DapUI lua require('dapui').toggle()]])
vim.cmd([[command! -nargs=0 DapUIOpen lua require('dapui').open()]])
vim.cmd([[command! -nargs=0 DapUIClose lua require('dapui').close()]])

-- callbacks for auto open/close
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
