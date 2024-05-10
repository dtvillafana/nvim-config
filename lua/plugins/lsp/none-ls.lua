return {
    "nvimtools/none-ls.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile", "BufEnter" },
    dependencies = {
        "jay-babu/mason-null-ls.nvim",
    },
    config = function()
        local none_ls_ok, none_ls = pcall(require, "none-ls")
        if not none_ls_ok then
            print("LSP error, failed to load none-ls.nvim!")
            return
        end

        local formatting = none_ls.builtins.formatting
        local diagnostics = none_ls.builtins.diagnostics

        none_ls.setup({
            debug = false,
            sources = {
                formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
                formatting.black.with({ extra_args = { "--fast" } }),
                formatting.stylua,
                formatting.builtins.tidy,
                diagnostics.ansiblelint,
            },
        })
    end,
}
