#!/usr/bin/env bash -e

# prune tarsnap backups
# backups have the form {MID}_backup_{DATE_STRING}_{POSIX_TIME}
# all pruning can be done by looking at POSIX_TIME

MID="mbp"
POSIX_TIME=`date +%s`

PREFIX=${MID}_backup
SNAP_NUM=`tarsnap --list-archives | grep ${PREFIX} | wc -l | sed -e 's/ //g'`
SNAP_MIN=15

# delete snapshots older than 30 days if there are at least 15 snapshots

for snap in `tarsnap --list-archives | sort`; do
    if [[ $SNAP_NUM -le $SNAP_MIN ]]; then
        echo "Snapshot minimum (${SNAP_MIN}) reached:" \
             "${SNAP_NUM} snapshots exist. Exiting..."
        exit 0
    fi

    snap_prefix=`echo ${snap} | cut -f1,2 -d'_'`

    if [[ $PREFIX != $snap_prefix ]]; then
        echo "Wrong prefix: snapshot ${snap} skipped."
        continue;
    fi

    snap_time=`echo ${snap} | cut -f4 -d'_'`
    diff_time=`expr ${POSIX_TIME} - ${snap_time}`

    if [[ $diff_time -gt "2592000" ]]; then
        echo "Deleting snapshot ${snap}..."
        sleep 1
        echo "tarsnap -d -f ${snap}"
        $SNAP_NUM=`expr ${SNAP_NUM} -1`
    fi
done
