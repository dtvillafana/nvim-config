return {
    'dtvillafana/orgmode',
    dependencies = {
        'rcarriga/nvim-notify',
        'folke/noice.nvim',
    },
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
        if os.getenv('ORG') == nil then
            print('$ORG environment variable not set!')
            return
        end

        local function ReturnTime()
            return os.date('%c')
        end
        local function GetCursorLine()
            return vim.api.nvim_win_get_cursor(0)[1] -- fix this crap later
        end

        require('orgmode').setup({
            org_agenda_files = { os.getenv('ORG') .. '/*' },
            org_default_notes_file = os.getenv('ORG') .. '/refile.org',
            org_hide_emphasis_markers = true,
            org_todo_keywords = {
                'TODO(t)',
                'MEET(m)',
                'CALL(c)',
                'EVENT(e)',
                'WAITING(w)',
                '|',
                'DONE(d)',
                'CANCELED(a)',
            },
            org_agenda_skip_deadline_if_done = true,
            org_agenda_skip_scheduled_if_done = true,
            org_custom_exports = {
                f = {
                    label = 'Export to standalone PDF',
                    action = function(exporter)
                        local current_file = vim.api.nvim_buf_get_name(0)
                        local target = vim.fn.fnamemodify(current_file, ':p:r') .. '.pdf'
                        local command = 'cd ' ..  ' $(realpath $(dirname ' .. tostring(current_file) .. ')) ' ..  ' &&' ..  ' pandoc ' ..  current_file ..  ' -o ' ..  target ..  ' --standalone'
                        local on_success = function(output)
                            print('Success! exported to ' .. target)
                            vim.api.nvim_echo({ { table.concat(output, '\n') } }, true, {})
                        end
                        local on_error = function(err)
                            print('Error!')
                            vim.api.nvim_echo({ { table.concat(err, '\n'), 'ErrorMsg' } }, true, {})
                        end
                        return exporter(command, target, on_success, on_error)
                    end,
                },
            },
            org_capture_templates = {
                t = { description = 'Task', template = '* TODO %?\n  %u' },
                -- the string.format is performed first which passes in the
                l = {
                    description = 'Coding TODO',
                    template = string.format('* TODO %%?\n    [[file:%%F +%s][jump]]    %%u', GetCursorLine()),
                },
                c = { description = 'Quick Calendar Reminder', template = '* TODO %?\n  SCHEDULED: %T' },
                e = {
                    description = 'Execute some arbitrary lua code',
                    template = string.format('* %%(return "%s") %%?', ReturnTime()),
                },
            },
            mappings = {
                org = {
                    org_timestamp_up_day = '<C-=>',
                    org_timestamp_down_day = '<C-->',
                    org_refile = false,
                },
                agenda = {
                    org_agenda_later = 'f',
                    org_agenda_earlier = 'b',
                    org_agenda_goto_today = '.',
                },
            },
            notifications = {
                enabled = true,
                cron_enabled = false,
                repeater_reminder_time = { 1, 5, 15 },
                deadline_warning_reminder_time = { 1, 5, 15, 30, 60 },
                reminder_time = { 1, 5, 15, 30 },
                deadline_reminder = true,
                scheduled_reminder = true,
                notifier = function(tasks)
                    local result = {}
                    for _, task in ipairs(tasks) do
                        require('orgmode.utils').concat(result, {
                            string.format('# %s (%s)', task.category, task.humanized_duration),
                            string.format('%s %s %s', string.rep('*', task.level), task.todo, task.title),
                            string.format('%s: <%s>', task.type, task.time:to_string()),
                        })
                    end

                    local msg = ''
                    for _, val in ipairs(result) do
                        msg = msg .. val .. '\n'
                    end

                    if msg ~= '' then
                        require('noice').notify(tostring(msg), 'info', {
                            title = 'OrgNotify',
                            on_open = function(win)
                                local buf_id = vim.api.nvim_win_get_buf(win)
                                vim.api.nvim_set_option_value('filetype', 'org', { buf = buf_id })
                            end,
                        })
                    end
                end,
                cron_notifier = nil,
            },
        })
    end,
}
