#!/bin/sh

set -e

cd /

for id in "$@"; do
  bom=/var/db/receipts/${id}.bom
  plist=/var/db/receipts/${id}.plist

  if [ -f "$bom" ]; then
    lsbom -fls "$bom" | xargs -I{} rm -rf "{}"
    rm $bom $plist
  fi
done
