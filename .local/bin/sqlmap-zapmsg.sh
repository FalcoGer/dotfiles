#!/bin/bash

# turn list of arguments into string to pass them as is to pwncat
# ARGS=$(echo "$@")
if [ $1 -eq -1 ]; then
    echo "No message ID"
    exit -1
fi

API="2f9bbev4416m2oer59vn7li7b6"

WD='/home/paul/repositories/sqlmap/'

TMPJSON="/tmp/sqlmap_zap_request.json"
TMPFILE="/tmp/sqlmap_zap_request.txt"

# fetch the file

# transform the file into raw request
zap_msgjson_to_request.py --apikey "$API" --msgid "$1" --out "$TMPFILE"

# activate virtualenv
CMD='source '"$WD"'env/bin/activate'
# append command
CMD="$CMD"' && '"$WD"'sqlmap.py --batch -r '"$TMPFILE"

# execute in own bash instance
# this prevents the virtualenv
echo running \""$CMD"\" in $(pwd)
echo ---------------start---------------
/bin/bash -c "$CMD"
echo ----------------end----------------

rm "$TMPFILE"
