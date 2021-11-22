#!/bin/bash

# turn list of arguments into string to pass them as is to pwncat
ARGS=$(echo "$@")
WD='/home/paul/repositories/crackmapexec/'

# activate virtualenv
CMD='source '"$WD"'env/bin/activate'
# append pwncat command
CMD="$CMD"' && cme '"$ARGS"

# execute in own bash instance
# this prevents the virtualenv
echo running \""$CMD"\" in $(pwd)
echo ---------------start---------------
/bin/bash -c "$CMD"
echo ----------------end----------------

