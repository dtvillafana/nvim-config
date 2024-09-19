return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'mfussenegger/nvim-dap-python',
        'nvim-neotest/nvim-nio',
        'nvim-treesitter/nvim-treesitter',
        'theHamsta/nvim-dap-virtual-text',
        'jbyuki/one-small-step-for-vimkind',
    },
    config = function()
        local dap, dapui, dap_python = require('dap'), require('dapui'), require('dap-python')
        dapui.setup()
        dap_python.setup()
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
        -- debug adapter keybinds
        local opts = { noremap = true, silent = true }
        local keymap = vim.keymap.set
        keymap('n', '<leader>de', function()
            dapui.toggle()
        end, opts)
        keymap('n', '<leader>ds', function()
            dap.continue()
        end, opts)
        keymap('n', '<Down>', function()
            dap.step_over()
        end, opts)
        keymap('n', '<Right>', function()
            dap.step_into()
        end, opts)
        keymap('n', '<Left>', function()
            dap.step_out()
        end, opts)
        keymap('n', '<Leader>db', function()
            dap.toggle_breakpoint()
        end, opts)
        keymap('n', '<Leader>dB', function()
            dap.set_breakpoint()
        end, opts)
        keymap('n', '<Leader>dbl', function()
            dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
        end, opts)
        keymap('n', '<Leader>dr', function()
            dap.repl.open()
        end, opts)
        keymap('n', '<Leader>dl', function()
            dap.run_last()
        end, opts)
        keymap({ 'n', 'v' }, '<Leader>dh', function()
            require('dap.ui.widgets').hover()
        end)
        keymap({ 'n', 'v' }, '<Leader>dp', function()
            require('dap.ui.widgets').preview()
        end)
        keymap('n', '<Leader>duf', function()
            local widgets = require('dap.ui.widgets')
            widgets.centered_float(widgets.frames)
        end)
        keymap('n', '<Leader>dus', function()
            local widgets = require('dap.ui.widgets')
            widgets.centered_float(widgets.scopes)
        end)
    end,
}
