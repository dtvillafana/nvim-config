return {
    "nvim-orgmode/telescope-orgmode.nvim",
    event = "VeryLazy",
    dependencies = {
        "dtvillafana/orgmode",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        local status_ok, telescope = pcall(require, "telescope")
        if not status_ok then
            return
        end
        telescope.load_extension("orgmode")
        vim.keymap.set("n", "<leader>oh", telescope.extensions.orgmode.search_headings)
        vim.keymap.set("n", "<leader>ol", telescope.extensions.orgmode.insert_link)
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'org',
            group = vim.api.nvim_create_augroup('orgmode_telescope_nvim', { clear = true }),
            callback = function()
                vim.keymap.set('n', '<leader>or', require('telescope').extensions.orgmode.refile_heading)
            end,
        })
    end
}
