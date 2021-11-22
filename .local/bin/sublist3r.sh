#!/bin/bash
ARGS=$(echo "$@")
CMD="python3 /home/paul/repositories/sublist3r/sublist3r.py $ARGS"
echo running \""$CMD"\"

/bin/bash -c "$CMD"
