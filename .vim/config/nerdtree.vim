" NerdTree stuff here. See :help NERD_tree.txt

" Start NERDTree when Vim is started without file arguments.
augroup NerdTreeAuto
    autocmd!
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

    " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
    autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
            \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
augroup END
" Automatically show hidden files
" Toggle with Shift + I
let NERDTreeShowHidden=1

" Easy toggle command for NerdTree
cnoreabbrev nt NERDTreeToggle

