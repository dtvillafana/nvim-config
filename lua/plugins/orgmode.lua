return {
    "nvim-orgmode/orgmode",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    build = ":TSUpdate org",
    config = function()
        local status_ok, _ = pcall(require, "nvim-treesitter.configs")
        local status_nok, orgmode = pcall(require, "orgmode")
        status_ok = status_nok and status_ok
        if not status_nok then
            print("orgmode not setup...")
            return
        end

        local function returnTime()
            return os.date("%c")
        end
        local function GetCursorPos()
            return vim.api.nvim_win_get_cursor(0)[1] -- fix this crap later
        end

        orgmode.setup_ts_grammar()
        -- nvim_treesitter.setup {
        --     -- If TS highlights are not enabled at all, or disabled via `disable` prop,
        --     -- highlighting will fallback to default Vim syntax highlighting
        --     highlight = {
        --         enable = true,
        --         -- Required for spellcheck, some LaTex highlights and
        --         -- code block highlights that do not have ts grammar
        --         additional_vim_regex_highlighting = {'org'},
        --     },
        --     ensure_installed = {'org'}, -- Or run :TSUpdate org
        -- }


        orgmode.setup {
            org_agenda_files = {'~/Sync/orgmode/**/*'},
            org_default_notes_file = '~/Sync/orgmode/refile.org',
            org_hide_emphasis_markers = true,
            org_todo_keywords = {  'WAITING', 'EVENT', 'TODO', '|', 'DONE', 'CANCELED' },
            org_capture_templates = {
                t = { description = 'Task', template = '* TODO %?\n  %u' },
                -- the string.format is performed first which passes in the 
                l = { description = 'Coding TODO', template = string.format('* TODO %%?\n    [[file:%%F +%s][jump]]    %%u', GetCursorPos()) },
                c = { description = 'Quick Calendar Reminder', template = '* TODO %?\n  %T' },
                e = { description = 'Execute some arbitrary lua code', template = string.format("* %%(return \"%s\") %%?", returnTime()) },
            },
            mappings = {
                org = {
                    org_timestamp_up_day = "<C-=>",
                    org_timestamp_down_day = "<C-->",
                    -- org_refile = "",
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
                repeater_reminder_time = {1, 5, 15},
                deadline_warning_reminder_time = {1, 5, 15},
                reminder_time = {1, 5, 15},
                deadline_reminder = true,
                scheduled_reminder = true,
                notifier = function(tasks)
                    local result = {}
                    for _, task in ipairs(tasks) do
                        require('orgmode.utils').concat(result, {
                            string.format('# %s (%s)', task.category, task.humanized_duration),
                            string.format('%s %s %s', string.rep('*', task.level), task.todo, task.title),
                            string.format('%s: <%s>', task.type, task.time:to_string())
                        })
                    end
                    if not vim.tbl_isempty(result) then
                        require('orgmode.notifications.notification_popup'):new({ content = result })
                    end
                end,
                cron_notifier = function(tasks)
                    for _, task in ipairs(tasks) do
                        local title = string.format('%s (%s)', task.category, task.humanized_duration)
                        local subtitle = string.format('%s %s %s', string.rep('*', task.level), task.todo, task.title)
                        local date = string.format('%s: %s', task.type, task.time:to_string())
                        -- Linux
                        if vim.fn.executable('notify-send') == 1 then
                            vim.loop.spawn('notify-send', { args = { string.format('%s\n%s\n%s', title, subtitle, date) }})
                        end
                        -- MacOS
                        if vim.fn.executable('terminal-notifier') == 1 then
                            vim.loop.spawn('terminal-notifier', { args = { '-title', title, '-subtitle', subtitle, '-message', date }})
                        end
                    end
                end
            },
        }
    end
}
