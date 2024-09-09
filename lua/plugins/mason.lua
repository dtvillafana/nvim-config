-- INFO: Mason and mason-lspconfig is for installing and configuring LSP servers for neovim integration
return {
    "williamboman/mason.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
        "mfussenegger/nvim-dap",
        "mfussenegger/nvim-dap-python",
        "rcarriga/nvim-dap-ui",
        "nvimtools/none-ls.nvim",
        { "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" } },
    },
    build = ":MasonUpdate", -- updates registry contents
    config = function()

        -- servers are specified by name in the ./lsp/lsp_server_settings/ directory
        local function get_servers_from_dir(dir_path)
            local servers = {}
            local handle = vim.loop.fs_scandir(dir_path)
            if handle then
                local name,_ = vim.loop.fs_scandir_next(handle)
                while name do
                    local server = name:gsub('%.lua$', '')
                    table.insert(servers, server)
                    name,_ = vim.loop.fs_scandir_next(handle)
                end
            else
                vim.notify("Could not find LSP server config path: " .. dir_path)
            end
            return servers
        end

        local dir_path = vim.fn.stdpath('config') .. '/lua/plugins/lsp/lsp_server_settings'
        local ensure_servers_installed = get_servers_from_dir(dir_path)
        local mason_ok, mason = pcall(require, "mason")
        if not mason_ok then
            print("LSP error, failed to load mason.nvim!")
            return
        end

        local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
        if not mason_lspconfig_ok then
            print("LSP error, failed to load mason-lspconfig.nvim!")
            return
        end

        local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
        if not lspconfig_ok then
            print("LSP error, failed to load lspconfig.nvim!")
            return
        end

        mason.setup({
            ui = {
                border = "none",
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
            log_level = vim.log.levels.INFO,
            max_concurrent_installers = 4,
        })

        mason_lspconfig.setup({
            ensure_installed = ensure_servers_installed,
            automatic_installation = false,
        })

        local opts = {}

        for _, server in pairs(ensure_servers_installed) do
            opts = {
                on_attach = require("plugins.lsp.handlers").on_attach, -- sets keymaps for LSP when server attaches
                capabilities = require("plugins.lsp.handlers").capabilities, -- this enables autocompletion
            }

            server = vim.split(server, "@")[1]

            local require_ok, conf_opts = pcall(require, "plugins.lsp.lsp_server_settings." .. server)
            if require_ok then
                opts = vim.tbl_deep_extend("force", conf_opts, opts)
            end

            lspconfig[server].setup(opts)
        end
        require("plugins.lsp.handlers").setup()
        require("plugins.lsp.none-ls")
    end,
}
