# allow sudo aliases!
alias sudo='sudo '

alias config="/usr/bin/git --work-tree=$HOME --git-dir=$HOME/repositories/dotfiles/"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
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
alias ls='ls -alhF --color=auto --group-directories-first'
alias rmdir='rmdir -v'
alias rm='rm -v --interactive=once'
alias cp='cp -v -i'
alias mv='mv -v -i'
alias cd..='cd ..'
alias quit='exit'
alias ipython='ipython3'
alias nmap='nmap --reason --script-args="shodan-api.apikey=AE8hqan6Zibwzk6spvZZVt09VfzPbuHf"'

if [ $TERM = "xterm-kitty" ]; then
    alias icat='kitty +kitten icat'
    alias kitty-diff='kitty +kitten diff'
    alias ssh='kitty +kitten ssh'
fi

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
GPP_STD="-std=c++17"
alias g++="g++ $GPP_STD $GPP_WARN $GPP_ERR"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias viless='/usr/local/share/vim/vim82/macros/less.sh'
alias john="$HOME/repositories/john/run/john"
