local subInLine = function()
    local cur_word = vim.fn.expand('<cword>') -- Get word under cursor
    vim.ui.input({ prompt = "Remap '" .. cur_word .. "' in line to: ", default = cur_word }, function(new_word)
        if new_word == '' or new_word == cur_word or new_word == nil then
            return -- Do nothing if cancelled or unchanged
        end
        -- Get current line
        local line_num = vim.api.nvim_win_get_cursor(0)[1]
        local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
        -- Escape Lua pattern characters in current word
        local pattern = vim.pesc(cur_word)
        -- Replace all occurrences
        local new_line = line:gsub(pattern, new_word)
        -- Set the new line
        vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, { new_line })
    end) -- Prompt with default value
end

local subInFile = function()
    local cur_word = vim.fn.expand('<cword>') -- Get word under cursor
    vim.ui.input({ prompt = "Remap '" .. cur_word .. "' in file to: ", default = cur_word }, function(new_word)
        if new_word == '' or new_word == cur_word or new_word == nil then
            return -- Do nothing if cancelled or unchanged
        end
        local buf = vim.api.nvim_get_current_buf()
        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)

        for i, line in ipairs(lines) do
            lines[i] = line:gsub(vim.pesc(cur_word), new_word)
        end

        vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    end) -- Prompt with default value
end

-- Changing all occurrences of 'word1' in line to 'word2'
vim.keymap.set('n', '<leader>rl', subInLine, { desc = 'Replace word in line', noremap = true, silent = true })

-- Changing all occurrences of 'word1' in file to 'word2'
vim.keymap.set('n', '<leader>rf', subInFile, { desc = 'Replace word in file', noremap = true, silent = true })
