-- Function to toggle between header and source file
local function toggleSourceHeader()
    -- Detect OS
    local sep
    if os.getenv('OS') == 'Windows_NT' then
        sep = '\\'
    else
        sep = '/'
    end

    -- Get absolute path of current file
    local filepath = vim.fn.expand('%:p')

    -- Normalize path to always use /
    local normalized = filepath:gsub('[/\\]', '/')

    local ext = vim.fn.expand('%:e')

    -- Only handle .h and .cpp files
    if ext ~= 'h' and ext ~= 'cpp' then
        print('Not a .h or .cpp file')
        return
    end

    -- Remove extension
    local base = normalized:gsub('%.' .. ext .. '$', '')

    -- Switch between src and include
    if base:find('/src/') then
        base = base:gsub('/src/', '/include/')
        base = base .. '.h'
    elseif base:find('/include/') then
        base = base:gsub('/include/', '/src/')
        base = base .. '.cpp'
    else
        print('Path must contain /src/ or /include/')
        return
    end

    -- Restore OS-specific separator
    if sep == '\\' then
        base = base:gsub('/', '\\')
    end

    -- Open or create the file
    vim.cmd('edit ' .. base)
end

vim.keymap.set('n', '<leader>gh', toggleSourceHeader, { desc = 'Toggle between .h and .cpp' })
