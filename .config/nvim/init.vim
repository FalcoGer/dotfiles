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

Plug 'nvim-tree/nvim-web-devicons' " Recommended (for coloured icons, used by nvim-tree and bufferline)

" Auto completion and syntax checking
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" File Tree View
if !has('nvim')
    Plug 'preservim/nerdtree'
else
    Plug 'nvim-tree/nvim-tree.lua'

    " Buffers as tabs
    " Plug 'ryanoasis/vim-devicons' Icons without colours
    Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
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
" Plugin configurations

" Add color table script
if filereadable(expand("~/.vim/xterm-color-table/plugin/xterm-color-table.vim"))
    source ~/.vim/xterm-color-table/plugin/xterm-color-table.vim
endif

if !has('nvim') && filereadable(expand("~/.vim/nerdtree.vim"))
    source ~/.vim/nerdtree.vim
elseif has('nvim') && filereadable(expand("~/.vim/nvimtree.vim"))
    source ~/.vim/nvimtree.vim
endif

if filereadable(expand("~/.vim/coc.vim"))
    source ~/.vim/coc.vim
endif

" bufferline plugin
if has("nvim")
    if filereadable(expand("~/.vim/bufferline.lua"))
        set mousemoveevent
        source ~/.vim/bufferline.lua
    endif
endif
" =============================================================================

" Use gui colors, even in terminal.
" Recommended for bufferline plugin
set termguicolors

" Set the title to reflect the file being edited
set title

" Directory for swap and backup files
" // at the end makes sure file locations are saved in the file name
set dir=~/.vim/swp//,/tmp//
set backup
set backupdir=~/.vim/backup//,/tmp//
set undodir=~/.vim/undo//,/tmp//
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
highlight Normal ctermfg=34 ctermbg=233 guifg=#00DF00 guibg=#101010

" clipboard support
" register "+ (clipboard) and
" "* primary
set guioptions+=a

if (exists("g:neovide"))
    if filereadable(expand("~/.vim/neovide.vim"))
        source ~/.vim/neovide.vim
    endif
endif

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set ignorecase      " Do case insensitive matching
set smartcase       " Do smart case matching
set incsearch       " Incremental search, shows partial matches
set autowrite       " Automatically save before commands like :next and :make
set hidden          " Hide buffers when they are abandoned
set mouse=a         " Enable mouse usage (all modes)

" =============================================================================
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
highlight link SpellCap SpellBad
" Rarely used
highlight link SpellRare SpellBad
" Used in another region
highlight link SpellLocal SpellBad

" Highlight search results
set hlsearch
highlight Search ctermfg=NONE guifg=NONE guibg=NONE ctermbg=11 cterm=underdashed gui=underdashed guisp=#FFFF00

" =============================================================================

" Set relative numbers automatically in normal mode and when buffer is out
" focus
set number
set relativenumber

augroup numbertoggle
    autocmd!
    if has('nvim')
        autocmd BufEnter,FocusGained,InsertLeave * if (!(bufname('%') =~ "^NvimTree_\\d\\+")) | set relativenumber | endif
    else
        autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    endif
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" =============================================================================

set synmaxcol=2048

set wildmenu            " Enable command autocompletion to be a menu

set confirm             " Ask user to save instead of failing command to quit

" Do not update display while executing macros
set lazyredraw
set showmode

" wrap around while searching
set wrapscan

" command line height
set cmdheight=2

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Allow cursor to wrap lines when moving left or right
" See :help whichwrap
set whichwrap=<,>,[,],h,l

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" status line
set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]
" always put a status line
set laststatus=2

" history size
set history=1000

" =============================================================================

" auto tab
set foldopen=block,insert,jump,mark,percent,quickfix,search,tag,undo

set foldmethod=indent       " Fold based on indention levels.
set foldnestmax=3           " Only fold up to three nested levels.
set nofoldenable            " Disable folding by default.

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4            " Indent using 4 spaces
set softtabstop=4           " Inserts tabstop number of spaces when tab is pressed
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

" =============================================================================

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Allow saving of files as sudo when I forgot to start vim using sudo.
" cmap w!! w !sudo tee > /dev/null %
cmap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
" noremap <C-L> :nohl<CR>:cclose<CR>:lclose<CR>:helpclose<CR><C-L>
noremap <C-L> :nohl<CR>:cclose<CR>:lclose<CR><C-L>

" copy to PRIMARY or to CLIPBOARD
noremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader>Y "*y
noremap <Leader>P "*p

" Copy text in normal mode
nmap <C-C> "+yy
" Copy text in visual mode
vmap <C-C> "+y
" Pasting is provided by the terminal and need not be done.
" See GUI section above for paste configuration for neovide

" Switch buffers with alt + left/right
noremap <M-Left> :bprevious<CR>
noremap <M-Right> :bnext<CR>

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
" Automatically open files in a new buffer

augroup AutoNewTab
    autocmd!
    " autocmd BufAdd,BufNewFile * nested tab sball
    autocmd BufNewFile * nested tab sball
augroup END
" =============================================================================

if filereadable(expand('~/.vim/hexeditor.vim'))
    source ~/.vim/hexeditor.vim
endif
