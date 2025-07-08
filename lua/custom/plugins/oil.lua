return {
    'stevearc/oil.nvim',
    dependencies = { 'echasnovski/mini.icons' },
    config = function()
        require('oil').setup({
            use_default_keymaps = false,
            keymaps = {
                ['<C-e>'] = 'actions.refresh',
                ['<CR>'] = 'actions.select',
                ['<C-p>'] = 'actions.preview',
                ['<C-c>'] = { 'actions.close', mode = 'n' },
            },
            view_options = { show_hidden = true },
        })
        vim.keymap.set('n', '<leader>v', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
}
