#!/bin/bash

set -e
set -u

PSQL=/usr/local/bin/psql

DB_USER=wang
DB_HOST=127.0.0.1
DB_NAME=postgres
DIR_BASE="/Users/wang/Projects/Web-Programming/Bash"

$PSQL \
    -X \
    -h $DB_HOST \
    -U $DB_USER \
    -c "select folder from my_table where kbn='K1'" \
    --single-transaction \
    --set AUTOCOMMIT=off \
    --set ON_ERROR_STOP=on \
    --no-align \
    -t \
    --field-separator ' ' \
    --quiet \
    -d $DB_NAME \
| while read folder; do
    #if [ ! -z "$folder" -a -d "$DIR_BASE/$folder" ]; then
    if [ ! -z "$folder" -a -d "$DIR_BASE/$folder/" ]; then
        echo "removing $DIR_BASE/$folder/ directory's contents..."
        rm -rf "$DIR_BASE/$folder/"*
        echo "Directory's contents removed"
    fi
done
