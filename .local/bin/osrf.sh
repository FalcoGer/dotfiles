#!/bin/bash

# turn list of arguments into string to pass them as they are
ARGS=$(echo "$@")
WD='/home/paul/repositories/hacking/osrframework/'

# activate virtualenv
CMD='source '"$WD"'env/bin/activate'
# append pwncat command
CMD="$CMD"' && osrf '"$ARGS"

# execute in own bash instance
# this prevents the virtualenv
echo running \""$CMD"\" in $(pwd)
echo ---------------start---------------
/bin/bash -c "$CMD"
echo ----------------end----------------

