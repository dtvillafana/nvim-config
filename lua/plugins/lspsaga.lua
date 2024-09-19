return {
    'nvimdev/lspsaga.nvim',
    config = function()
        require('lspsaga').setup({
            ui = {
                virtual_text = false,
            },
            outline = {
                layout = 'float',
            },
        })
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons', -- optional
    },
}
