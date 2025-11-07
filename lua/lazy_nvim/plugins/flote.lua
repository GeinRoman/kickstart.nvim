return {
    'JellyApple102/flote.nvim',
    config = function()
        require('flote').setup()
        vim.keymap.set('n', '<leader>no', '<Cmd>Flote<CR>', { noremap = true })
        vim.keymap.set('n', '<leader>ng', '<Cmd>Flote global<CR>', { noremap = true })
        vim.keymap.set('n', '<leader>nd', '<Cmd>Flote manage<CR>', { noremap = true })
    end,
}
