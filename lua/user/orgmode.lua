local status_ok, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
local status_nok, orgmode = pcall(require, "orgmode")
status_ok = status_nok and status_ok
if not status_nok then
    return
end

local function returnTime()
    return os.date("%c")
end
local function GetCursorPos()
    return vim.api.nvim_win_get_cursor(0)[1] -- fix this crap later
end

orgmode.setup_ts_grammar()
nvim_treesitter.setup {
    -- If TS highlights are not enabled at all, or disabled via `disable` prop,
    -- highlighting will fallback to default Vim syntax highlighting
    highlight = {
        enable = true,
        -- Required for spellcheck, some LaTex highlights and
        -- code block highlights that do not have ts grammar
        additional_vim_regex_highlighting = {'org'},
    },
    ensure_installed = {'org'}, -- Or run :TSUpdate org
}

orgmode.setup {
    org_agenda_files = {'~/Sync/orgmode/**/*'},
    org_default_notes_file = '~/Sync/orgmode/refile.org',
    org_hide_emphasis_markers = true,
    org_todo_keywords = { 'TODO', '|', 'DONE' },
    org_capture_templates = {
        t = { description = 'Task', template = '* TODO %?\n  %u' },
        -- the string.format is performed first which passes in the 
        l = { description = 'Coding TODO', template = string.format('* TODO %%?\n    [[file:%%F +%s][jump]]    %%u', GetCursorPos()) },
        c = { description = 'Quick Calendar Reminder', template = '* TODO %?\n  %T' },
        e = { description = 'Execute some arbitrary lua code', template = string.format("* %%(return \"%s\") %%?", returnTime()) },
},
    mappings = {
        agenda = {
            org_agenda_later = 'f',
            org_agenda_earlier = 'b',
            org_agenda_goto_today = '.'
        }
    }
}

function SetOrgHighlighting()
    vim.api.nvim_command('highlight Folded ctermfg=white')
end
