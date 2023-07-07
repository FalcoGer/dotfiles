" NVimTree stuff here. See :help NERD_tree.txt
source ~/.vim/nvimtree.lua

" Start NVimTree when Vim is started without file arguments.
augroup NVimTreeAuto
    autocmd!
    " Automatically open ntree when opening vim without arguments
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NvimTreeOpen | endif
augroup END

" Easy toggle command for NVimTree
cnoreabbrev nt NvimTreeFocus
cnoreabbrev nf NvimTreeFindFile

