#!/bin/sh
FIFODIR=/root/fifo
for dbname in `psql -d template1 -q -U postgres -h 127.0.0.1 -t  <<EOF
select datname from pg_database where not datname in ('bacula','template0') order by datname;
EOF
`
do
 echo "$FIFODIR/$dbname.dump"
done
