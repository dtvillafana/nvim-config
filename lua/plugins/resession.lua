return {
    "stevearc/resession.nvim",
    lazy = false,
    dependencies = {
        {
            "tiagovla/scope.nvim",
            lazy = false,
            config = function(opts)
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
    config = function(opts)
        local resession = require("resession")
        resession.setup({
            autosave = {
                enabled = true,
                interval = 60,
                notify = false,
            },
            -- override default filter
            buf_filter = function(bufnr)
                local bufname = vim.api.nvim_buf_get_name(bufnr)
                if bufname == "" then
                    return false
                end
                local buftype = vim.bo[bufnr].buftype
                if buftype == "help" then
                    return true
                end
                if buftype ~= "" and buftype ~= "acwrite" then
                    return false
                end

                -- this is required, since the default filter skips nobuflisted buffers
                return true
            end,
            -- override default filter
            tab_buf_filter = function(tab, bufnr)
                local bufname = vim.api.nvim_buf_get_name(bufnr)
                if bufname == "" then
                    return false
                end
                local buftype = vim.bo[bufnr].buftype
                if buftype == "help" then
                    return true
                end
                if buftype ~= "" and buftype ~= "acwrite" then
                    return false
                end

                -- this is required, since the default filter skips nobuflisted buffers
                return true
            end,
            extensions = { scope = {} }, -- add scope.nvim extension
        })
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
        -- resession.add_hook("post_load", function ()
        --     local buffers = vim.api.nvim_list_bufs()
        --
        --     for _, buf in ipairs(buffers) do
        --         -- Check if the buffer has a name
        --         local buf_name = vim.api.nvim_buf_get_name(buf)
        --         -- If the buffer name is empty, it's a [No Name] buffer
        --         if buf_name == "" then
        --             -- Delete the buffer
        --             vim.api.nvim_buf_delete(buf, { force = true })
        --         end
        --     end
        -- end
        -- )
    end
}
