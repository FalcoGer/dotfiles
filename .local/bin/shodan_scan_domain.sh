#!/bin/bash

LINES=$(dig +short "$1")

for LINE in $LINES; do
    echo "Query: $LINE"
    shodan host "$LINE"
done
