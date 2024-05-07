return {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    opts = {
        filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
    },
    config = function(_, opts)
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("local_detach_ufo", { clear = true }),
            pattern = opts.filetype_exclude,
            callback = function()
                require("ufo").detach()
            end,
        })

        vim.opt.foldlevelstart = 99
        vim.o.foldcolumn = "0" -- '0' is not bad
        vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldenable = true
        require("ufo").setup(opts)
    end,
}
