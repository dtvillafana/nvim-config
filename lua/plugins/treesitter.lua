return {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = {
        "[ -f ~/.local/share/nvim/lazy/nvim-treesitter/queries/poweron/highlights.scm ] && rm ~/.local/share/nvim/lazy/nvim-treesitter/queries/poweron/highlights.scm",
        "[ -f ~/.local/share/nvim/lazy/nvim-treesitter/queries/poweron/indents.scm ] && rm ~/.local/share/nvim/lazy/nvim-treesitter/queries/poweron/indents.scm",
        ":TSUpdate",
    },
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {},
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
            "sql",
            "poweron",
        },
        ignore_install = {
            "csv",
            "tsv",
            "csv_semicolon",
            "csv_whitespace",
            "csv_pipe",
            "rfc_csv",
            "rfc_semicolon",
        },
        auto_install = false,
        highlight = {
            additional_vim_regex_highlighting = { "csv" },
            custom_captures = {},
            enable = true,
            disable = function(lang, buf)
                local max_filesize = 1000 * 1024 -- 1 MB
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
        update_strategy = "lockfile",
    },
    config = function(_, opts)
        -- below code adds additional parser

        local git_user = "dtvillafana"
        local git_repo = "tree-sitter-poweron"
        local git_repo_url = "https://github.com/" .. git_user .. "/" .. git_repo
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.poweron = {
            install_info = {
                url = git_repo_url, -- local path or git repo
                files = { "src/parser.c", "src/scanner.cc" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
                -- optional entries:
                branch = "main", -- default branch in case of git repo if different from master
                generate_requires_npm = false, -- if stand-alone parser without npm dependencies
                requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
            },
            filetype = "poweron", -- if filetype does not match the parser name
        }
        vim.treesitter.language.register("poweron", { "poweron", "po" })
        require("nvim-treesitter.configs").setup(opts)
        -- get highlighting for poweron
        local file_exists = vim.fn.filereadable(
            os.getenv("HOME") .. "/.local/share/nvim/lazy/nvim-treesitter/queries/poweron/highlights.scm"
        ) == 1
        if file_exists then
        else
            os.execute("mkdir -p ~/.local/share/nvim/lazy/nvim-treesitter/queries/poweron")
            local command = string.format(
                "curl -Ls -o %s %s",
                os.getenv("HOME") .. "/.local/share/nvim/lazy/nvim-treesitter/queries/poweron/highlights.scm",
                "https://raw.githubusercontent.com/" .. git_user .. "/" .. git_repo .. "/main/queries/highlights.scm"
            )
            os.execute(command)
        end
        -- get indenting for poweron
        file_exists = vim.fn.filereadable(
            os.getenv("HOME") .. "/.local/share/nvim/lazy/nvim-treesitter/queries/poweron/indents.scm"
        ) == 1
        if file_exists then
        else
            os.execute("mkdir -p ~/.local/share/nvim/lazy/nvim-treesitter/queries/poweron")
            local command = string.format(
                "curl -Ls -o %s %s",
                os.getenv("HOME") .. "/.local/share/nvim/lazy/nvim-treesitter/queries/poweron/indents.scm",
                "https://raw.githubusercontent.com/" .. git_user .. "/" .. git_repo .. "/main/queries/indents.scm"
            )
            os.execute(command)
        end
    end,
}
