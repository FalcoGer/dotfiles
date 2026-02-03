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

# allow loading of plugins.
add-auto-load-safe-path /usr/

# auto download symbols
python
try:
    # Try setting debuginfod to see whether it's supported
    gdb.execute( "set debuginfod enabled on" )
    gdb.execute( "set debuginfod urls https://debuginfod.ubuntu.com https://debuginfod.elfutils.org" )
    gdb.write( "Debuginfod is enabled.\n" )
except gdb.error as e:
    gdb.write( "Debuginfod is not supported.\n" )
end

# load the latest pretty printer from gcc
python
import os
import glob
import sys

def load_gcc_printers():
    # Define search locations
    search_path = "/usr/local/share"
    fallback_path = "/usr/share/gcc/python"
    
    # Find all directories matching gcc-X.Y.Z
    gcc_dirs = glob.glob(os.path.join(search_path, "gcc-*"))
    
    selected_path = None

    if gcc_dirs:
        # Sort by version (splitting by '-' then by '.' to handle numeric sorting)
        # This ensures gcc-10.0.0 is "larger" than gcc-9.0.0
        try:
            gcc_dirs.sort(key=lambda x: [int(c) if c.isdigit() else c for c in os.path.basename(x).split('-')[1].split('.')])
            selected_path = os.path.join(gcc_dirs[-1], "python")
            gdb.write( f"Found custom GCC printers at: {selected_path}\n")
        except (IndexError, ValueError):
            gdb.write( "Found gcc-* directories but failed to parse versioning.\n")

    # Fallback logic
    if not selected_path or not os.path.exists(selected_path):
        selected_path = fallback_path
        gdb.write( f"No custom GCC printers found. Falling back to: {selected_path}\n")

    # Load the printers
    if os.path.exists(selected_path):
        sys.path.insert(0, selected_path)
        try:
            from libstdcxx.v6 import register_libstdcxx_printers
            register_libstdcxx_printers(None)
            gdb.write( "Successfully registered libstdc++ pretty-printers.\n")
        except ModuleNotFoundError as e:
            print( f"libstdcxx printer module not found from {selected_path}: {e}" )
        except ImportError as e:
            print( f"Import failed from {selected_path}: {e}" )
        except FileNotFoundError as e:
            print( f"Path not found from {selected_path}: {e}" )
        except Exception as e:
            gdb.write( f"Failed to register printers from {selected_path}: {e}\n")
    else:
        gdb.write( "Error: Could not find any valid libstdc++ printer path.\n")

load_gcc_printers()
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
    gdb.write( "NOLOAD_PWNDBG was set. Not loading pwndbg.\n" )
    gdb.execute( "define hook-stop\n  info registers rax rbx rcx rdx rsi rdi rbp rsp rip eflags\n  x /64wx $rsp\n  x/3i $rip\nend" )
end
