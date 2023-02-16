return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {

    },
    config = function ()
        local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
        if not status_ok then
            return
        end

        treesitter.setup {
            auto_install = true,
            ensure_installed = { "c", "lua", "c_sharp", "css", "javascript", "bash", "regex", "markdown_inline", "ledger", "org" },

            ignore_install = {},
            modules = {
                highlight = {
                    additional_vim_regex_highlighting = { "org" },
                    custom_captures = {},
                    disable = { "lua" },
                    enable = true,
                    -- module_path = "nvim-treesitter.highlight"
                },
                incremental_selection = {
                    disable = {},
                    enable = false,
                    keymaps = {
                        init_selection = "gnn",
                        node_decremental = "grm",
                        node_incremental = "grn",
                        scope_incremental = "grc"
                    },
                    module_path = "nvim-treesitter.incremental_selection"
                },
                indent = {
                    disable = {},
                    enable = false,
                    module_path = "nvim-treesitter.indent"
                }
            },
            sync_install = false,
            update_strategy = "lockfile"
        }

    end
}
