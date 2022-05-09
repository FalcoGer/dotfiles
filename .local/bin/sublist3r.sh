#!/bin/bash
ARGS=$(echo "$@")
CMD="python3 /home/paul/repositories/hacing/sublist3r/sublist3r.py $ARGS"
echo running \""$CMD"\"

/bin/bash -c "$CMD"
