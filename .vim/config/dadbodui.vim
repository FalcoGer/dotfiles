" https://github.com/kristijanhusak/vim-dadbod-ui

if !has('nvim')
    nnoremap <silent> <Leader>db :DBUIToggle<CR>
else
    lua vim.keymap.set('n', '<Leader>db', ':DBUIToggle<CR>', { noremap = true, silent = true, desc = "DB UI - Toggle" })
endif
let g:db_ui_icons = {
    \ 'expanded': '▾',
    \ 'collapsed': '▸',
    \ 'saved_query': '*',
    \ 'new_query': '+',
    \ 'tables': '~',
    \ 'buffers': '»',
    \ 'connection_ok': '✓',
    \ 'connection_error': '✕',
    \ }

let g:db_ui_auto_execute_table_helpers = 1

let g:db_ui_show_help = 1

let g:db_ui_winwidth = 50
