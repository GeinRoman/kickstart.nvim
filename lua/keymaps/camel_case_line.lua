vim.keymap.set('n', '<leader>tcc', [[:s/\v<(\w)(\w*)/\u\1\L\2/g | s/\s\+//g<CR><cmd>nohlsearch<CR>]], { desc = 'Line to CamelCase', noremap = true })
