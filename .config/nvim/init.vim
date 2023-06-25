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

" =============================================================================
if filereadable(expand("~/.vim/ale.vim"))
    " source ~/.vim/ale.vim
endif
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

" Auto completion and syntax checking
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" File Tree View
Plug 'preservim/nerdtree'

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

if filereadable(expand("~/.vim/nerdtree.vim"))
    source ~/.vim/nerdtree.vim
endif

if filereadable(expand("~/.vim/coc.vim"))
    source ~/.vim/coc.vim
endif

" =============================================================================
" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

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

" Enable spell checking
set spell

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Use this for gvim
highlight Normal guifg=white guibg=black

" clipboard support
" register "+ (clipboard) and
" "* primary
set guioptions+=a

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
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
" Selected text - light yellow on even darker gray
highlight PmenuSel      ctermbg=235 guibg=#262626 ctermfg=228 guifg=#FFFF87
" Scrollbar - gray
highlight PmenuSbar     ctermbg=244 guibg=#808080
" Scrollbar thumb - lighter than medium gray
highlight PmenuThumb    ctermbg=247 guibg=#9E9E9E

" =============================================================================

" Set relative numbers automatically in normal mode and when buffer is out
" focus
set number
set relativenumber

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" =============================================================================

set synmaxcol=2048

set wildmenu            " Enable command autocompletion to be a menu
set hlsearch            " Highlight search results

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

" highlight current line
set cursorline

" Wrap long lines
set linebreak

" =============================================================================

" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Allow saving of files as sudo when I forgot to start vim using sudo.
" cmap w!! w !sudo tee > /dev/null %
cmap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
noremap <C-L> :nohl<CR>:cclose<CR>:lclose<CR>:helpclose<CR><C-L>

" copy to PRIMARY or to CLIPBOARD
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

" =============================================================================
" Auto remove whitespace at EOL in certain scripts
augroup AutoremoveWhitespace
    autocmd!
    autocmd BufWritePre *.py    silent if(search('\s\+$', 'w')) | :%s/\s\+$//g | fi
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
