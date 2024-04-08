return {
    "dtvillafana/orgmode",
    commit = "82d6d9417ff80c306a5de13e88a7c513f9ea5701",
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
        if os.getenv("ORG") == nil then
            print("$ORG environment variable not set!")
            return
        end

        local function ReturnTime()
            return os.date("%c")
        end
        local function GetCursorPos()
            return vim.api.nvim_win_get_cursor(0)[1] -- fix this crap later
        end

        orgmode.setup_ts_grammar()

        orgmode.setup {
            org_agenda_files = {os.getenv("ORG") .. '/**/*'},
            org_default_notes_file = os.getenv("ORG") .. '/refile.org',
            org_hide_emphasis_markers = true,
            org_todo_keywords = {  'TODO', 'WAITING', 'EVENT',  '|', 'DONE', 'CANCELED' },
            org_capture_templates = {
                t = { description = 'Task', template = '* TODO %?\n  %u' },
                -- the string.format is performed first which passes in the 
                l = { description = 'Coding TODO', template = string.format('* TODO %%?\n    [[file:%%F +%s][jump]]    %%u', GetCursorPos()) },
                c = { description = 'Quick Calendar Reminder', template = '* TODO %?\n  SCHEDULED: %T' },
                e = { description = 'Execute some arbitrary lua code', template = string.format("* %%(return \"%s\") %%?", ReturnTime()) },
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
                deadline_warning_reminder_time = {1, 5, 15, 30, 60},
                reminder_time = {1, 5, 15, 30},
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
                        if vim.fn.executable('notify-send') == 1 then
                            vim.loop.spawn('notify-send', { args = { string.format('%s\n%s\n%s', title, subtitle, date) }})
                        end
                    end
                end
            },
        }
    end
}
