return {
    settings = {
        pylsp = {
            plugins = {
                autopep8 = 'enabled'
            },
            diagnostics = {
                -- Get the language server to recognize the globals
                globals = {'config'},
            },
        }
    }
}
