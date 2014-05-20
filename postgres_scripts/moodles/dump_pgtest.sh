#!/bin/bash

BASE=moodle
IP=localhost
DATE=`date '+%y%m%d%s'`
TMP=/backups/

pg_dump -i -h $IP -p 5432 -U postgres -F c -b -v -f "$TMP/$BASE-$DATE.backup" $BASE

