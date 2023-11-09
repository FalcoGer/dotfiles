" https://github.com/Raimondi/delimitMate
" :help delimitMate-contents

" Closing braces interferes with ts_autotag


" Turns off the script if set to 1
" let loaded_delimitMate=0

" Tells delimitMate whether to automagically
" insert the closing delimiter.
" let delimitMate_autoclose=1

" workaround until
" https://github.com/windwp/nvim-ts-autotag/issues/146
" is resolved
if (exists('g:user_loaded_ts_autotag'))
    " 'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx',
    " "'rescript', 'xml', 'php', 'markdown', 'astro', 'glimmer', 'handlebars', 'hbs'

    augroup DelimitMateAutoCloseDisable
        autocmd!
        autocmd FileType html let b:delimitMate_autoclose=0
    augroup end
endif


" Tells delimitMate which characters are matching pairs.
" let delimitMate_matchpairs=

" Tells delimitMate which quotes should used.
" let delimitMate_quotes=

" Tells delimitMate which quotes should be allowed to be nested.
" let delimitMate_nesting_quotes=

" Turns on/off the expansion of <CR>.
let delimitMate_expand_cr=0

" Turns on/off the expansion of <Space>.
let delimitMate_expand_space=0

" Turns on/off jumping over expansions.
let delimitMate_jump_expansion=0

" Turns on/off the "smart quotes" feature.
let delimitMate_smart_quotes='\%(\w\|[^[:punct:][:space:]]\|\%(\\\\\)*\\\)\%#\|\%#\%(\w\|[^[:space:][:punct:]]\)'

" Turns on/off the "smart matchpairs" feature.
let delimitMate_smart_matchpairs='^\%(\w\|\!\|[£$]\|[^[:space:][:punct:]]\)'

" on/off the "balance matching pairs" feature.
let delimitMate_balance_matchpairs=1

" Turns off the script for the given regions or
" syntax group names.
let delimitMate_excluded_regions='Comment'

" Turns off the script for the given file types.
let delimitMate_excluded_ft=''

" Adds end of line marker
let delimitMate_insert_eol_marker=1

" Determines what to insert after the closing
" matchpair when typing an opening matchpair on
" the end of the line.
let delimitMate_eol_marker=''



" Tells delimitMate how it should "fix"
" balancing of single quotes when used as
" apostrophes. NOTE: Not needed any more, kept
" for compatibility with older versions.
" let delimitMate_apostrophes=
