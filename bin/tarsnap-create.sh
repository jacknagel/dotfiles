#!/usr/bin/env bash

# create tarsnap backups
# to interrupt tarsnap, use 'kill -3 PID'

MID="mbp"
DIRS="/Users/jacknagel/docs /Users/jacknagel/projects /Users/jacknagel/school"

DATE_STRING=`date +%Y-%m-%d`
POSIX_TIME=`date +%s`

SNAP_NAME=${MID}_backup_${DATE_STRING}_${POSIX_TIME}
tarsnap -c -f ${SNAP_NAME} ${DIRS}
