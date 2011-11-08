#!/bin/sh
# Extract a date from filename and use it to upate the file's mtime.
# To finish the job, use Automator or Applescript to copy the date from
# 'date modified' to 'date created'.
# $ touch -mt YYYYMMDDhhmm.SS filename

suffix=JPG

for file in $(ls *.$suffix)
do
	touch -mt 20${file:4:2}${file:0:4}0600.00 ${file}
done
