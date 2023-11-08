" Configuration for coc completer

if !has('nvim')
    set encoding=utf-8
endif

" Some servers have issues with backup files, see #649
" set nobackup
" set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

" Old setting, without coc-snippets
" inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#pum#next(1) :
"       \ CheckBackspace() ? "\<Tab>" :
"       \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> <C-Up>    <Plug>(coc-diagnostic-prev)
nmap <silent> <C-Down>  <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup CocConfigGroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <C-Space>  <Plug>(coc-codeaction-cursor)
xmap <C-Space>  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
nmap <leader>ca  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
xmap <silent> <S-Space>  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <S-Space>  <Plug>(coc-codeaction-refactor)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" Yank List (coc-yank plugin)
" nnoremap <silent><nowait> <space>y  :<C-u>CocList -A --normal yank<cr>
nnoremap <silent><nowait> <space>y  :<C-u>CocList -A yank<cr>
nnoremap <silent><nowait> <C-y>     :<C-u>CocList -A yank<cr>

" :help coc-highlight
" Unused code, etc
highlight CocFadeOut ctermfg=238 guifg=#444444

highlight CocErrorLine ctermbg=52 guibg=#5F0000
highlight CocErrorSign ctermfg=9 guifg=#FF0000
highlight CocErrorVirtualText ctermfg=9 ctermbg=235 guifg=#FF0000 guibg=#262626 gui=underdotted guisp=#444444

highlight CocWarningLine ctermbg=58 guibg=#262600
highlight CocWarningSign ctermfg=11 guifg=#FFFF00
highlight CocWarningVirtualText ctermfg=11 ctermbg=235 guifg=#FFFF00 guibg=#262626 gui=underdotted guisp=#444444

" highlight CocInfoLine ctermbg=17 guibg=#00005F
highlight CocInfoLine ctermbg=NONE guibg=#00005F
highlight CocInfoSign ctermfg=12 guifg=#0000FF
highlight CocInfoVirtualText ctermfg=12 ctermbg=235 guifg=#0000FF guibg=#262626 gui=underdotted guisp=#444444

" highlight CocHintLine ctermfg=23 guibg=#005F5F
highlight CocHintLine ctermbg=NONE guibg=#002626
highlight CocHintSign ctermfg=51 guifg=#00FFFF
highlight CocHintVirtualText ctermfg=6 ctermbg=235 guifg=#008080 guibg=#262626 gui=underdotted guisp=#444444

" Highlighting same symbol as the one on cursor position
highlight CocHighlightText ctermbg=236 guisp=#808080 gui=underdouble
highlight CocHighlightRead ctermbg=17 guisp=#00FF80 gui=underdouble
highlight CocHighlightWrite ctermbg=53 guisp=#FF8000 gui=underdouble
" Floating windows and popups
" CocFloating links to NormalFloat in neovim and Pmenu in vim
highlight link CocFloatThumb PmenuThumb
highlight link CocFloatSbar PmenuSbar
highlight link CocHintFloat NormalFloat

" hints
highlight CocInlayHint ctermfg=6 ctermbg=235 guifg=#008080 gui=underdotted guisp=#444444
highlight CocInlayHintParameter ctermfg=2 ctermbg=235 guifg=#008000 gui=underdotted guisp=#444444
highlight CocInlayHintType ctermfg=5 ctermbg=235 guifg=#800080 gui=underdotted guisp=#444444

" Notifications
" Progress line in progress notifications
highlight CocNotificationProgress ctermfg=4 guifg=#000080 ctermbg=235 guibg=#262626
" Action buttons in notification windows
highlight CocNotificationButton ctermfg=7 guifg=#C0C0C0 ctermbg=237 guibg=#3A3A3A
" Borders for Error/Warning/Info notifications
highlight link CocNotificationError CocErrorSign
highlight link CocNotificationWarning CocWarningSign
highlight link CocNotificationInfo CocInfoSign

" Selected entry in menu dialogues (only BG)
highlight CocMenuSel guibg=#402000 ctermbg=58

" List related
highlight CocSearch ctermfg=11 guisp=#FFFF00 gui=underdashed
highlight CocListLine ctermbg=235 guibg=#262626 ctermfg=228 guisp=#FFFF87 cterm=underline gui=underline
highlight link CocListSearch CocSearch

" Popup menu related
" highlight link CocPumSearch CocSearch

