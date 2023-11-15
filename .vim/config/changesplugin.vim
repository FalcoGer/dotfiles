" https://github.com/chrisbra/changesPlugin
" :help ChangesPlugin

function! ToggleChangesDiffMode()
    " check if diff needs to be opened or closed
    " track open diff with a global variable
    " we could use a buffer variable, but this avoids having
    " multiple diff windows open, which makes no sense
    " it also avoids having to check if the current active
    " window is the diff itself

    let needsLoading = v:false

    " Check if the buffer was deleted by the user
    " If bdelete is called, the buffer still has information
    " which one can access with getbufinfo()
    if exists('g:changesdiffbuffer') && bufexists(g:changesdiffbuffer)
        if getbufinfo(g:changesdiffbuffer)[0]["loaded"] == 0
            " Buffer was deleted, clear the metadata and load a new one
            execute "bwipeout " . g:changesdiffbuffer
            let needsLoading = v:true
        else
            " Buffer is still alive, kill it
            let needsLoading = v:false
        endif
    else
        " brand new, create it
        let needsLoading = v:true
    endif

    if needsLoading == v:true
        " to track the buffer, we need to list all windows before we open t
        let before = getwininfo()
        execute "ChangesDiffMode"
        let after = getwininfo()
        " loop over after and find the one not in before
        for afterinfo in after
            " get winid
            let afterwinid = afterinfo["winid"]
            let found = v:false
            for beforeinfo in before
                let beforewinid = beforeinfo["winid"]
                if afterwinid == beforewinid
                    let found = v:true
                    break
                endif
            endfor
            if found == v:false
                let g:changesdiffbuffer = winbufnr(afterwinid)
                break
            endif
        endfor
    else
        " g:changesdiffbuffer exists, kill it and delete associated data
        exec "bwipeout " . g:changesdiffbuffer
    endif
endfunction

nnoremap <silent><C-d> :call ToggleChangesDiffMode()<CR>

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

let g:changes_add_sign = ' '
let g:changes_delete_sign = ' '
let g:changes_modified_sign = ' '

let g:changes_utf8_add_sign = ' '
let g:changes_utf8_delete_sign = ' '
let g:changes_utf8_modifed_sign = ' '

" maximum size in B for a buffer before this plugin doesn't check anymore
" Seems broken
" let g:changes_max_filesize = 50*1000

highlight ChangesSignTextAdd ctermbg=22 ctermfg=40 cterm=bold guibg=#005F00 guifg=#00DF00 gui=bold
highlight ChangesSignTextDel ctermbg=52 ctermfg=160 cterm=bold guibg=#5F0000 guifg=#DF0000
highlight ChangesSignTextCh  ctermbg=17 ctermfg=39 cterm=bold guibg=#001C30 guifg=#00AFFF gui=bold
" Consecutive changes
highlight ChangesSignTextDummyCh ctermbg=234 ctermfg=33 cterm=NONE guifg=#0087FF guibg=#1C1C1C gui=NONE
highlight ChangesSignTextDummyAdd ctermbg=234 ctermfg=28 cterm=NONE guifg=#008700 guibg=#1C1C1C gui=NONE
