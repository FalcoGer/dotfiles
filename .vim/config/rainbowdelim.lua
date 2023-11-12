-- https://gitlab.com/HiPhish/rainbow-delimiters.nvim
-- Works with treesitter

local rainbow_delimiters = require 'rainbow-delimiters'

vim.g.rainbow_delimiters = {
    strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
    },
    query = {
        -- [''] = 'rainbow-delimiters',
        [''] = 'rainbow-delimiters',
        latex = 'rainbow-blocks',
        lua = 'rainbow-blocks',
        javascript = 'rainbow-delimiters-react',
        tsx = 'rainbow-parens',
        verilog = 'rainbow-blocks',
    },
    highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
    },
}

