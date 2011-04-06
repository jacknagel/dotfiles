#!/usr/bin/env bash

# extract a date from filename and put it in the 'date modified' field
# to finish the job, use Automator or Applescript to copy the date from
# 'date modified' to 'date created'

# command format:
# touch -mt YYYYMMDDhhmm.SS filename

SUFFIX=JPG

for FILE in $(ls *.$SUFFIX); do
    touch -mt 20${FILE:4:2}${FILE:0:4}0600.00 ${FILE}
done
