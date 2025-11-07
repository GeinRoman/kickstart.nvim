return {
    'mfussenegger/nvim-dap',

    config = function()
        local dap = require('dap')

        -- Key mappings
        vim.keymap.set('n', '<F5>', function()
            dap.continue()
        end, { desc = 'DAP Continue' })

        vim.keymap.set('n', '<F6>', function()
            dap.step_over()
        end, { desc = 'DAP Step Over' })

        vim.keymap.set('n', '<F7>', function()
            dap.step_into()
        end, { desc = 'DAP Step Into' })

        vim.keymap.set('n', '<F8>', function()
            dap.step_out()
        end, { desc = 'DAP Step Out' })

        vim.keymap.set('n', '<F4>', function()
            dap.toggle_breakpoint()
        end, { desc = 'Toggle Breakpoint' })
        -- vim.keymap.set('n', '<F1>', function()
        --     dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
        -- end, { desc = 'Set Conditional Breakpoint' })
        -- vim.keymap.set('n', '<Leader>lp', function()
        --     dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
        -- end, { desc = 'Set Log Point' })
        -- vim.keymap.set('n', '<Leader>dr', function()
        --     dap.repl.open()
        -- end, { desc = 'Open REPL' })
        -- vim.keymap.set('n', '<Leader>dl', function()
        --     dap.run_last()
        -- end, { desc = 'Run Last' })
    end,
}
