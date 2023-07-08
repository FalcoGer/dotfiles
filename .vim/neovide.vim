set guifont=MesloLGS\ NF:h10.5
set linespace=0
let g:neovide_scale_factor=1.0

" Paste text in normal mode
nmap <C-V> "+p
" Paste text in command mode
cmap <C-V> <C-r>+
" Paste text in insert mode
imap <C-V> <C-r>+
" Paste text in terminal mode
" TODO, doesn't work
" tmap <C-V> <ESC>"+pi

inoremap <c-v> <c-r>+
cnoremap <c-v> <c-r>+
" use <c-r> to insert original character without triggering things like auto-pairs
inoremap <c-r> <c-v>

