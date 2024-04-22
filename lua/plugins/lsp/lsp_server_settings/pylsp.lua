return {
    settings = {
        pylsp = {
            plugins = {
                autopep8 = "enabled",
                pycodestyle = {
                    ignore = { "E501" },
                    maxLineLength = 200, -- this is actually useless because we are ignoring E501
                },
            },
            diagnostics = {
                -- Get the language server to recognize the globals
                globals = { "config" },
            },
        },
    },
}
