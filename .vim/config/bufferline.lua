local bufferline = require("bufferline")

-- background color definitions
-- same as normal background
local background = '#121212'
local backgroundterm = 233
-- not selected, not visible
local normal = '#262626'
local normalterm = 235
-- visible, not selected
local visible = '#444444'
local visibleterm = 238
-- selected
local selected = '#808080'
local selectedterm = 8

-- foreground colors from Coc for hint, info, warning and error
local hintcolor = '#008080'
local hintcolorterm = 6
local infocolor = '#0000FF'
local infocolorterm = 12
local warningcolor = '#FF8700'
local warningcolorterm = 208
local errorcolor = '#FF0000'
local errorcolorterm = 9

-- :help bufferline-configuration
bufferline.setup(
    {
        options = {
            mode = "buffers",
            separator_style = "slant",
            --[[
        style_preset = {
            bufferline.style_preset.no_italic,
            bufferline.style_preset.no_bold
        },
        ]] --
            numbers = function(opts)
                return string.format('[%d]', opts.id)
            end,
            indicator = {
                style = "underline"
            },
            diagnostics = "coc",
            -- ignore unused parameter
            -- luacheck: push ignore 212
            ---@diagnostic disable-next-line
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                -- luacheck: pop
                if (count == 0) then
                    return ""
                end
                -- needs different variables because I want them in this particular order
                local errorstr = ""
                local warningstr = ""
                local infostr = ""
                local hintstr = ""
                local mysterystr = ""
                -- kitty scales down the icon if there is no space on the right
                for e, n in pairs(diagnostics_dict) do
                    if e:match("error") then
                        errorstr = '󰡅 ' .. n
                    elseif e:match("warning") then
                        infostr = ' ' .. n
                    elseif e:match("info") then
                        infostr = ' ' .. n
                    elseif e:match("hint") then
                        hintstr = '󰌵 ' .. n
                    else
                        mysterystr = ' ' .. level .. ' ' .. n
                    end
                end
                return errorstr .. warningstr .. infostr .. hintstr .. mysterystr
            end,
            hover = {
                enabled = true,
                delay = 0,
                reveal = { "close" }
            },
            close_icon = '',
            buffer_close_icon = '',
            show_tab_indicators = true,
            show_duplicate_prefix = true,
            always_show_bufferline = true,
            name_formatter = function(buf)
                if (buf.buffers == nil) then
                    -- it's a buffer
                    return buf.name
                end
                -- it's a tab
                local count = 0
                for _ in pairs(buf.buffers) do count = count + 1 end
                return string.format('%d %d ', vim.api.nvim_tabpage_get_number(buf.tabnr), count)
            end,
offsets = {
    {
        filetype = "NvimTree",
        text = function()
            return vim.fn.getcwd()
        end,
        highlight = "Normal",
        text_align = "left",
        separator = true
    },
    {
        filetype = "NERDTree",
        text = function()
            return vim.fn.getcwd()
        end,
        highlight = "Normal",
        text_align = "left",
        separator = true
    },
    {
        filetype = "undotree",
        text = "Undo Tree",
        highlight = "Normal",
        text_align = "left",
        separator = true
    },
    {
        filetype = "diff",
        text = "Diff",
        highlight = "Normal",
        text_align = "left",
        separator = true
    },
    {
        filetype = "tagbar",
        text = "Tags",
        highlight = "Normal",
        text_align = "left",
        separator = true
    },
    {
        filetype = "help",
        text = "Help",
        highlight = "Normal",
        text_align = "left",
        separator = true
    }
},
            themable = true,
        },         -- end options
        highlights = { -- help bufferline-highlights
            fill = {
                bg = background,
                ctermbg = backgroundterm
            },
            tab = { -- non selected tab
                bg = normal,
                ctermbg = normalterm,
                fg = '#808080',
                ctermfg = 8
            },
            tab_separator = { -- non selected tab separators
                bg = normal, -- this is inside the "tab"
                ctermbg = normalterm,
                fg = background, -- actual corner piece, blends into background
                ctermfg = backgroundterm
            },
            tab_selected = { -- selected tab
                bg = selected,
                ctermbg = selectedterm,
                fg = '#FFFFFF',
                ctermfg = 15
            },
            tab_separator_selected = { -- selected tab separators
                bg = selected,
                ctermbg = selectedterm,
                fg = background,
                ctermfg = backgroundterm
            },
            background = { -- non visible, non selected buffers
                bg = normal,
                ctermbg = normalterm
            },
            separator = {
                bg = normal,
                ctermbg = normalterm,
                fg = background,
                ctermfg = backgroundterm
            },
            buffer_visible = { -- buffer visible, but not selected
                bg = visible,
                ctermbg = visibleterm
            },
            separator_visible = {
                bg = visible,
                ctermbg = visibleterm,
                fg = background,
                ctermfg = backgroundterm
            },
            buffer_selected = {
                bg = selected,
                ctermbg = selectedterm
            },
            separator_selected = {
                bg = selected,
                ctermbg = selectedterm,
                fg = background,
                ctermfg = backgroundterm
            },
            modified = {
                bg = normal,
                ctermfg = normalterm
            },
            modified_visible = {
                bg = visible,
                ctermbg = visibleterm
            },
            modified_selected = {
                bg = selected,
                ctermbg = selectedterm
            },
            duplicate = {
                strikethrough = true
            },
            duplicate_visible =
            {
                strikethrough = true
            },
            duplicate_selected = {
                strikethrough = true
            },
            diagnostic = {
                bg = normal,
                ctermbg = normalterm
            },
            diagnostic_visible = {
                bg = visible,
                ctermbg = visibleterm
            },
            diagnostic_selected = {
                bg = selected,
                ctermbg = selectedterm
            },
            close_button = {
                bg = normal,
                ctermbg = normalterm
            },
            close_button_visible = {
                bg = visible,
                ctermbg = visibleterm
            },
            close_button_selected = {
                bg = selected,
                ctermbg = selectedterm
            },
            numbers = {
                bg = normal,
                ctermbg = normalterm
            },
            numbers_visible = {
                bg = visible,
                ctermbg = visibleterm
            },
            numbers_selected = {
                bg = selected,
                ctermbg = selectedterm
            },
            hint = {
                bg = normal,
                ctermbg = normalterm,
                sp = hintcolor,
                undercurl = true
            },
            hint_visible = {
                bg = visible,
                ctermbg = visibleterm,
                sp = hintcolor,
                undercurl = true
            },
            hint_selected = {
                bg = selected,
                ctermbg = selectedterm,
                sp = hintcolor,
                undercurl = true
            },
            hint_diagnostic = {
                bg = normal,
                ctermbg = normalterm,
                fg = hintcolor,
                ctermfg = hintcolorterm
            },
            hint_diagnostic_visible = {
                bg = visible,
                ctermbg = visibleterm,
                fg = hintcolor,
                ctermfg = hintcolorterm
            },
            hint_diagnostic_selected = {
                bg = selected,
                ctermbg = selectedterm,
                fg = hintcolor,
                ctermfg = hintcolorterm
            },
            info = {
                bg = normal,
                ctermbg = normalterm,
                sp = infocolor,
                undercurl = true
            },
            info_visible = {
                bg = visible,
                ctermbg = visibleterm,
                sp = infocolor,
                undercurl = true
            },
            info_selected = {
                bg = selected,
                ctermbg = selectedterm,
                sp = infocolor,
                undercurl = true
            },
            info_diagnostic = {
                bg = normal,
                ctermbg = normalterm,
                fg = infocolor,
                ctermfg = infocolorterm
            },
            info_diagnostic_visible = {
                bg = visible,
                ctermbg = visibleterm,
                fg = infocolor,
                ctermfg = infocolorterm
            },
            info_diagnostic_selected = {
                bg = selected,
                ctermbg = selectedterm,
                fg = infocolor,
                ctermfg = infocolorterm
            },
            warning = {
                bg = normal,
                ctermbg = normalterm,
                sp = warningcolor,
                undercurl = true
            },
            warning_visible = {
                bg = visible,
                ctermbg = visibleterm,
                sp = warningcolor,
                undercurl = true
            },
            warning_selected = {
                bg = selected,
                ctermbg = selectedterm,
                sp = warningcolor,
                undercurl = true
            },
            warning_diagnostic = {
                bg = normal,
                ctermbg = normalterm,
                fg = warningcolor,
                ctermfg = warningcolorterm
            },
            warning_diagnostic_visible = {
                bg = visible,
                ctermbg = visibleterm,
                fg = warningcolor,
                ctermfg = warningcolorterm
            },
            warning_diagnostic_selected = {
                bg = selected,
                ctermbg = selectedterm,
                fg = warningcolor,
                ctermfg = warningcolorterm
            },
            error = {
                bg = normal,
                ctermbg = normalterm,
                sp = errorcolor,
                undercurl = true
            },
            error_visible = {
                bg = visible,
                ctermbg = visibleterm,
                sp = errorcolor,
                undercurl = true
            },
            error_selected = {
                bg = selected,
                ctermbg = selectedterm,
                sp = errorcolor,
                undercurl = true
            },
            error_diagnostic = {
                bg = normal,
                ctermbg = normalterm,
                fg = errorcolor,
                ctermfg = errorcolorterm
            },
            error_diagnostic_visible = {
                bg = visible,
                ctermbg = visibleterm,
                fg = errorcolor,
                ctermfg = errorcolorterm
            },
            error_diagnostic_selected = {
                bg = selected,
                ctermbg = selectedterm,
                fg = errorcolor,
                ctermfg = errorcolorterm
            },
        }
    }
)

