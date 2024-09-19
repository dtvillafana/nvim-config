return {
    'chipsenkbeil/org-roam.nvim',
    dependencies = {
        {
            'nvim-orgmode/orgmode',
        },
    },
    config = function()
        require('org-roam').setup({
            directory = '~/git-repos/orgfiles/roam',
        })
    end,
}
