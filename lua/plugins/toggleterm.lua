return {
    "akinsho/toggleterm.nvim",
    dependencies = {

    },
    config = function()
        local status_ok, toggleterm = pcall(require, "toggleterm")
        if not status_ok then
            return
        end
        toggleterm.setup({
            size = function (term)
                if term.direction == "vertical" then
                    return vim.o.columns * 0.4
                elseif term.direction == "horizontal" then
                    local cur_win = vim.api.nvim_get_current_win()
                    local height = vim.api.nvim_win_get_height(cur_win)
                    return height * 0.3
                end
            end,
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
                border = "curved",
                winblend = 0,
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
            },
        })

        function SET_TERMINAL_KEYMAPS()
            local opts = {noremap = true}
            vim.api.nvim_buf_set_keymap(0, 't', '<leader><esc>', [[<C-\><C-n>]], opts)
            vim.api.nvim_buf_set_keymap(0, 't', '<leader>q', [[<C-\><C-n>:q<CR>]], opts)
            vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
            vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
            vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
            vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
        end

        vim.cmd('autocmd! TermOpen term://* lua SET_TERMINAL_KEYMAPS()')

        local Terminal = require("toggleterm.terminal").Terminal

        local floatTerm = Terminal:new({
            hidden = true,
            direction = "float",
        })

        function _TERM_TOGGLE_FLOAT()
            floatTerm:toggle()
        end

        local vertTerm = Terminal:new({
            hidden = true,
            direction = "vertical",
            size = 80,
        })

        function _TERM_TOGGLE_VERT()
            vertTerm:toggle()
        end

        local horizTerm = Terminal:new({
            hidden = true,
            direction = "horizontal",
            size = 10,
        })

        function _TERM_TOGGLE_HORIZ()
            horizTerm:toggle()
        end

        local tabTerm = Terminal:new({
            hidden = true,
            direction = "tab",
        })

        function _TERM_TOGGLE_TAB()
            tabTerm:toggle()
        end


        function _LAZYGIT_TOGGLE()
            local lazygit = Terminal:new({
                cmd = "lazygit",
                hidden = true ,
                close_on_exit = true,
                direction = "float",
            })
            local cwd = vim.fn.getcwd()
            SET_CWD_TO_BUF_DIR()
            lazygit:toggle()
            local command = "cd " .. cwd
            vim.api.nvim_exec(command, false)
        end

        local node = Terminal:new({
            cmd = "node",
            hidden = true,
            direction = "horizontal",
        })

        function _NODE_TOGGLE()
            node:toggle()
        end

        local ncdu = Terminal:new({
            cmd = "ncdu",
            hidden = true,
            direction = "float",
        })

        function _NCDU_TOGGLE()
            ncdu:toggle()
        end

        local bpytop = Terminal:new({
            cmd = "bpytop",
            hidden = true,
            direction = "float",
        })

        function _BPYTOP_TOGGLE()
            bpytop:toggle()
        end

        local python = Terminal:new({
            cmd = "python",
            hidden = true,
            direction = "horizontal",
        })

        function _PYTHON_TOGGLE()
            python:toggle()
        end
    end
}
