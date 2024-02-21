-- https://github.com/rcarriga/nvim-notify

local notify = require('notify')


-- keymaps
vim.api.nvim_set_keymap('n', '<Leader>n', ':Telescope notify<CR>', { noremap = true, silent = true })


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
    -- one of "default", "minimal", "simple", "compact"
    render = "default",
    -- one of "fade_in_slide_out", "fade", "slide", "static"
    stages = "fade_in_slide_out",
    time_formats = {
        notification = "%T",
        notification_history = "%FT%T"
    },
    timeout = 10000,
    top_down = true,
}

notify.setup(options);


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

local highlights = {
"NotifyERRORBorder",
"NotifyERRORIcon",
"NotifyERRORTitle",
"NotifyERRORBody",
"NotifyWARNBorder",
"NotifyWARNIcon",
"NotifyWARNTitle",
"NotifyWARNBody",
"NotifyINFOBorder",
"NotifyINFOIcon",
"NotifyINFOTitle",
"NotifyINFOBody",
"NotifyDEBUGBorder",
"NotifyDEBUGIcon",
"NotifyDEBUGTitle",
"NotifyDEBUGBody",
"NotifyTRACEBorder",
"NotifyTRACEIcon",
"NotifyTRACETitle",
"NotifyTRACEBody",
}

for _, highlight in ipairs(highlights) do
    vim.api.nvim_command("highlight clear " .. highlight);

    if highlight:sub(-#"Body") == "Body" then
        vim.api.nvim_command("highlight link " .. highlight .. " Normal")
    else
        if string.find(highlight, "ERROR", 1, true) ~= nil then
            vim.api.nvim_command("highlight link " .. highlight .. " DiagnosticError")
        elseif string.find(highlight, "WARN", 1, true) ~= nil then
            vim.api.nvim_command("highlight link " .. highlight .. " DiagnosticWarn")
        elseif string.find(highlight, "INFO", 1, true) ~= nil then
            vim.api.nvim_command("highlight link " .. highlight .. " DiagnosticInfo")
        elseif string.find(highlight, "DEBUG", 1, true) ~= nil then
            vim.api.nvim_command("highlight link " .. highlight .. " DiagnosticHint")
        elseif string.find(highlight, "TRACE", 1, true) ~= nil then
            vim.api.nvim_command("highlight link " .. highlight .. " DiagnosticOk")
        end
    end
end
