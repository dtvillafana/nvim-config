return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter',
        'nvim-telescope/telescope-media-files.nvim',
        'nvim-telescope/telescope-frecency.nvim',
        'nvim-orgmode/telescope-orgmode.nvim',
    },
    config = function()
        local status_ok, telescope = pcall(require, 'telescope')
        if not status_ok then
            return
        end
        local layout = ''
        if vim.o.lines > 100 then
            layout = 'vertical'
        else
            layout = 'horizontal'
        end

        local actions = require('telescope.actions')
        telescope.setup({
            defaults = {
                layout_strategy = layout,
                scroll_strategy = 'limit',
                layout_config = {
                    bottom_pane = {
                        height = 25,
                        preview_cutoff = 100,
                        prompt_position = 'top',
                    },
                    center = {
                        height = 0.4,
                        preview_cutoff = 40,
                        prompt_position = 'top',
                        width = 0.5,
                    },
                    cursor = {
                        height = 0.9,
                        preview_cutoff = 40,
                        width = 0.8,
                    },
                    horizontal = {
                        height = 0.9,
                        preview_cutoff = 70,
                        prompt_position = 'bottom',
                        width = 0.8,
                    },
                    vertical = {
                        height = 0.9,
                        preview_cutoff = 100,
                        prompt_position = 'bottom',
                        width = 0.8,
                    },
                },
                prompt_prefix = ' ',
                selection_caret = ' ',
                path_display = { 'smart' },
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                    '--no-ignore-vcs',
                    '--follow',
                    '--hidden',
                },
            },
            use_less = false,
            mappings = {
                i = {
                    ['<C-n>'] = actions.cycle_history_next,
                    ['<C-p>'] = actions.cycle_history_prev,

                    ['<C-j>'] = actions.move_selection_next,
                    ['<C-k>'] = actions.move_selection_previous,

                    ['<C-c>'] = actions.close,

                    ['<Down>'] = actions.move_selection_next,
                    ['<Up>'] = actions.move_selection_previous,

                    ['<CR>'] = actions.select_default,
                    ['<C-x>'] = actions.select_horizontal,
                    ['<C-v>'] = actions.select_vertical,
                    ['<C-t>'] = actions.select_tab,

                    ['<C-u>'] = actions.preview_scrolling_up,
                    ['<C-d>'] = actions.preview_scrolling_down,

                    ['<PageUp>'] = actions.results_scrolling_up,
                    ['<PageDown>'] = actions.results_scrolling_down,

                    ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
                    ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
                    ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                    ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
                    ['<C-l>'] = actions.complete_tag,
                    ['<C-_>'] = actions.which_key, -- keys from pressing <C-/>
                },

                n = {
                    ['<esc>'] = actions.close,
                    ['<CR>'] = actions.select_default,
                    ['<C-x>'] = actions.select_horizontal,
                    ['<C-v>'] = actions.select_vertical,
                    ['<C-t>'] = actions.select_tab,

                    ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
                    ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
                    ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                    ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,

                    ['j'] = actions.move_selection_next,
                    ['k'] = actions.move_selection_previous,
                    ['H'] = actions.move_to_top,
                    ['M'] = actions.move_to_middle,
                    ['L'] = actions.move_to_bottom,

                    ['<Down>'] = actions.move_selection_next,
                    ['<Up>'] = actions.move_selection_previous,
                    ['gg'] = actions.move_to_top,
                    ['G'] = actions.move_to_bottom,

                    ['<C-u>'] = actions.preview_scrolling_up,
                    ['<C-d>'] = actions.preview_scrolling_down,

                    ['<PageUp>'] = actions.results_scrolling_up,
                    ['<PageDown>'] = actions.results_scrolling_down,

                    ['?'] = actions.which_key,
                },
            },
            pickers = {
                -- Default configuration for builtin pickers goes here:
                find_files = {
                    hidden = true,
                },
                -- builtin picker
                -- Now the picker_config_key will be applied every time you call this
            },
            extensions = {
                -- Your extension configuration goes here:
                -- extension_name = {
                --   extension_config_key = value,
                -- },
                -- please take a look at the readme of the extension you want to configure
                media_files = {
                    -- filetypes whitelist
                    -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
                    filetypes = { 'png', 'webp', 'jpg', 'jpeg', 'pdf' },
                    find_cmd = 'rg', -- find command (defaults to `fd`)
                },
            },
        })
        telescope.load_extension('media_files')
    end,
}
