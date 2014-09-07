#!/bin/bash

set -e
set -u

PSQL=/usr/local/bin/psql

DB_USER=wang
DB_HOST=127.0.0.1
DB_NAME=postgres

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
   test -d $folder || echo $folder 
done
