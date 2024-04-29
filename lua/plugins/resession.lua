return {
    "stevearc/resession.nvim",
    lazy = false,
    dependencies = {
        {
            "tiagovla/scope.nvim",
            lazy = false,
            config = function (opts)
                require("scope").setup(opts)
                require("telescope").load_extension("scope")
            end,
            dependencies = {
                {
                    "famiu/bufdelete.nvim",
                    lazy = false,
                },
                "nvim-telescope/telescope.nvim",
            },
        },
    },
    opts = {
        autosave = {
            enabled = true,
            interval = 60,
            notify = false,
        },
        -- override default filter
        buf_filter = function(bufnr)
            local buftype = vim.bo[bufnr].buftype
            if buftype == "help" then
                return true
            end
            if buftype ~= "" and buftype ~= "acwrite" then
                return false
            end
            if vim.api.nvim_buf_get_name(bufnr) == "" then
                return false
            end

            -- this is required, since the default filter skips nobuflisted buffers
            return true
        end,
        extensions = { scope = {} }, -- add scope.nvim extension
    },
    config = function(opts)
        local resession = require("resession")
        resession.setup(opts)
        vim.api.nvim_create_autocmd("VimLeavePre", {
            callback = function()
                -- Always save a special session named "last"
                resession.save("last")
            end,
        })
        -- keymaps
        vim.keymap.set("n", "<leader>ss", resession.save_tab)
        vim.keymap.set("n", "<leader>sl", resession.load)
        vim.keymap.set("n", "<leader>sd", resession.delete)

        require("telescope").load_extension("scope")
    end,
}
