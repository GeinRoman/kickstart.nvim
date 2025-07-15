local addToQrc = function()
    local full_path = vim.api.nvim_buf_get_name(0)
    local relative_path = vim.fn.fnamemodify(full_path, ':.')
    relative_path = relative_path:gsub('\\', '/')

    local cwd = vim.fn.getcwd()
    local qrc_file_path = vim.fn.glob(cwd .. '/**/' .. 'qml.qrc', true, false)
    if qrc_file_path == nil then
        print('❌ Failed to open qml.qrc')
        return
    end

    vim.cmd.edit(qrc_file_path)
    local buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local end_of_recource = -1
    for i = #lines, 1, -1 do
        if string.find(lines[i], '</qresource>') then
            end_of_recource = i
            break
        end
    end
    local new_line = '<file>' .. relative_path .. '</file>'
    vim.api.nvim_buf_set_lines(buf, end_of_recource - 1, end_of_recource - 1, false, { new_line })
    vim.api.nvim_win_set_cursor(0, { end_of_recource, 0 })
    vim.cmd('normal! zz')
end

vim.keymap.set('n', '<leader>cq', addToQrc, { desc = 'Add to qml.qrc file', noremap = true })
