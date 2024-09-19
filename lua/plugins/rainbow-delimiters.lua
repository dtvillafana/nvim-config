return {
    'HiPhish/rainbow-delimiters.nvim',
    config = function()
        local rd = require('rainbow-delimiters')
        local rds = require('rainbow-delimiters.setup')
        rds.setup({
            strategy = {
                [''] = rd.strategy['global'],
                vim = rd.strategy['local'],
            },
            query = {
                [''] = 'rainbow-delimiters',
                lua = 'rainbow-blocks',
            },
            priority = {
                [''] = 110,
                lua = 210,
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
        })
    end,
}
