#!/bin/bash

# turn list of arguments into string to pass them as they are
# ARGS=$(echo "$@")
if [ $1 -eq -1 ]; then
    echo "No message ID"
    exit -1
fi

API="2f9bbev4416m2oer59vn7li7b6"

TMPJSON="/tmp/sqlmap_zap_request.json"
TMPFILE="/tmp/sqlmap_zap_request.txt"

# fetch the file

# transform the file into raw request
zap_msgjson_to_request.py --apikey "$API" --msgid "$1" --out "$TMPFILE"

CMD='"$CMD" && sqlmap --batch -r $TMPFILE'
/bin/bash -c "$CMD"

rm "$TMPJSON"
rm "$TMPFILE"

