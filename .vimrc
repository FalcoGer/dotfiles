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

" Set up Vundle (Vim Bundle - Plugin Manager)
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

" Installing plugins:
" 1. Clone the plugin repository to your ~/.vim/bundle/ directory
" 2. Update your ~/.vimrc file with the new plugin details
" 3. Install the plugin by launching Vim and running :PluginInstall

filetype off                    " disable file type detection
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" All plugins to load will be added here
" Autocomplete
Plugin 'Valloric/YouCompleteMe'

" Syntax Checking
" see :help syntastic
Plugin 'vim-syntastic/syntastic'

" File Tree View
Plugin 'preservim/nerdtree'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler_options = '-std=c++17 -Wall -Wextra -Wpedantic -Wdouble-promotion -Wformat=2 -Wformat-nonliteral -Wformat-signedness -Wformat-y2k -Wnull-dereference -Wimplicit-fallthrough=2 -Wmissing-include-dirs -Wswitch-default -Wunused-parameter -Wuninitialized -Wsuggest-attribute=const -Walloc-zero -Walloca -Wconversion -Wfloat-conversion -Wsign-conversion -Wduplicated-branches -Wduplicated-cond -Wtrampolines -Wfloat-equal -Wshadow=compatible-local -Wundef -Wunused-macros -Wcast-qual -Wcast-align=strict -Wlogical-op -Wmissing-declarations -Wredundant-decls -Wstack-protector -fstack-protector -pedantic-errors -Werror=pedantic -Werror=char-subscripts -Werror=null-dereference -Werror=init-self -Werror=implicit-fallthrough=2 -Werror=misleading-indentation -Werror=missing-braces -Werror=multistatement-macros -Werror=sequence-point -Werror=return-type -Werror=multichar'

call vundle#end()               " required
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

" End Vundle Setup

" =============================================================================

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Set the title to reflect the file being edited
set title

" Directory for swap and backup files
set dir=~/.cache/vim/,./
set backupdir-=.
set backupdir^=~/tmp,/tmp
set patchmode=.orig

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
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search, shows partial matches
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)

" Set relative numbers automatically in normal mode and when buffer is out
" focus
set number
set relativenumber

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

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

" allow backspace to delete cr/lf and such
" set backspace=2

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

" keep cursor off the edge when scrolling
set scrolloff=4
set sidescrolloff=10

" highlight current line
set cursorline

set linebreak

" Useful mappings
 
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$
 
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
noremap <C-L> :nohl<CR><C-L>

" copy to PRIMARY or to CLIPBOARD
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

