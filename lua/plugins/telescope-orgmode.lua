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
        vim.keymap.set("n", "<leader>or", telescope.extensions.orgmode.refile_heading)
        vim.keymap.set("n", "<leader>oh", telescope.extensions.orgmode.search_headings)
        vim.keymap.set("n", "<leader>ol", telescope.extensions.orgmode.insert_link)
    end,
}
