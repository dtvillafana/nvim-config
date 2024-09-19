return {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    opts = {
        filetype_exclude = {
            'help',
            'alpha',
            'dashboard',
            'neo-tree',
            'Trouble',
            'lazy',
            'mason',
        },
    },
    config = function(opts)
        local ufo = require('ufo')

        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('local_detach_ufo', { clear = true }),
            pattern = opts.filetype_exclude,
            callback = function()
                ufo.detach()
            end,
        })

        ufo.setup({
            provider_selector = function(bufnr, filetype, buftype)
                return { 'treesitter', 'indent' }
            end,
        })

        vim.keymap.set('n', 'zR', ufo.openAllFolds)
        vim.keymap.set('n', 'zM', ufo.closeAllFolds)
    end,
}
