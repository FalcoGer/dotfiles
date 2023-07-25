nnoremap <silent><S-c> :ContextToggle<CR>

" enable context pinning
let g:context_enabled = 1

" the filetypes for which it is disabled
let g:context_filetype_blacklist = []

" create default mappings for all commands that scroll the buffer
let g:context_add_mappings = 1

" create autocmds for groups that might scroll the buffer (like cursor moved)
let g:context_add_autocmds = 1

" how context is presented. "nvim-float", "vim-popup" or "preview"
if has('nvim')
    let g:context_presenter = "nvim-float"
else
    let g:context_presenter = "vim-popup"
endif

" Show only the first max_height / 2, then ..., then the last max_height / 5
let g:context_max_height = 10

" Show only the first and last few lines per indent
let g:context_max_per_indent = 5

" Join parts, for example the curly opening brace in a c style program would
" be shifted to the line of the control statement. This value determines how
" long that joined part is at most.
let g:context_max_join_parts = 5

" chars to use
let g:context_ellipsis_char = '·'
let g:context_border_char = '━'

" highlights
let g:context_highlight_normal = 'Normal'
let g:context_highlight_border = 'Comment'
let g:context_highlight_tag    = 'Special'

" If a line matches this regex then it is completely ignored for context
" building.
" Skip empty lines, comments and C preprocessor statements
let g:context_skip_regex = '^\s*\($\|#\|//\|/\*\|\*\($\|/s\|\/\)\)'

" Keep parsing the same indent if a line matches this regex.
" For example the previous if is in the same context as the else
let g:context_extend_regex = '^\s*\([]{})]\|end\|else\|case\>\|default\>\)'

" Context is joined if a line matches this regex.
" Any line that has no word characters.
let g:context_join_regex = '^\W*$'

" Build context based on the indentation
let g:Context_indent = { line -> [indent(line), indent(line)] }

" Put the floating window context on the same indent level
" This line causes the autocmds to fail.
" let g:Context_border_indent = function('indent')
