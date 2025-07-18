local getLineIndexToInsert = function(scope)
    local buf = vim.api.nvim_get_current_buf()
    local scope_keywords = { 'public:', 'private:', 'protected:', 'signals:', 'slots:' }

    for i = 1, #scope_keywords do
        if scope_keywords[i] == scope then
            table.remove(scope_keywords, i)
            break
        end
    end

    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local endOfScope = -1
    local inScope = false
    for i, line in ipairs(lines) do
        if inScope then
            for _, other_scope in ipairs(scope_keywords) do
                if string.find(line, other_scope) then
                    endOfScope = i - 1
                    goto endOfLoop
                end
            end
        else
            if string.find(line, scope) then
                inScope = true
            end
        end
    end
    ::endOfLoop::

    if inScope == false then
        endOfScope = #lines - 1
        vim.api.nvim_buf_set_lines(buf, endOfScope, endOfScope, false, { '' })
        vim.api.nvim_buf_set_lines(buf, endOfScope + 1, endOfScope + 1, false, { scope })
        vim.api.nvim_buf_set_lines(buf, endOfScope + 2, endOfScope + 2, false, { '' })
        return endOfScope + 2
    end

    if endOfScope == -1 then
        endOfScope = #lines - 1
    end

    if lines[endOfScope] == '' then
        return endOfScope - 1
    else
        vim.api.nvim_buf_set_lines(buf, endOfScope, endOfScope, false, { '' })
        return endOfScope
    end
end

local insertLines = function(name, type, includeSetter, includeWriteBlock)
    local buf = vim.api.nvim_get_current_buf()
    local capitalName = name:gsub('^%l', string.upper)

    if name ~= nil and name ~= '' then
        local new_line = 'Q_PROPERTY(' .. type .. ' ' .. name .. ' READ ' .. name
        if includeWriteBlock then
            new_line = new_line .. ' WRITE set' .. capitalName
        end
        new_line = new_line .. ' NOTIFY ' .. name .. 'Changed)'
        vim.api.nvim_set_current_line(new_line)

        local pub_index = getLineIndexToInsert('public:')
        new_line = type .. ' ' .. name .. '() const;'
        vim.api.nvim_buf_set_lines(buf, pub_index, pub_index, false, { new_line })
        if includeSetter then
            new_line = 'void set' .. capitalName .. '(const ' .. type .. '& new' .. capitalName .. ');'
            vim.api.nvim_buf_set_lines(buf, pub_index + 1, pub_index + 1, false, { new_line })
        end

        local signals_index = getLineIndexToInsert('signals:')
        new_line = 'void ' .. name .. 'Changed();'
        vim.api.nvim_buf_set_lines(buf, signals_index, signals_index, false, { new_line })

        local private_index = getLineIndexToInsert('private:')
        new_line = type .. ' m_' .. name .. ';'
        vim.api.nvim_buf_set_lines(buf, private_index, private_index, false, { new_line })
    end
end

local createPropertyImplimentation = function(hasSetter, fileName, type, name)
    local cwd = vim.fn.getcwd()

    local filePath = vim.fn.glob(cwd .. '/**/' .. fileName, true, false)
    local className = fileName:gsub('%.%w+$', '')
    local capitalName = name:gsub('^%l', string.upper)

    if filePath ~= '' then
        local file = io.open(filePath, 'a') -- "a" = append mode
        if file then
            local poropertyImplimentation = '\n' .. type .. ' ' .. className .. '::' .. name .. '() const\n{\n    return m_' .. name .. ';\n}'
            if hasSetter then
                poropertyImplimentation = poropertyImplimentation
                    .. '\n\nvoid '
                    .. className
                    .. '::set'
                    .. capitalName
                    .. '(const '
                    .. type
                    .. '& new'
                    .. capitalName
                    .. ')\n{\n    if(m_'
                    .. name
                    .. ' == new'
                    .. capitalName
                    .. ')\n'
                    .. '        return;\n    m_'
                    .. name
                    .. ' = new'
                    .. capitalName
                    .. ';\n    emit '
                    .. name
                    .. 'Changed();\n}\n'
            end
            file:write(poropertyImplimentation)
            file:close()
            vim.cmd.edit(filePath)
        else
            print('❌ Failed to open file: ' .. filePath)
        end
    else
        print('❌ File not found: ' .. fileName)
    end
end

local createQproperty = function()
    local type = vim.fn.expand('<cword>') -- Get word under cursor

    vim.ui.input({ prompt = "Create Q_Property of type '" .. type .. "' and name: " }, function(name)
        if name == nil then
            return
        end

        vim.ui.input({ prompt = 'Create setter? [Y]es/[N]o/yes but [W]ithout WRITE in Q_PROPERTY: ' }, function(answer)
            local hasSetter = true
            if answer == 'Y' or answer == 'y' then
                insertLines(name, type, true, true)
            elseif answer == 'N' or answer == 'n' then
                insertLines(name, type, false, false)
                hasSetter = false
            elseif answer == 'W' or answer == 'w' then
                insertLines(name, type, true, false)
            else
                return
            end

            local fileName = vim.fn.expand('%:t')
            fileName = fileName:gsub('%.h$', '.cpp')
            local prompt = 'Add default implimentation of getter '
            if hasSetter then
                prompt = prompt .. 'and setter '
            end
            prompt = prompt .. 'in ' .. fileName .. '? [Y]es/[N]o: '
            vim.ui.input({ prompt = prompt }, function(second_answer)
                if second_answer == 'Y' or second_answer == 'y' then
                    createPropertyImplimentation(hasSetter, fileName, type, name)
                else
                    return
                end
            end)
        end)
    end)
end

vim.keymap.set('n', '<leader>cp', createQproperty, { desc = 'Create Q_Property', noremap = true })
