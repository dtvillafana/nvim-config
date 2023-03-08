return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        event = { "BufReadPost" , "BufNewFile" },
        dependencies = {

        },
        opts = {
            ensure_installed = {
                "c",
                "lua",
                "c_sharp",
                "python",
                "css",
                "javascript",
                "bash",
                "regex",
                "json",
                "html",
                "regex",
                "markdown",
                "markdown_inline",
                "help",
                "query",
                "yaml",
                "ledger",
                "org",
                "sql",
                "teal",
                "fennel",
            },
            auto_install = true,
            ignore_install = {},
            highlight = {
                additional_vim_regex_highlighting = { "org" },
                custom_captures = {},
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = " si",
                    node_incremental = " sn",
                    node_decremental = " sN",
                    scope_incremental = " ss",
                },
            },
            indent = {
                enable = true,
            },
            sync_install = true,
            update_strategy = "lockfile"
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    }
}
