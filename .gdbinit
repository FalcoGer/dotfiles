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

# auto download symbols
python
try:
    # Try setting debuginfod to see if it's supported
    gdb.execute( "set debuginfod enabled on" )
    gdb.execute( "set debuginfod urls https://debuginfod.ubuntu.com https://debuginfod.elfutils.org" )
    gdb.write( "Debuginfod is enabled.\n" )
except gdb.error as e:
    gdb.write( "Debuginfod is not supported.\n" )
end

# load extensions if they exist
python

import os

exploitablePath = os.getenv( "HOME", "~" ) + "/repositories/hacking/exploitable/exploitable/exploitable.py"
if os.path.isfile(exploitablePath):
    gdb.write( "Loading exploitable from " + exploitablePath + "\n" )
    gdb.execute( "source " + exploitablePath )

# allow gdb to be loaded without pwndbg by setting this variable
noLoadPwndbg = os.getenv( "NOLOAD_PWNDBG", "0" )
pwnDbgPath = os.getenv( "HOME", "~" ) + "/repositories/hacking/pwndbg/gdbinit.py"

if noLoadPwndbg == "0" and os.path.isfile(pwnDbgPath):
    gdb.write ( "Loading PwnDbg from " + pwnDbgPath + "\n" )
    gdb.execute( "source " + pwnDbgPath )
    gdb.execute( "set context-ghidra if-no-source" )
else:
    # hook, not required with peda or pwndbg
    # show registers, stack and instruction pointer when stopping
    gdb.execute( "define hook-stop\n  info registers rax rbx rcx rdx rsi rdi rbp rsp rip eflags\n  x /64wx $rsp\n  x/3i $rip\nend" )
end

