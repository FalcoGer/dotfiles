" https://github.com/kristijanhusak/vim-dadbod-ui

nnoremap <silent> <Leader>db :DBUIToggle<CR>

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

let g:db_ui_auto_execute_table_helpers = 0

let g:db_ui_show_help = 1

let g:db_ui_winwidth = 50
