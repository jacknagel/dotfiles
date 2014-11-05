#!/bin/sh

set -e

cd /

for id in "$@"; do
  bom=/var/db/receipts/com.apple.pkg.${id}.bom
  plist=/var/db/receipts/com.apple.pkg.${id}.plist

  if [ -f "$bom" ]; then
    lsbom -fls "$bom" | xargs -I{} rm -r "{}"
    rm $bom $plist
  fi
done
