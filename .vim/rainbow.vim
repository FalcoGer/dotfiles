" https://github.com/luochen1990/rainbow#configure

let g:rainbow_active = 1

" Markdown: enable rainbow for code blocks only
" Lisp: lisp needs more colors for parentheses :)
" Haskell: The haskell lang pragmas should be excluded
" Vim: enable rainbow inside vim function body
" Perl: solve the [perl indent-depending-on-syntax problem](https://github.com/luochen1990/rainbow/issues/20)
" Stylus: [vim css color](https://github.com/ap/vim-css-color) compatibility"
" NerdTree: rainbow is conflicting with NERDTree, creating extra parentheses
" CSS: disable this plugin for css files

let g:rainbow_conf = {
          \     'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
          \     'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
          \     'guis': [''],
          \     'cterms': [''],
          \     'operators': '_,_',
          \     'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
          \     'separately': {
          \         '*': {},
          \         'markdown': {
          \             'parentheses_options': 'containedin=markdownCode contained',
          \         },
          \         'lisp': {
          \             'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
          \         },
          \         'haskell': {
          \             'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold'],
          \         },
          \         'vim': {
          \             'parentheses_options': 'containedin=vimFuncBody',
          \         },
          \         'perl': {
          \             'syn_name_prefix': 'perlBlockFoldRainbow',
          \         },
          \         'stylus': {
          \             'parentheses': ['start=/{/ end=/}/ fold contains=@colorableGroup'],
          \         },
          \         'css': 0,
          \         'nerdtree': 0,
          \     }
          \ }
