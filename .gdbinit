set disassembly-flavor intel
define hook-stop
    info registers rax rbx rcx rdx rsi rdi rbp rsp rip eflags
    x /64wx $rsp
    x /3i $rip
end
source ~/repositories/peda/peda.py
source ~/repositories/exploitable/exploitable/exploitable.py
