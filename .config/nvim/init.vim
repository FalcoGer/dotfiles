" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible
set nocompatible

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

if has('nvim')
    " Disable netrw nvim file browser, this is replaced by nvim-tree
    :let g:loaded_netrw       = 1
    :let g:loaded_netrwPlugin = 1

endif

" Set the leader button to , which is easier to press than the default \
" see :help leader
let mapleader=','
" Set timeout to complete key combinations to 1500ms, default would be 1000ms
let timeoutlen=1500

" =============================================================================

" Set up vim-plug (Plugin Manager), supersedes vundle
" Setup steps here: https://github.com/junegunn/vim-plug

filetype off                    " disable file type detection

" Put plugins between begin and end calls
" Shorthand with org/repo to fetch it from github
" Full URL allowed
" | separators allowed for multiple plugins
" use { on: command, for: language } for on demand loading
" Directory path for manual plugin loading
" More examples on the vim-plug repo readme.

" vim-plug commands:
" - PlugUpgrade                 Upgrade vim-plug itself
" - PlugInstall [name ...]      Install all plugins or the specific one(s)
" - PlugUpdate [name ...]       Upgrade plugins
" - PlugStatus                  Check Status of plugin
" - PlugDiff                    Check diff between previous updates and pending changes
call plug#begin(expand('~/.vim/plugged'))
" Full language server integration.
" Provides autocomplete and syntax checking among other things
Plug 'neoclide/coc.nvim', {'branch': 'release'} | let g:user_loaded_coc = 1

" Provides XtermColorTable command to check 256 color terminal colors
" For example for use in vimscript highlights
Plug 'guns/xterm-color-table.vim' | let g:user_loaded_colortable = 1

" Provides :Dox command to add doxygen comments to c++ code
Plug 'vim-scripts/DoxygenToolkit.vim' | let g:user_loaded_doxytoolkit = 1

" Provides commands to switch between source and header files
Plug 'derekwyatt/vim-fswitch' | let g:user_loaded_fswitch = 1

" Provides fuzzy search, :FZF command, ctrl + X and ctrl + V to open in
" split/vertical split
" https://github.com/junegunn/fzf/blob/master/README-VIM.md
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } | let g:user_loaded_fzf = 1

" Snippets, Snippet engine provided by coc-snippets
Plug 'honza/vim-snippets' | let g:user_loaded_vimsnippets = 1

" Fancy status line
Plug 'vim-airline/vim-airline' | let g:user_loaded_vimairline = 1

" Git integration
" fugitive adds :Git commands and a status line indicator, integrates with
" vim-airline
Plug 'tpope/vim-fugitive' | let g:user_loaded_fugitive = 1
" flog provides a git branch viewer with :Flog or :Flogsplit
Plug 'rbong/vim-flog' | let g:user_loaded_flog = 1
" git gutter provides indicators in the left bar to show changes since the
" last commit
" Plug 'airblade/vim-gitgutter' | let g:user_loaded_gitgutter = 1

" signify shows VCS changes (like git) in the sign column. More lightweight
" than gitgutter with less features. Just does the sign column.
" if has('nvim') || has('patch-8.0.902')
"     Plug 'mhinz/vim-signify' | let g:user_loaded_signify = 1
" else
"     Plug 'mhinz/vim-signify', { 'tag': 'legacy' } | let g:user_loaded_signify = 1
" endif

" Puts signs into the sign colum where users has changed file since last save
" Also for VCS
" integrates with vim-airline
Plug 'chrisbra/changesPlugin' | let g:user_loaded_changesplugin = 1

" Python virtualenv support. Provides :VirtualEnv commands. Integrates with
" vimairline
Plug 'jmcantrell/vim-virtualenv' | let g:user_loaded_virtualenv = 1

" Search through buffers, files, recently opened, etc. Provides :Unite command
Plug 'Shougo/unite.vim' | let g:user_loaded_unite = 1
" Allows command execution from unite
Plug 'Shougo/vimproc.vim', {'do' : 'make'} | let g:user_loaded_vimproc = 1

" Show undo tree of vim visually
" Plug 'sjl/gundo.vim' | let g:user_loaded_gundo = 1
Plug 'mbbill/undotree' | let g:user_loaded_undotree = 1

" Tag bar, showing for example classes and members in a tree view
Plug 'preservim/tagbar' | let g:user_loaded_tagbar = 1

if !has('nvim')
    " File Tree View
    Plug 'preservim/nerdtree' | let g:user_loaded_nerdtree = 1

    " Rainbow brackets - does not work with treesitter
    Plug 'luochen1990/rainbow' | let g:user_loaded_rainbow = 1
" Rainbow brackets - works with treesitter
Plug 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim' | let g:user_loaded_rainbowdelim = 1
else
    " Coloured icons, used by nvim-tree and bufferline
    Plug 'nvim-tree/nvim-web-devicons' | let g:user_loaded_devicons = 1
    " Plug 'ryanoasis/vim-devicons' Icons without colours

    " Replaces NTree and NerdTree
    Plug 'nvim-tree/nvim-tree.lua' | let g:user_loaded_nvimtree = 1

    " Buffers as tabs
    Plug 'akinsho/bufferline.nvim', { 'tag': '*' } | let g:user_loaded_bufferline = 1

    " Better syntax highlighting
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} | let g:user_loaded_treesitter = 1
    
    " Rainbow brackets - works with treesitter
    Plug 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim' | let g:user_loaded_rainbowdelim = 1
endif

call plug#end()                 " required
filetype plugin indent on       " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" End vim-plug Setup

" =============================================================================

" Use gui colors, even in terminal.
" Recommended for bufferline plugin
set termguicolors

" Set the title to reflect the file being edited
set title

function! MakeProtectedDir(target_path)
    if !isdirectory(a:target_path)
        call mkdir(a:target_path, "p", "0700")
    endif
endfunction

" Directory for swap and backup files
" // at the end makes sure file locations are saved in the file name
let targetPath = expand('~/.vim/swp//')
call MakeProtectedDir(targetPath)
let &directory = targetPath

let targetPath = expand('~/.vim/backup//')
call MakeProtectedDir(targetPath)
let &backupdir = targetPath
set backup

let targetPath = expand('~/.vim/undo//')
call MakeProtectedDir(targetPath)
let &undodir = targetPath
set undofile

" patchmode will keep the first version of a file and not write it anymore
" after that
" set patchmode=.orig

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Normal text color is green on very dark gray
highlight Normal ctermfg=34 ctermbg=233 guifg=#00DF00 guibg=#121212
" Selected text in visual mode
highlight Visual ctermbg=237 guibg=#3A3A3A

" clipboard support
" register "+ (clipboard) and
" "* primary
set guioptions+=a


" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" These make vim VI incompatible
set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
set incsearch       " Incremental search, shows partial matches
set autowrite       " Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned
set mouse=a         " Enable mouse usage (all modes)

" =============================================================================
" Right column marker
set colorcolumn=121
highlight ColorColumn gui=underdashed guisp=#800000 ctermbg=1 guibg=NONE

" Highlight Whitespaces
set list
set listchars=tab:<->               " Show tabs as this. xy[z], x always, then y as many as will fit, z as the last one.
set listchars+=eol:$                " End of line marker.
set listchars+=lead:-
set listchars+=leadmultispace:---+  " What to display for leading white space characters.
set listchars+=trail:+              " What to display for trailing white space characters.
set listchars+=extends:>            " What to display when wrapped is off and part of the line is past the right edge of the screen.
set listchars+=precedes:<           " What to display when wrapped is off and part of the line is past the left edge of the screen.

" Make it less clutter-y
" For which highlight group goes where, check the end of ":help listchars"
highlight NonText       term=bold ctermfg=244 gui=bold guifg=#808080
highlight SpecialKey    term=bold ctermfg=244 gui=bold guifg=#808080

" Do not have pink background for completion menues and ALE error/warning popups
" Main text - Light gray on very dark gray
highlight Pmenu         ctermbg=236 guibg=#303030 ctermfg=248 guifg=#A8A8A8
highlight link NormalFloat Pmenu
" Selected text - light yellow on even darker gray
highlight PmenuSel      ctermbg=235 guibg=#262626 ctermfg=228 guifg=#FFFF87 cterm=underdotted gui=underline
" Scrollbar - gray
highlight PmenuSbar     ctermbg=235 guibg=#262626
" Scrollbar thumb - lighter than medium gray
highlight PmenuThumb    ctermbg=247 guibg=#9E9E9E

highlight FloatBoarder  ctermbg=237 guibg=#3A3A3A ctermfg=248 guifg=#A8A8A8
highlight FloatTitle    ctermbg=234 guibg=#1C1C1C ctermfg=11 guifg=#FFFF00 cterm=bold gui=bold

" Enable spell checking
set spell
highlight SpellBad      ctermbg=9 cterm=NONE gui=undercurl guisp=#FF0000
" Wrong capitalization
" highlight link SpellCap SpellBad
" Rarely used
" highlight link SpellRare SpellBad
" Used in another region
" highlight link SpellLocal SpellBad

highlight DiagnosticUnderlineError gui=underline cterm=underline guisp=#FF0000
highlight DiagnosticUnderlineWarn gui=underline cterm=underline guisp=#FFFF00
highlight DiagnosticUnderlineInfo gui=underdotted cterm=underdotted guisp=#0000FF
highlight DiagnosticUnderlineHint gui=underdotted cterm=underdotted guisp=#00FFFF

" Highlight search results
set hlsearch
highlight Search ctermfg=0 guifg=NONE guibg=NONE ctermbg=11 cterm=bold gui=underdashed guisp=#FFFF00

" =============================================================================

" Set relative numbers automatically in normal mode and when buffer is out
" focus
set number
set relativenumber

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * if(getbufinfo('%')[0]['listed'] == 1 || &buftype == 'help') | set relativenumber | endif
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" =============================================================================
" Behavior

set synmaxcol=2048

set wildmenu            " Enable command autocompletion to be a menu
set confirm             " Ask user to save instead of failing command to quit
set lazyredraw          " Do not update display while executing macros
set showmode            " Shows the current mode in the last line
set wrapscan            " wrap around while searching
set cmdheight=2         " command line height
set emoji               " Smartly allocate 2 cells for emojis
set ambiwidth="single"  " East Asian Width Class Ambiguous (special characters) take a single cell only.
if has('nvim')
    set signcolumn=auto:1-2
else
    set signcolumn=yes
endif
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Allow cursor to wrap lines when moving left or right
" See :help whichwrap
set whichwrap=<,>,[,],h,l

" Stop certain movements from always going to the first character of a line.
set nostartofline

set laststatus=2                        " 0: off, 1: only if 2 windows, 2: always, 3: only the last window

" Status Line
set statusline=
if !exists("g:user_loaded_vimairline")
    set statusline+=%f                      " File Name, max 20 characters
    set statusline+=\ %m                    " Modifiable [+] or [-]
    set statusline+=\ %{4}.{4}{r}           " Readonly [RO] or nothing
    set statusline+=\ Line:\ %l/%L[%p%%]    " Line: CurLine/LastLine[Percent%]
    set statusline+=\ Col:\ %c              " Current column
    set statusline+=\ Buf:\ #%n             " Current buffer number
    set statusline+=\ [%b][0x%B]            " current character under cursor
endif
" history size
set history=1000

" =============================================================================
" Folding

" auto open folds in these conditions
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

if has('nvim')
    " Treesitter folding
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
else
    set foldmethod=indent       " Fold based on indention levels.
endif
set foldnestmax=3               " Only fold up to three nested levels.
set foldminlines=3              " Only fold if there are at least 3 lines.

" use ! to allow reloading of this file with source
function! MyFoldText()
    let line = getline(v:foldstart)
    let numberOfLines = 1 + v:foldend - v:foldstart
    let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
    return v:folddashes .. sub .. ' (' .. numberOfLines .. ' Lines)'
endfunction

set foldtext=MyFoldText()

set nofoldenable            " Disable folding
highlight Folded ctermfg=14 ctermbg=236 gui=underdouble guisp=#008080 guifg=#00FFFF guibg=#303030

highlight SignColumn ctermfg=51 ctermbg=234 guifg=#00FFFF guibg=#1C1C1C
" =============================================================================
" Indentation

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4            " Indent using 4 spaces
set softtabstop=4           " Inserts tabstop number of spaces when tab is pressed
set smarttab                " Indent by shiftwidth at start of line, otherwise softtabstop
set expandtab               " Converts tabs to spaces

" =============================================================================

" keep cursor off the edge when scrolling
set scrolloff=4
set sidescrolloff=10

" highlight current line with a lighter background
set cursorline
highlight CursorLine ctermbg=234 guibg=#1C1C1C cterm=NONE gui=NONE

" Wrap long lines
set linebreak

" allow selection of virtual text in block mode
set virtualedit=block
" =============================================================================
" Mapping

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Allow saving of files as sudo when I forgot to start vim using sudo.
" cmap w!! w !sudo tee > /dev/null %
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" When typing help on the command line, expand to :vertical help automatically
cnoremap help vertical help

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
" noremap <C-L> :nohl<CR>:cclose<CR>:lclose<CR>:helpclose<CR><C-L>
noremap <C-L> :nohl<CR>:cclose<CR>:lclose<CR><C-L>

" copy to PRIMARY or to CLIPBOARD
noremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader>Y "*y
noremap <Leader>P "*p

" Copy text in normal mode, note that terminal can't distinguish between C and S-C
nnoremap <C-C> "+yy
" Copy text in visual mode
vnoremap <C-C> "+y
" Paste text with ctrl + v in insert and command mode, but keep visual block mapping (normal mode C-V)

" C-O switches to temporary normal mode

" this version doesn't cause formatting like indents or auto comment markers to be automatically applied, but pastes one space behind the cursor
" inoremap <C-V> <c-o>"+p
" This version pastes where the cursor is, but applies formatting
inoremap <C-V> <c-r>+

cnoremap <C-V> <c-r>+
" Pasting is provided by the terminal and need not be done.
" See GUI section above for paste configuration for neovide

" Switch buffers with alt + left/right
noremap <silent> <M-Left> :bprevious<CR>
noremap <silent> <M-Right> :bnext<CR>

" Close buffers with C-W
nnoremap <silent> <C-W> :bdelete<CR>

" Keybind to find out why something is highlighted the way it is.
nmap <silent> <S-F1> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
    \ . '> trans<' . synIDattr(synID(line("."),col("."),0),"name")
    \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name")
    \ . ">"<CR>


" =============================================================================
" Auto remove whitespace at EOL in certain scripts
augroup AutoremoveWhitespace
    autocmd!
    autocmd BufWritePre *.py    silent if(search('\s\+$', 'w')) | :%s/\s\+$//g | fi
    autocmd BufWritePre *.c     silent if(search('\s\+$', 'w')) | :%s/\s\+$//g | fi
    autocmd BufWritePre *.cpp   silent if(search('\s\+$', 'w')) | :%s/\s\+$//g | fi
    autocmd BufWritePre *.h     silent if(search('\s\+$', 'w')) | :%s/\s\+$//g | fi
    autocmd BufWritePre *.hpp   silent if(search('\s\+$', 'w')) | :%s/\s\+$//g | fi
    autocmd BufWritePre *.lua   silent if(search('\s\+$', 'w')) | :%s/\s\+$//g | fi
    autocmd BufWritePre *.vim   silent if(search('\s\+$', 'w')) | :%s/\s\+$//g | fi
augroup END

" =============================================================================

if filereadable(expand('~/.vim/hexeditor.vim'))
    source ~/.vim/hexeditor.vim
endif

if (exists("g:neovide"))
    if filereadable(expand("~/.vim/neovide.vim"))
        source ~/.vim/neovide.vim
    endif
endif

" =============================================================================
" Plugin configurations

if exists('g:user_loaded_nerdtree')
    source ~/.vim/nerdtree.vim
endif

if exists('g:user_loaded_nvimtree')
    source ~/.vim/nvimtree.vim
endif

if exists('g:user_loaded_fswitch')
    source ~/.vim/fswitch.vim
endif

if exists('g:user_loaded_coc')
    source ~/.vim/coc.vim
    source ~/.vim/coc-snippets.vim
endif

if exists('g:user_loaded_bufferline')
    set mousemoveevent
    source ~/.vim/bufferline.lua
endif

if exists('g:user_loaded_treesitter')
    source ~/.vim/treesitter.lua
endif

if exists('g:user_loaded_rainbow')
    source ~/.vim/rainbow.vim
endif

if exists('g:user_loaded_rainbowdelim')
    source ~/.vim/rainbowdelim.lua
endif

if exists('g:user_loaded_vimairline')
   source ~/.vim/vimairline.vim
endif

if exists('g:user_loaded_flog')
    source ~/.vim/flog.vim
endif

if exists('g:user_loaded_unite')
    source ~/.vim/unite.vim
endif

if exists('g:user_loaded_undotree')
    source ~/.vim/undotree.vim
endif

if exists('g:user_loaded_tagbar')
    nmap <silent><C-t> :TagbarToggle<CR>
endif

if exists('g:user_loaded_changesplugin')
    source ~/.vim/changesplugin.vim
endif
