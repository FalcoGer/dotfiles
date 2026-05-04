" Easy hex editor

let &bin=0
let hexGroupSize=1
let hexColumnSize=16
cnoreabbrev hex if ! &bin <bar> redir => modi <bar> silent set modified? <bar> redir END <bar> execute 'silent %!xxd -g ' . hexGroupSize . ' -c ' . hexColumnSize . ' -u' <bar> redir => snapshot <bar> silent set spell? <bar> silent set filetype? <bar> redir END <bar> silent set filetype=xxd <bar> silent set nospell <bar> let &bin=1 <bar> execute "silent set " . modi[1:] <bar> else <bar> echo "Is already hexed." <bar> endif

cnoreabbrev unhex if &bin <bar> redir => modi <bar> silent set modified? <bar> redir END <bar> execute 'silent %!xxd -g ' . hexGroupSize . ' -c ' . hexColumnSize . ' -u -r' <bar> for opt in split(snapshot,'\n') <bar> execute "silent set " . opt <bar> endfor <bar> let &bin=0 <bar> execute ("silent set " . modi[1:]) <bar> else <bar> echo "Is already unhexed." <bar> endif

augroup Binary
    autocmd!
    " Automatic loading of bin files in hex
    autocmd BufReadPre      *.bin   let &bin=1
    autocmd BufReadPre      *.img   let &bin=1
    
    autocmd BufReadPost     *       if &bin | %!xxd -g 4 -c 16 -u
    autocmd BufReadPost     *       set ft=xxd | set nospell | redir => snapshot | silent set filetype? | silent set spell? | redir END | endif
    " Automatic writing in not hex
    autocmd BufWritePre     *       if &bin | %!xxd -g 4 -c 16 -u -r
    autocmd BufWritePre     *       endif
    autocmd BufWritePost    *       if &bin | %!xxd -g 4 -c 16 -u
    autocmd BufWritePost    *       set nomod | endif
augroup END

