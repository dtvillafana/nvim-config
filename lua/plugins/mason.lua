return {
    "williamboman/mason.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function ()
        local ensure_servers_installed = {
            "lua_ls",
            -- "omnisharp",
            "bashls",
            "jsonls",
            "tsserver",
            "pylsp",
        }

        local settings = {
            ui = {
                border = "none",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                },
            },
            log_level = vim.log.levels.INFO,
            max_concurrent_installers = 4,
        }

        local status_ok, mason = pcall(require, "mason")
        if not status_ok then
            print("Critical error, failed to load mason.nvim!")
            return
        end

        mason.setup(settings)
        local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
        if not ok then
            print("Critical error, failed to load mason-lspconfig.nvim!")
            return
        end
        mason_lspconfig.setup({
            ensure_installed = ensure_servers_installed,
            automatic_installation = false,
        })

        local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
        if not lspconfig_status_ok then
            return
        end

        local opts = {}

        for _, server in pairs(ensure_servers_installed) do
            opts = {
                on_attach = require("plugins.lsp.handlers").on_attach,
                capabilities = require("plugins.lsp.handlers").capabilities,
            }

            server = vim.split(server, "@")[1]

            local require_ok, conf_opts = pcall(require, "plugins.lsp.settings." .. server)
            if require_ok then
                opts = vim.tbl_deep_extend("force", conf_opts, opts)
            end

            lspconfig[server].setup(opts)
        end
        require("plugins.lsp.handlers").setup()
        require("plugins.lsp.null-ls")
    end
}
