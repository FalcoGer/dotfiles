" https://github.com/Shougo/unite.vim

if has('nvim')
    lua vim.keymap.set('n', '<S-u>', ':Unite<CR>', { silent = true, desc = "Unite", noremap = true })
    lua vim.keymap.set('n', '<Space>u', ':Unite<CR>', { silent = true, desc = "Unite", noremap = true, nowait = true })
else
    nnoremap <silent><S-u>             :Unite<CR>
    nnoremap <silent><nowait> <Space>u :Unite<CR>
endif
