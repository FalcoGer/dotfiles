# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"
ZSH_THEME="powerlevel10k/powerlevel10k"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [ -f ~/.p10k.zsh ]; then
    source ~/.p10k.zsh
else
    print "404: ~/.p10k.zsh not found."
fi

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=1

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    adb                     # android debug bridge autocomplete
    colored-man-pages       # colored man pages :>
    colorize                # colored output (syntax highlighting using pygmentize)
    command-not-found       # suggest packages to install if a command was not found
    copydir                 # copy pwd to system clipboard
    copyfile                # copy file into system clipboard
    dotenv                  # load environment variables from ".env" file when entering a directory containing one.
    encode64                # provides encode64 (e64) and decode64 (d64) commands (aliases)
    extract                 # provides extract function to automatically pick the correct extraction tool for an archive file
    fzf                     # fuzzy search in history (ctrl+r)
    git                     # git support
    git-auto-fetch          # automatically fetch remote when you're working in a git repository folder
    git-prompt              # provide information about the repository, remote information, conflicts, etc
    jsontools               # provide pp_json (pretty print), is_json (checker), urlencode_json and urldecode_json
    nmap                    # adds nmap aliases
    pip                     # autocompletion for pip
    rsync                   # provides aliases for rsync
    screen                  # set title when using screen
    sprunge                 # upload data to a pastebin clone (sprunge) via command line.
    sudo                    # allow prefixing commands with sudo by pressing esc + esc
    systemd                 # aliases. also provides monitoring of specific services if environment variables set correctly
    timer                   # provides execution time for commands
    z                       # z - build database of visited directories and jump into them via first matching regex.
    fzf-tab                 # fzf support in tab complete
    zsh-autosuggestions     # provide automatic suggestions based on history and completion
# breaks history search
# see: https://github.com/ohmyzsh/ohmyzsh/issues/8749
#    safe-paste              # prevents code that's pasted into terminal from running immediately
    
    # zsh-syntax-highlighting must be the last plugin!
    # zsh-syntax-highlighting # provide syntax highlighting
    fast-syntax-highlighting
)

# plugin config
# timer
export TIMER_PRECISION=3
export TIMER_FORMAT='[ %d ]'
export TIMER_THRESHOLD=0.1

# z
. $HOME/repositories/z/z.sh

# colorize
export ZSH_COLORIZE_STYLE='default' # pygmentize style

# dotenv
export ZSH_DOTENV_FILE=".env"  # the file name to look for

# git-auto-fetch
GIT_AUTO_FETCH_INTERVAL=900 # in seconds

# fzf-tab
# https://github.com/Aloxaf/fzf-tab
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:complete:*' fzf-preview 'if [[ -n $realpath ]]; then if [[ -r $realpath ]]; then /usr/bin/file $realpath; if [[ -d $realpath ]]; then /usr/local/bin/exa -alF1 -g --color-scale --color=always --icons --time-style long-iso --git --extended $realpath; elif [[ $(/usr/bin/file -b $realpath | /usr/bin/grep -i -e "ASCII" -e "UTF-8" -e "JSON") ]]; then /usr/bin/head -n 20 $realpath; else /usr/bin/hexdump -n 256 -C $realpath; fi; else /usr/bin/echo $realpath not readable; fi; else /usr/bin/echo $group: $word; /usr/bin/echo Description:; /usr/bin/echo $desc | sed -e "s/\s\{3,\}/\n/g" | sed -e "s/.\{40\}/&\n/g"; fi'

# zsh-autosuggestions
# options: fg=name/#hex bg, underline, bold, italic
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#104010,underline"
# options: history - most recent match, completion - what tab would suggest (req. ztpy), match_prev_cmd - ???
# may use (history completion)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# limit length to search for
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
# use async fetching
ZSH_AUTOSUGGEST_USE_ASYNC=true
###

# source oh-my-zsh to do all kinds of amazing things with the zsh terminal
source $ZSH/oh-my-zsh.sh

# prompts
if [ -f ~/.shell_colors ]; then
    source ~/.shell_colors
else
    echo "404: ~/.shell_colors not found."
fi

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
# You may need to manually set your language environment
# export LANG=en_US.UTF-8
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases 
else
    print "404: ~/.bash_aliases not found."
fi

# zsh-specific aliases
if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
else
    print "404: ~/.zsh_aliases not found."
fi

# exports
if [ -f ~/.bash_env ]; then
    source ~/.bash_env
else
    print "404: ~/.bash_env not found."
fi

# autocomplete stuff
# autocomplete from man pages
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select

# The following lines were added by compinstall
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _complete _ignored _correct _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=4
zstyle ':completion:*' original false
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
HISTFILE="$ZSH_CACHE_DIR/.zsh_history"
HISTSIZE=4096
SAVEHIST=8192
setopt autocd nomatch notify beep
unsetopt extendedglob
bindkey -e # -e = emacs mode, -v = vim mode
# End of lines configured by zsh-newuser-install

