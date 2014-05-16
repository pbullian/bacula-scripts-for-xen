#!/bin/bash
exec > /dev/null
DUMPDIR=/root
FIFODIR=$DUMPDIR/fifo
export PGUSER=postgres
export PGPASSWORD=XXXXXXXXXX
# only when pg_hba.conf requires it
/usr/bin/pg_dumpall -g -h 127.0.0.1>$DUMPDIR/globalobjects.dump
# hopefully never a big file, so no need for a fifo
rm -f $FIFODIR/*.dump
for dbname in `psql -d template1 -q -t -h 127.0.0.1<<EOF
select datname from pg_database where not datname in ('bacula','template0') order by datname;
EOF
` 
do
 pg_dump $dbname --file=$FIFODIR/$dbname.dump -h 127.0.0.1 2>&1 < /dev/null  
done
