" A fancy status line with colors and fancy fonts
" https://github.com/vim-airline/vim-airline
" :help airline

" The airline already shows the mode, no need to repeat it in a less pretty
" way
set noshowmode

" workaround for https://github.com/nvim-treesitter/nvim-treesitter-context/issues/300
" Don't use the tagbar extension, which is slow when used together with
" context
let g:airline#extensions#tagbar#enabled = 0

" This places the airline status line on top, making room for the default
" status line
let g:airline_statusline_ontop=0

" Accents documentation in this issue
" https://github.com/vim-airline/vim-airline/issues/299

let g:airline_powerline_fonts = 1
" let g:airline_symbols_ascii = 1

" Enable experimental features
let g:airline_experimental = 1

" detect modification
let g:airline_detect_modified=1
let g:airline_detect_paste=1
" detect encryption
let g:airline_detect_crypt=1
" detect if spellchecking is enabled
let g:airline_detect_spell=1
" show language when spelling is enabled (0/1/'flag')
let g:airline_detect_spelllang='flag'
" Detect iminsert mode
let g:airline_detect_iminsert=0
" Only show filename in inactive windows
let g:airline_inactive_collapse=1
" use alternative separator for inactive windows
let g:airline_inactive_alt_sep=1
" explicit theme, if undefined it is determined automatically
let g:airline_theme='dark'

" exclude preview windows from having a status line
let g:airline_exclude_preview = 0
" skips separators for empty sections
let g:airline_skip_empty_sections = 1
" skip a section if the section string matches this string
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ' :'
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.dirty='⚡'

let g:airline_mode_map = {
    \ 'niV': 'V REPLACE (NORMAL)',
    \ 's': 'SELECT',
    \ '^V': 'V-BLOCK',
    \ 'niI': 'INSERT (NORMAL)',
    \ 'ic': 'INSERT COMPL GENERIC',
    \ 'R': 'REPLACE',
    \ '^S': 'S-BLOCK',
    \ 'no': 'OP PENDING',
    \ 'V': 'V-LINE',
    \ 'multi': 'MULTI',
    \ 'cv': 'VIM EX',
    \ 'ce': 'EX',
    \ '__': '------',
    \ 'no^V': 'OP PENDING BLOCK',
    \ '!': 'SHELL',
    \ 'c': 'COMMAND',
    \ 'ix': 'INSERT COMPL',
    \ 'rm': 'MORE PROMPT',
    \ 'i': 'INSERT',
    \ 'Rv': 'V REPLACE',
    \ 'Rx': 'REPLACE COMP',
    \ 'n': 'NORMAL',
    \ 'niR': 'REPLACE (NORMAL)',
    \ 'r': 'PROMPT',
    \ 'S': 'S-LINE',
    \ 't': 'TERMINAL',
    \ 'v': 'VISUAL',
    \ 'r?': 'CONFIRM',
    \ 'noV': 'OP PENDING LINE',
    \ 'Rc': 'REPLACE COMP GENERIC',
    \ 'nov': 'OP PENDING CHAR'
    \ }

