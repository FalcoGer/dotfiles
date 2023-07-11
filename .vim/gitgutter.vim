" https://github.com/airblade/vim-gitgutter

nnoremap <silent><C-g> :GitGutterBufferToggle<CR>

let g:gitgutter_enabled = 1
let g:gitgutter_signs = 1
let g:gitgutter_max_signs = -1   " -1 for no limit
let g:gitgutter_highlight_lines = 0
let g:gitgutter_highlight_linenrs = 1
let g:gitgutter_async = 1

" 1 prevents staging hunks via the preview window
let g:gitgutter_preview_win_floating = 1
" if 0, uses quickfix list
let g:gitgutter_use_location_list = 0



" nvim has signcolumn=auto options, so multiple signs can be placed
if has('nvim')
    let g:gitgutter_sign_allow_clobber = 1
else
    let g:gitgutter_sign_allow_clobber = 0
endif

" match signcolumn background
let g:gitgutter_set_sign_backgrounds = 1

highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" highlight GitGutterAddLine          " default: links to DiffAdd
" highlight GitGutterChangeLine       " default: links to DiffChange
" highlight GitGutterDeleteLine       " default: links to DiffDelete
" highlight GitGutterChangeDeleteLine " default: links to GitGutterChangeLine, i.e. DiffChange

" highlight GitGutterAddIntraLine    " default: gui=reverse cterm=reverse
" highlight GitGutterDeleteIntraLine " default: gui=reverse cterm=reverse

let g:gitgutter_sign_added = ' '
let g:gitgutter_sign_modified = ' '
let g:gitgutter_sign_removed = ' '
let g:gitgutter_sign_removed_first_line = '󰜝'
let g:gitgutter_sign_removed_above_and_below = '󰜘'
let g:gitgutter_sign_modified_removed = '󰜙'

let g:gitgutter_diff_relative_to = 'working_tree' " "index" or "working_tree"
" let g:gitgutter_diff_base = '<COMMIT_SHA>'


