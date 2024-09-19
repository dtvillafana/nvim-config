return {
    cmd = { 'ansible-language-server', '--stdio' },
    filetypes = { 'yaml.ansible' },
    settings = {
        ansible = {
            ansible = {
                path = 'ansible',
            },
            executionEnvironment = {
                enabled = false,
            },
            python = {
                interpreterPath = 'python',
            },
            validation = {
                enabled = false, -- ansible-lint kept breaking because of dynamic inventory files...
                -- lint = {
                --     enabled = true,
                --     path = "ansible-lint"
                -- }
            },
        },
    },
    single_file_support = true,
}
