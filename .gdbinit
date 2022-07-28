# prevent history from being all over the filesystem
set history save on
set history filename ~/.gdb_history
set history size 8192
set history remove-duplicates unlimited
# leave history expansion off (! character)

# prevent brain from exploding
set disassembly-flavor intel

# show registers, stack and instruction pointer when stopping

# not required with gef/pwndbg
# define hook-stop
#     info registers rax rbx rcx rdx rsi rdi rbp rsp rip eflags
#     x /64wx $rsp
#     x /3i $rip
# end

# load extensions
# source ~/repositories/hacking/peda/peda.py
source ~/repositories/hacking/exploitable/exploitable/exploitable.py
# source ~/repositories/hacking/gef/gef.py
source /home/paul/repositories/hacking/pwndbg/gdbinit.py
