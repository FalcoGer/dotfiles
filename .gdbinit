# prevent history from being all over the filesystem
set history save on
set history filename ~/.gdb_history
set history size 8192
set history remove-duplicates unlimited
# leave history expansion off (! character)

# prevent brain from exploding
set disassembly-flavor intel

# These make gdb never pause in its output
set height 0
set width 0

# hook, not required with peda or pwndbg
# show registers, stack and instruction pointer when stopping

# not required with gef/pwndbg
# define hook-stop
#     info registers rax rbx rcx rdx rsi rdi rbp rsp rip eflags
#     x /64wx $rsp
#     x /3i $rip
# end

# auto download symbols
set debuginfod enabled on

# load extensions if they exist

# source ~/repositories/hacking/exploitable/exploitable/exploitable.py
shell if test -f ~/repositories/hacking/exploitable/exploitable/exploitable.py; then echo source ~/repositories/hacking/exploitable/exploitable/exploitable.py; fi > /tmp/gdbinit_source
source /tmp/gdbinit_source

# source ~/repositories/hacking/pwndbg/gdbinit.py
shell if test -f ~/repositories/hacking/pwndbg/gdbinit.py; then echo source ~/repositories/hacking/pwndbg/gdbinit.py; fi > /tmp/gdbinit_source
source /tmp/gdbinit_source
shell if test -f ~/repositories/hacking/pwndbg/gdbinit.py; then echo set context-ghidra if-no-source; fi > /tmp/gdbinit_source
source /tmp/gdbinit_source

shell rm /tmp/gdbinit_source
