-- fuck out of insert mode
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true })
vim.keymap.set('i', 'kj', '<Esc>', { noremap = true })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<M-n>', function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { desc = 'Goto next diagnostic' })
vim.keymap.set('n', '<M-p>', function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { desc = 'Goto previous diagnostic' })

--  Use CTRL+<hjkl> to navigate in insert mode
vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-k>', '<Up>')
vim.keymap.set('i', '<C-l>', '<Right>')

--center cursor after pageUp pageDown
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

--Yank to end of line
vim.keymap.set('n', 'Y', 'y$', { noremap = true })

--Yank and paste to and from system clipboard
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+y$')

--Delete to void by default
vim.keymap.set('x', 'p', '"_dP', { desc = 'Paste without yanking (visual mode)', noremap = true })
vim.keymap.set('x', '<leader>p', 'p', { desc = 'Paste and yank replaced text (visual mode)' })
vim.keymap.set('n', 'd', '"_d')
vim.keymap.set('v', 'd', '"_d')
vim.keymap.set('n', '<leader>d', 'd')
vim.keymap.set('v', '<leader>d', 'd')
vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('n', 's', '"_s')
vim.keymap.set('n', 'D', '"_D')
vim.keymap.set('n', '<leader>D', 'D')

--place search results in the middle of a screen
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

--move line up and down in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

--Split keymaps
--
-- Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<M-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<M-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<M-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<M-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
--open, close, resize
vim.keymap.set('n', '<leader>sv', ':vsplit<CR>', { desc = 'Add verticatl split', silent = true })
vim.keymap.set('n', '<leader>sh', ':split<CR>', { desc = 'Add horizontal split', silent = true })
vim.keymap.set('n', '<leader>sc', ':close<CR>', { desc = 'Close split', silent = true })
vim.keymap.set('n', '<M-=>', ':vertical resize +2<CR>', { silent = true })
vim.keymap.set('n', '<M-->', ':vertical resize -2<CR>', { silent = true })
vim.keymap.set('n', '<M-+>', ':vertical resize +2<CR>', { silent = true })
vim.keymap.set('n', '<M-_>', ':vertical resize -2<CR>', { silent = true })

--quickfix list navigation
vim.keymap.set('n', '<M-s>', '<Cmd>cprev<CR>', { desc = 'prev in quickfix list' })
vim.keymap.set('n', '<M-d>', '<Cmd>cnext<CR>', { desc = 'next in quickfix list' })
