" https://github.com/preservim/tagbar
" TagBar shows symbols for the current file in a list

" workaround for https://github.com/nvim-treesitter/nvim-treesitter-context/issues/300
" When opening tagbar, close the context.
if exists('g:user_loaded_treesitter_context')
    let g:user_tagbar_open=0
    function! UserToggleTagbar()
        if g:user_tagbar_open==0
            TagbarOpen
            let g:user_tagbar_open=1
            if exists('g:user_tscontext_enabled')
                if g:user_tscontext_enabled == 1
                    TSContextDisable
                endif
            endif
        else
            TagbarClose
            let g:user_tagbar_open=0
            if exists('g:user_tscontext_enabled')
                if g:user_tscontext_enabled == 1
                    TSContextEnable
                endif
            endif
        endif
    endfunction
    nnoremap <silent><C-t> :call UserToggleTagbar()<CR>
else
    nnoremap <silent><C-t> :TagbarToggle<CR>
endif
