-- https://github.com/rcarriga/nvim-notify

local notify = require('notify')


-- keymaps
vim.api.nvim_set_keymap('n', '<Leader>n', ':Telescope notify<CR>', { noremap = true, silent = true })

-- highlights

--[[
local highlights = {
    NotifyERRORBorder = { guifg = "#8A1F1F" },
    NotifyWARNBorder = { guifg = "#79491D" },
    NotifyINFOBorder = { guifg = "#4F6752" },
    NotifyDEBUGBorder = { guifg = "#8B8B8B" },
    NotifyTRACEBorder = { guifg = "#4F3552" },
    NotifyERRORIcon = { guifg = "#F70067" },
    NotifyWARNIcon = { guifg = "#F79000" },
    NotifyINFOIcon = { guifg = "#A9FF68" },
    NotifyDEBUGIcon = { guifg = "#8B8B8B" },
    NotifyTRACEIcon = { guifg = "#D484FF" },
    NotifyERRORTitle = { guifg = "#F70067" },
    NotifyWARNTitle = { guifg = "#F79000" },
    NotifyINFOTitle = { guifg = "#A9FF68" },
    NotifyDEBUGTitle = { guifg = "#8B8B8B" },
    NotifyTRACETitle = { guifg = "#D484FF" }
}

for group, attributes in pairs(highlights) do
    local command = "highlight " .. group
    for attr, value in pairs(attributes) do
        command = command .. " " .. attr .. "=" .. value
    end
    vim.api.nvim_command(command)
end
--]]

vim.api.nvim_command("highlight link NotifyERRORBorder DiagnosticError")
vim.api.nvim_command("highlight link NotifyERRORIcon   DiagnosticError")
vim.api.nvim_command("highlight link NotifyERRORTitle  DiagnosticError")
vim.api.nvim_command("highlight link NotifyERRORBody   Normal")

vim.api.nvim_command("highlight link NotifyWARNBorder  DiagnosticWarn")
vim.api.nvim_command("highlight link NotifyWARNIcon    DiagnosticWarn")
vim.api.nvim_command("highlight link NotifyWARNTitle   DiagnosticWarn")
vim.api.nvim_command("highlight link NotifyWARNBody    Normal")

vim.api.nvim_command("highlight link NotifyINFOBorder  DiagnosticInfo")
vim.api.nvim_command("highlight link NotifyINFOIcon    DiagnosticInfo")
vim.api.nvim_command("highlight link NotifyINFOTitle   DiagnosticInfo")
vim.api.nvim_command("highlight link NotifyINFOBody    Normal")

vim.api.nvim_command("highlight link NotifyDEBUGBorder DiagnosticHint")
vim.api.nvim_command("highlight link NotifyDEBUGIcon   DiagnosticHint")
vim.api.nvim_command("highlight link NotifyDEBUGTitle  DiagnosticHint")
vim.api.nvim_command("highlight link NotifyDEBUGBody   Normal")

vim.api.nvim_command("highlight link NotifyTRACEBorder DiagnosticOk")
vim.api.nvim_command("highlight link NotifyTRACEIcon   DiagnosticOk")
vim.api.nvim_command("highlight link NotifyTRACETitle  DiagnosticOk")
vim.api.nvim_command("highlight link NotifyTRACEBody   Normal")

-- options

local options = {
    background_colour = "NotifyBackground",
    fps = 30,
    icons = {
        TRACE = " ",
        DEBUG = " ",
        INFO = " ",
        WARN = " ",
        ERROR = "󰡅 ",
    },
    level = 1,
    minimum_width = 60,
    render = "default",
    stages = "fade_in_slide_out",
    time_formats = {
        notification = "%T",
        notification_history = "%FT%T"
    },
    timeout = 10000,
    top_down = true,
}

notify.setup(options);
