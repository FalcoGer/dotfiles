" Next/Previous matching word
nnoremap <silent><M-Down> <Plug>(matchup-%)
nnoremap <silent><M-Up> <Plug>(matchup-g%)

let g:matchup_matchparen_enabled = 1

" one of "status", "popup", "status_manual", "scrolloff" or empty dictionary
" for disabled.
let g:matchup_matchparen_offscreen = {'method': 'popup'}

" How many lines to search for matching words in either direction.
" Default 400
let g:matchup_matchparen_stopline = 200

" timeout in ms for matching
let g:matchup_matchparen_timeout = 300
let g:matchup_matchparen_insert_timeout = 60

" If enabled  wait with the highlight until the cursor stops moving.
" Default: 0
let g:matchup_matchparen_deferred = 1

" Show surrounding delimiters as the cursor moves
" Requires deferred highlighting
" Default: 0
let g:matchup_matchparen_hi_surround_always = 0

" Vim by default goes to N % of the file if <N>% is typed.
" For small N, matchup overrides this behavior. This is the limit.
" Use 0 to disable the feature
" Use 100 to enable always.
" Default: 6
let g:matchup_motion_override_Npercent = 0 " Custom keybind <M-Up/Down>

" If true, will make cursor move to the beginning of the words when moving up
" and to the end of mid and closing words when moving down.
let g:matchup_motion_cursor_end = 1

" Highlights.
highlight MatchParen ctermbg=blue cterm=underdashed gui=underdashed guisp=yellow
highlight MatchWord ctermfg=blue cterm=underdashed gui=underdashed guisp=yellow
highlight MatchParenCur cterm=underdashed gui=underdashed guisp=yellow
highlight MatchWordCur cterm=underdashed gui=underdashed guisp=yellow

