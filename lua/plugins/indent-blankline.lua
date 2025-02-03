return {
    'lukas-reineke/indent-blankline.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        local status_ok, indent_blankline = pcall(require, 'ibl')
        if not status_ok then
            return
        end
        local highlight = {
            'RainbowRed',
            'RainbowYellow',
            'RainbowBlue',
            'RainbowOrange',
            'RainbowGreen',
            'RainbowViolet',
            'RainbowCyan',
        }

        indent_blankline.setup({
            enabled = true,
            debounce = 200,
            indent = {
                char = '┊',
                tab_char = '┊',
                smart_indent_cap = true,
                priority = 1,
                highlight = highlight,
            },
            exclude = {
                filetypes = {
                    'oil',
                    'org',
                },
            },
        })

        local hooks = require('ibl.hooks')
        -- create the highlight groups in the highlight setup hook, so they are reset
        -- every time the colorscheme changes
        hooks.cb.highlight_setup = function()
            vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
            vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
            vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
            vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
            vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
            vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
            vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
        end

    end,
}
