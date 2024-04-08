return {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
        { 'tpope/vim-dadbod', lazy = true },
        { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'sqlserver', 'plsql', 'sqlite' }, lazy = true },
    },
    cmd = {
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
    },
    init = function()
        vim.g.db_ui_use_nerd_fonts = 1
        vim.g.db_ui_show_database_icon = 1
        -- to make sql server work you might have to URL encode special characters and/or add some parameters to the end of your connection string:
        -- vim.g.dbs = { dev2 = 'sqlserver://username:password@192.168.0.1:1433/MyDBName?Encrypt=1;trustServerCertificate=1' }
        vim.g.dbs = { politics = 'sqlite://' .. os.getenv("HOME").. '/Sync/datasets/politics.db' }
        vim.g.db_ui_use_nvim_notify = 0

        -- enable completion using cmp, I tried to make the autocmd fire on FileType but that just doesn't work
        vim.api.nvim_create_autocmd('BufEnter', {
            pattern = {'*.sql', '*.tsql', '*.plsql', '*-query-*'},
            callback = function()
                require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
            end,
        })
    end,
}
