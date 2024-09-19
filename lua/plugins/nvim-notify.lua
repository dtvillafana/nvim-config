return {
    'rcarriga/nvim-notify',
    dependencies = {},
    config = function()
        local status_ok, notify = pcall(require, 'notify')
        if not status_ok then
            print('nvim-notify did not load')
            return
        end
        notify.setup({
            background_colour = '#000000',
            fps = 30,
            icons = {
                DEBUG = '',
                ERROR = '',
                INFO = '',
                TRACE = '✎',
                WARN = '',
            },
            level = 2,
            minimum_width = 50,
            render = 'default',
            stages = 'fade_in_slide_out',
            timeout = 5000,
            top_down = true,
        })
        vim.notify = notify
    end,
}
