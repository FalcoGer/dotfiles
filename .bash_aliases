# allow sudo aliases!
if [ $SHELL = "/bin/bash" ]
then
    alias sudo='sudo '
fi

alias config="/usr/bin/git --work-tree=$HOME --git-dir=$HOME/repositories/dotfiles/"

# enable color support of ls and also add handy aliases
if [ -x "/usr/bin/dircolors" ]; then
    test -r "$HOME/.dircolors" && eval "$(dircolors -b "$HOME/.dircolors")" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'
#alias ls='ls -alF --color=auto | grep "^d";ls -alF --color=auto | grep "^-";ls -alF --color=auto | grep "^l"'
cmp=`which exa`
if [ -n "${cmp}" ]; then
    # we have exa
    alias ls='exa -aalF -g --group-directories-first --color-scale --icons --time-style long-iso --git --extended'
else
    alias ls='ls -alhF --color=auto --group-directories-first'
fi

cmp=`which batcat`
if [ -n "${cmp}" ]; then
    # we have batcat
    alias cat='batcat --style=auto --paging=auto --tabs=4'
fi

cmp=`which nvim`
if [ -n "${cmp}" ]; then
    # we have neovim
    alias vim='nvim'
else
    # we do not have neovim
    alias vim='vim -p'
fi
cmp=`which neovide`
if [ -n "${cmp}" ]; then
    # we have neovim
    alias neovide='neovide --notabs'
fi

alias rmdir='rmdir -v'

which trash 1> /dev/null
if [ $? -eq 0 ]; then
    alias rm='trash -v'
else
    alias rm='rm -v --interactive=once'
fi

alias cp='cp -v -i'
alias mv='mv -v -i'
alias cd..='cd ..'

up () {
    local d=""
    local limit="$1"

    # Default to limit 1
    if [ -z "$limit" -o "$limit" -le 0 ]; then
        limit=1
    fi

    for ((i=1;i<=limit;i++)); do
        d="../$d"
    done

    if ! cd "$d"; then
        echo "Couldn't go up $limit directories." >2
    fi
}

alias quit='exit'
alias ipython='ipython3'
if [ -f ".bash_aliases_secret" ]; then
    source ".bash_aliases_secret"
fi

if [ "$TERM" = "xterm-kitty" ]; then
    alias icat='kitty +kitten icat'
    alias kitty-diff='kitty +kitten diff'
    # alias ssh='kitty +kitten ssh'
    
    # export TERM="xterm-256color"
fi

if [ -f "$HOME/repositories/hacking/john/run/john" ]; then
    alias john="$HOME/repositories/hacking/john/run/john"
fi

if [ -f "$HOME/repositories/hacking/wesng/wes.py" ]; then
    alias wes.py='$HOME/repositories/hacking/wesng/wes.py --color --definitions $HOME/repositories/wesng/definitions.zip'
fi

CLANG_VERSION=`clang --version | head -n1 | sed -E 's/.* version ([[:digit:]]+)\.[[:digit:]]+\.[[:digit:]]+.*$/\1/'`

CLANG_OPT="-std=c++23"
CLANG_OPT="$CLANG_OPT -stdlib=libc++ -fexperimental-library -L/usr/lib/llvm-${CLANG_VERSION}/lib"
CLANG_WARN="-Wall -Wextra -Wpedantic"
CLANG_WARN="$CLANG_WARN -Wdouble-promotion" # implicit float->double
CLANG_WARN="$CLANG_WARN -Wformat=2"
CLANG_WARN="$CLANG_WARN -Wformat-nonliteral"
CLANG_WARN="$CLANG_WARN -Wformat-y2k"
CLANG_WARN="$CLANG_WARN -Wnull-dereference"
CLANG_WARN="$CLANG_WARN -Wimplicit-fallthrough"
CLANG_WARN="$CLANG_WARN -Wmissing-include-dirs"
CLANG_WARN="$CLANG_WARN -Wswitch-default"
CLANG_WARN="$CLANG_WARN -Wswitch-enum"
CLANG_WARN="$CLANG_WARN -Wswitch-bool"
CLANG_WARN="$CLANG_WARN -Wunused-parameter"
CLANG_WARN="$CLANG_WARN -Wuninitialized"
CLANG_WARN="$CLANG_WARN -Walloca"
CLANG_WARN="$CLANG_WARN -Wconversion"
CLANG_WARN="$CLANG_WARN -Wfloat-conversion"
CLANG_WARN="$CLANG_WARN -Wsign-conversion"
CLANG_WARN="$CLANG_WARN -Wfloat-equal"
CLANG_WARN="$CLANG_WARN -Wshadow-all"
CLANG_WARN="$CLANG_WARN -Wundef"
CLANG_WARN="$CLANG_WARN -Wunused-macros"
CLANG_WARN="$CLANG_WARN -Wcast-qual"
CLANG_WARN="$CLANG_WARN -Wcast-align"
CLANG_WARN="$CLANG_WARN -Wmissing-declarations"
CLANG_WARN="$CLANG_WARN -Wredundant-decls"
CLANG_WARN="$CLANG_WARN -Wstack-protector -fstack-protector"
CLANG_WARN="$CLANG_WARN -pedantic-errors"
CLANG_ERROR="-Werror=pedantic"
CLANG_ERROR="$CLANG_ERROR -Werror=char-subscripts"
CLANG_ERROR="$CLANG_ERROR -Werror=null-dereference"
CLANG_ERROR="$CLANG_ERROR -Werror=init-self"
CLANG_ERROR="$CLANG_ERROR -Werror=implicit-fallthrough"
CLANG_ERROR="$CLANG_ERROR -Werror=misleading-indentation"
CLANG_ERROR="$CLANG_ERROR -Werror=missing-braces"
CLANG_ERROR="$CLANG_ERROR -Werror=sequence-point"
CLANG_ERROR="$CLANG_ERROR -Werror=return-type"
CLANG_ERROR="$CLANG_ERROR -Werror=multichar"
alias clang++="clang++ $CLANG_OPT $CLANG_WARN $CLANG_ERROR"

# g++ enable warnings and treat special warnings as errors
# default warnings, extra warnings and ISO-C++ deviations
GPP_WARN="-Wall -Wextra -Wpedantic"
GPP_WARN="$GPP_WARN -Wdouble-promotion" # implicit float->double. 32bit CPUs implement float in hardware but double in software emulation. This causes speed loss
GPP_WARN="$GPP_WARN -Wformat=2 -Wformat-nonliteral -Wformat-signedness -Wformat-y2k" # aditional format checks for printf, scanf, etc.
GPP_WARN="$GPP_WARN -Wnull-dereference" # check if a code path can lead to null pointer dereferencing
GPP_WARN="$GPP_WARN -Wimplicit-fallthrough=2" # warn about switch-case-fallthrough unless comment matches regex ".*falls?[ \t-]*thr(ough|u).*" IMPLICIT-FALLTHROUGH=3 IS ENABLED BY WEXTRA!
GPP_WARN="$GPP_WARN -Wmissing-include-dirs"
GPP_WARN="$GPP_WARN -Wswitch-default" # warn about switch statement not having a default
GPP_WARN="$GPP_WARN -Wunused-parameter" # warn about a function parameter is unused aside from it's declaration
GPP_WARN="$GPP_WARN -Wuninitialized" # warn if auto-var is used uninitialized also warn if ref or const appear in class without ctor.
GPP_WARN="$GPP_WARN -Wsuggest-attribute=const" # warn where an attribute might be a good idea
GPP_WARN="$GPP_WARN -Walloc-zero" # warn if allocating 0 bytes
GPP_WARN="$GPP_WARN -Walloca" # warn of usage of alloca
GPP_WARN="$GPP_WARN -Wconversion -Wfloat-conversion -Wsign-conversion" # warn about implicit conversions
GPP_WARN="$GPP_WARN -Wduplicated-branches -Wduplicated-cond" # warn about duplicated branches and conditions
GPP_WARN="$GPP_WARN -Wtrampolines" # warn about trampoline code that might require stack execution. trampoline = data/code on stack that takes nested function pointer to call that function indirectly
GPP_WARN="$GPP_WARN -Wfloat-equal" # warn if floating point values are used for equality checks.
GPP_WARN="$GPP_WARN -Wshadow=compatible-local" # warn if variable shaddows a compatible (implicitly convertible) variable, not when it's a completely different type (likely intentional)
GPP_WARN="$GPP_WARN -Wundef" # warn if undefined preprocessor variable is evaluated (will be replaced by 0)
GPP_WARN="$GPP_WARN -Wunused-macros" # warn if macro is unused in main file (not include files)
GPP_WARN="$GPP_WARN -Wcast-qual" # warn about unsafe casts that adds or removes qualifiers such as const
GPP_WARN="$GPP_WARN -Wcast-align=strict" # warn when casting pointers that could cause missalignment that can access for example integers only at 2 or 4 byte boundaries. =strict -> regardless of machine
GPP_WARN="$GPP_WARN -Wlogical-op" # warns when bitwise operator is likely, also warns if duplicate condition
GPP_WARN="$GPP_WARN -Wmissing-declarations" # warn if function is missing declaration, even if declaration is in the definition. not in anonymous namespace, inline functions or function templates.
GPP_WARN="$GPP_WARN -Wredundant-decls" # warn if multiple declarations are redundant
GPP_WARN="$GPP_WARN -Wstack-protector -fstack-protector" # warn about functions that are not protected against stack smashing. also enable stack smashing protection

GPP_ERR="-pedantic-errors -Werror=pedantic"
GPP_ERR="$GPP_ERR -Werror=char-subscripts" # chars are signed, using char type as subscript is bad.
GPP_ERR="$GPP_ERR -Werror=null-dereference" # null pointer dereferencing is undef. behavior
GPP_ERR="$GPP_ERR -Werror=init-self" # self initialization is bad.
GPP_ERR="$GPP_ERR -Werror=implicit-fallthrough=2" # requires comment in fallthrough cases, otherwise error
GPP_ERR="$GPP_ERR -Werror=misleading-indentation" # enforce good style
GPP_ERR="$GPP_ERR -Werror=missing-braces" # enforce braces (int a[2][2] = {1,2,3,4} -> {{1,2},{3,4}})
GPP_ERR="$GPP_ERR -Werror=multistatement-macros" # warn if macro with multiple statements is not guarded as expected. #define DOIT x++; y++ -> if(c) DOIT; // leads to y++ being executed unconditionally
GPP_ERR="$GPP_ERR -Werror=sequence-point" # undefined behavior for things like a = a++ or a[n] = n++ or a[n++] = n
GPP_ERR="$GPP_ERR -Werror=return-type" # undefined behavior if returning function does not return a value. also if non-returning function returns a value.
GPP_ERR="$GPP_ERR -Werror=multichar" # char c = 'ABCD';
GPP_STD="-std=c++20"
alias g++="g++ $GPP_STD $GPP_WARN $GPP_ERR"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias viless='/usr/local/share/vim/vim82/macros/less.sh'

