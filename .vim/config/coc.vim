" Configuration for coc completer

augroup CocAutoExtension
    autocmd!
    autocmd FileType text           call CocActionAsync('activeExtension', 'coc-ltex')
    autocmd FileType lua            call coc#config('Lua.workspace.library', nvim_get_runtime_file('', 1))
augroup end

if !has('nvim')
    set encoding=utf-8
endif

" Some servers have issues with backup files, see #649
" set nobackup
" set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! CocTab()
    if coc#pum#visible()
        return coc#_select_confirm()
    elseif coc#expandableOrJumpable()
        return "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>"
    elseif CheckBackspace()
        return "\<TAB>"
    else
        return coc#refresh()
    endif
endfunction

function! CocSTab()
    if coc#pum#visible()
        return coc#pum#prev(1)
    else
        return "\<C-h>"
    endif
endfunction

function! CocEnter()
    if coc#pum#visible()
        return coc#pum#confirm()
    else
        return "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"
    endif
endfunction

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

if !has('nvim')
    " Use tab for trigger completion with characters ahead and navigate
    " NOTE: There's always complete item selected by default, you may want to enable
    " no select by `"suggest.noselect": true` in your configuration file
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config
    inoremap <silent><expr> <TAB> CocTab()

    " Old setting, without coc-snippets
    " inoremap <silent><expr> <TAB>
    "       \ coc#pum#visible() ? coc#pum#next(1) :
    "       \ CheckBackspace() ? "\<Tab>" :
    "       \ coc#refresh()
    inoremap <expr><S-TAB> CocSTab()

    " Make <CR> to accept selected completion item or notify coc.nvim to format
    " <C-g>u breaks current undo, please make your own choice
    inoremap <silent><expr> <CR> CocEnter()

    inoremap <silent><expr> <C-Space> coc#refresh()

    " Use `[g` and `]g` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)
    "nmap <silent> <C-Up>    <Plug>(coc-diagnostic-prev)
    "nmap <silent> <C-Down>  <Plug>(coc-diagnostic-next)
    nmap <silent> <C-Up>    :CocCommand document.jumpToNextSymbol<CR>
    nmap <silent> <C-Down>  :CocCommand document.jumpToPrevSymbol<CR>

    " GoTo code navigation
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window
    nnoremap <silent> K :call ShowDocumentation()<CR>

    " Symbol renaming
    nmap <silent> <leader>rn <Plug>(coc-rename)

    " Formatting selected code
    xmap <silent> <leader>f  <Plug>(coc-format-selected)
    nmap <silent> <leader>f  <Plug>(coc-format-selected)
    nmap <silent> <leader>ff <Plug>(coc-format)

    " Applying code actions to the selected code block
    " Example: `<leader>aap` for current paragraph
    xmap <silent> <leader>a  <Plug>(coc-codeaction-selected)
    nmap <silent> <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying code actions at the cursor position
    nmap <silent> <C-Space>  <Plug>(coc-codeaction-cursor)
    xmap <silent> <C-Space>  <Plug>(coc-codeaction-selected)
    nmap <silent> <leader>ac  <Plug>(coc-codeaction-cursor)
    nmap <silent> <leader>ca  <Plug>(coc-codeaction-cursor)
    " Remap keys for apply code actions affect whole buffer
    nmap <silent> <leader>as  <Plug>(coc-codeaction-source)
    " Apply the most preferred quickfix action to fix diagnostic on the current line
    nmap <silent> <leader>qf  <Plug>(coc-fix-current)

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
      vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
      nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
      vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
      inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    endif

    " Use CTRL-S for selections ranges
    " Requires 'textDocument/selectionRange' support of language server
    nmap <silent> <C-s> <Plug>(coc-range-select)
    xmap <silent> <C-s> <Plug>(coc-range-select)

    " Mappings for CocList
    nnoremap <silent><nowait> <space>l  :<C-u>CocList<cr>
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
    " git list (coc-git)
    nnoremap <silent><nowait> <space>g  :<C-u>CocList gchunks<cr>
else
    source ~/.vim/config/coc-keybinds.lua
endif

function! SetProjectRoot(file)
    echo "Running SetProjectRoot"
    if exists('g:WorkspaceFolders')
        for wsDir in g:WorkspaceFolders
            " Search for path name in the file path.
            if match(a:file, wsDir, 0) == 0
                let b:project_root = wsDir
                echo "Set Workspace to " . wsDir
                return
            endif
        endfor
    end
    echo "Didn't find project root"
endfunction

augroup CocConfigGroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setlocal formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " Highlight the symbol and its references when holding the cursor
  autocmd CursorHold * silent call CocActionAsync('highlight')
  " AutoCmd to set current workspace root for buffer
  autocmd FileReadPost * call SetProjectRoot(expand('%:p'))
augroup end

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
" This switches foldmethod to manual
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" :help coc-highlight
" Unused code, etc
highlight link CocFadeOut DiagnosticUnnecessary
highlight link CocDeprecatedHighlight DiagnosticDeprecated

" sign background from .vimrc SignColumn
highlight CocErrorLine ctermbg=52 guibg=#5F0000
highlight link CocErrorSign DiagnosticSignError
highlight link CocErrorVirtualText DiagnosticVirtualTextError

highlight CocWarningLine ctermbg=58 guibg=#402000
highlight link CocWarningSign DiagnosticSignWarn
highlight link CocWarningVirtualText DiagnosticVirtualTextWarn

highlight CocInfoLine ctermbg=17 guibg=#1C1C30
highlight link CocInfoSign DiagnosticSignInfo
highlight link CocInfoVirtualText DiagnosticVirtualTextInfo

highlight CocHintLine ctermbg=NONE guibg=#1C3030
highlight link CocHintSign DiagnosticSignHint
highlight link CocHintVirtualText DiagnosticVirtualTextHint


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
highlight CocNotificationProgress ctermfg=4 guifg=#00FFFF ctermbg=235 guibg=#262626
" Action buttons in notification windows
highlight CocNotificationButton ctermfg=7 guifg=#C0C0C0 ctermbg=237 guibg=#3A3A3A
" Borders for Error/Warning/Info notifications
highlight link CocNotificationError CocErrorSign
highlight link CocNotificationWarning CocWarningSign
highlight link CocNotificationInfo CocInfoSign

" Selected entry in menu dialogues (only BG)
highlight link CocMenuSel PmenuSel

" List related
highlight link CocSearch Search
highlight link CocListLine CocMenuSel
highlight link CocListSearch CocSearch

" Popup menu related
" highlight link CocPumSearch CocSearch
