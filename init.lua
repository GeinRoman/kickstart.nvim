require('general')

require('keymaps')

require('lazy_nvim')

-- LSP for qml language
vim.lsp.config['qmlls'] = {
    -- Command and arguments to start the server.
    cmd = {
        'qmlls',
        -- , '--build-dir', 'build', '--doc-dir', 'C:/user_programs/qt/5.12.12/mingw73_64/doc'
    },
    -- root_dir = util.root_pattern('CMakeLists.txt', '.git'),
}
vim.lsp.enable('qmlls')
