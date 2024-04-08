return {
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
            "python",
            "css",
            "javascript",
            "bash",
            "awk",
            "vimdoc",
            "regex",
            "json",
            "html",
            "markdown",
            "markdown_inline",
            "query",
            "yaml",
            "ledger",
            "org",
            "sql",
        },
        ignore_install = {
            'csv',
            'tsv',
            'csv_semicolon',
            'csv_whitespace',
            'csv_pipe',
            'rfc_csv',
            'rfc_semicolon'
        },
        auto_install = false,
        highlight = {
            additional_vim_regex_highlighting = { "org", "csv" },
            custom_captures = {},
            enable = true,
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
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
