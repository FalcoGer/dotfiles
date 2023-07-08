set guifont=MesloLGS\ NF:h10.5
set linespace=0
let g:neovide_scale_factor=1.0

" Paste text in terminal mode
" TODO, doesn't work
" tnoremap <C-V> <ESC>"+pi

" Paste text in normal mode
nnoremap <C-V> "+p
" Paste text in insert mode
inoremap <c-v> <c-r>+
" Paste text in command mode
cnoremap <c-v> <c-r>+

