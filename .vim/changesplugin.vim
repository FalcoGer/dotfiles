" https://github.com/chrisbra/changesPlugin
" :help ChangesPlugin

" automatically update the view
let g:changes_autocmd = 1

" Check VCS (git)?, experimental feature
let g:changes_vcs_check = 1
" leave empty for auto detect, see :help ChangesPlugin-VCS
let g:changes_vcs_system = ''

" Show diff in preview window
let g:changes_diff_preview = 0

" If set, will not reset highlight of sign column to normal hl group
let g:changes_respect_SignColumn = 1

" highlight lines, experimental
let g:changes_linehi_diff = 0

" use fancy symbols
let g:changes_sign_text_utf8 = 1

" let g:changes_add_sign='+'
" let g:changes_delete_sign='-'
" let g:changes_modified_sign='*'

let g:changes_add_sign = ''
let g:changes_delete_sign = ''
let g:changes_modified_sign = ''

let g:changes_utf8_add_sign = ''
let g:changes_utf8_delete_sign = ''
let g:changes_utf8_modifed_sign = ''


" maximum size in kB for a buffer before this plugin doesn't check anymore
let g:changes_max_filesize = 5

" highlight SignColumn ctermfg=51 ctermbg=234 guifg=#00FFFF guibg=#1C1C1C

highlight ChangesSignTextAdd ctermbg=22 ctermfg=40 cterm=bold guibg=#005F00 guifg=#00DF00 gui=bold
highlight ChangesSignTextDel ctermbg=52 ctermfg=160 cterm=bold guibg=#5F0000 guifg=#DF0000
highlight ChangesSignTextCh  ctermbg=17 ctermfg=39 cterm=bold guibg=#001C30 guifg=#00AFFF gui=bold
" Consecutive changes
highlight ChangesSignTextDummyCh ctermbg=234 ctermfg=33 cterm=NONE guifg=#0087FF guibg=#1C1C1C gui=NONE

highlight ChangesSignTextDummyAdd ctermbg=234 ctermfg=28 cterm=NONE guifg=#008700 guibg=#1C1C1C gui=NONE
