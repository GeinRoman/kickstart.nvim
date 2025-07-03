return {
    'ThePrimeagen/harpoon',

    config = function()
        local mark = require('harpoon.mark')
        local ui = require('harpoon.ui')

        local map = vim.keymap.set
        map('n', '<leader>a', mark.add_file)
        map('n', '<leader>e', ui.toggle_quick_menu)

        map('n', '<C-h>', function()
            ui.nav_file(1)
        end)
        map('n', '<C-j>', function()
            ui.nav_file(2)
        end)
        map('n', '<C-k>', function()
            ui.nav_file(3)
        end)
        map('n', '<C-l>', function()
            ui.nav_file(4)
        end)

        -- map('n', '<leader><C-h>', function()
        --     mark.set_current_at(1)
        -- end)
        -- map('n', '<leader><C-j>', function()
        --     mark.set_current_at(2)
        -- end)
        -- map('n', '<leader><C-k>', function()
        --     mark.set_current_at(3)
        -- end)
        -- map('n', '<leader><C-l>', function()
        --     mark.set_current_at(4)
        -- end)
    end,
}
