return {
    "akinsho/toggleterm.nvim",
    dependencies = {},
    config = function()
        local status_ok, toggleterm = pcall(require, "toggleterm")
        if not status_ok then
            return
        end
        toggleterm.setup({
            size = function(term)
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

        -- TODO: refactor this to use nvim api
        function SET_TERMINAL_KEYMAPS()
            local opts = { noremap = true }
            vim.api.nvim_buf_set_keymap(0, "t", "<leader><esc>", [[<C-\><C-n>]], opts)
            vim.api.nvim_buf_set_keymap(0, "t", "<leader>q", [[<C-\><C-n>:q<CR>]], opts)
            vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
            vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
            vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
            vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
        end

        vim.cmd("autocmd! TermOpen term://* lua SET_TERMINAL_KEYMAPS()")

        local Terminal = require("toggleterm.terminal").Terminal

        ---Create or open terminal
        ---@param count number
        function _TERM_TOGGLE_FLOAT(count)
            local floatTerm = Terminal:new({
                hidden = true,
                direction = "float",
                id = count,
                display_name = "Terminal " .. count,
            })
            floatTerm:toggle()
        end

        ---Create or open terminal
        ---@param count number
        function _TERM_TOGGLE_VERT(count)
            local vertTerm = Terminal:new({
                hidden = true,
                direction = "vertical",
                size = 80,
                id = count + 10,
                display_name = "Terminal " .. count,
            })
            vertTerm:toggle()
        end

        ---Create or open terminal
        ---@param count number
        function _TERM_TOGGLE_HORIZ(count)
            local horizTerm = Terminal:new({
                hidden = true,
                direction = "horizontal",
                size = 10,
                id = count + 20,
                display_name = "Terminal " .. count,
            })
            horizTerm:toggle()
        end

        ---Create or open terminal
        ---@param count number
        function _TERM_TOGGLE_TAB(count)
            local tabTerm = Terminal:new({
                hidden = true,
                direction = "tab",
                id = count + 30,
                display_name = "Terminal " .. count,
            })
            tabTerm:toggle()
        end

        function _LAZYGIT_TOGGLE()
            local current_buf = vim.api.nvim_get_current_buf()
            local filepath = vim.api.nvim_buf_get_name(current_buf)
            local directory = vim.fn.fnamemodify(filepath, ":h")
            local lazygit = Terminal:new({
                cmd = "lazygit",
                hidden = true,
                close_on_exit = true,
                direction = "float",
                dir = directory,
            })
            lazygit:toggle()
        end

        function _NODE_TOGGLE()
            local node = Terminal:new({
                cmd = "node",
                hidden = true,
                direction = "horizontal",
            })
            node:toggle()
        end

        function _NCDU_TOGGLE()
            local ncdu = Terminal:new({
                cmd = "ncdu",
                hidden = true,
                direction = "float",
            })

            ncdu:toggle()
        end

        function _BPYTOP_TOGGLE()
            local bpytop = Terminal:new({
                cmd = "bpytop",
                hidden = true,
                direction = "float",
            })

            bpytop:toggle()
        end

        function _POWERSHELL_TOGGLE()
            local powershell = Terminal:new({
                cmd = "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe",
                hidden = true,
                direction = "float",
                dir = "/mnt/c/Users/dv0815/Downloads/",
            })

            powershell:toggle()
        end
    end,
}
