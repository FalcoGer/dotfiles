#!/bin/bash

# turn list of arguments into string to pass them as they are
ARGS=$(echo "$@")
WD='/home/paul/repositories/hacking/theHarvester/'

CMD="cd $WD"
# activate virtualenv
CMD="$CMD"' && source bin/activate'
# append command
CMD="$CMD"' && python theHarvester.py '"$ARGS"

# execute in own bash instance
# this prevents the virtualenv
echo "running \"""$CMD""\" in $WD"
echo ---------------start---------------
/bin/bash -c "$CMD"
echo ----------------end----------------
