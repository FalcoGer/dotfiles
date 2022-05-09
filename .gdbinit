set disassembly-flavor intel
define hook-stop
    info registers rax rbx rcx rdx rsi rdi rbp rsp rip eflags
    x /64wx $rsp
    x /3i $rip
end
source ~/repositories/hacking/peda/peda.py
source ~/repositories/hacking/exploitable/exploitable/exploitable.py
