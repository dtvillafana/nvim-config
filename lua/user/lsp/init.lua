local status_ok, _ = pcall(require, "lspconfig") -- checks to see if lspconfig is installed and if not just return because following code wont work
if not status_ok then
    return
end

require("user.lsp.mason")
require("user.lsp.handlers").setup()
require("user.lsp.null-ls")
