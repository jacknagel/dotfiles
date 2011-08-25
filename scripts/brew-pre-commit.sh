#!/usr/bin/env bash -e

for filename in $(git diff-index --cached --name-only --diff-filter=AM HEAD)
do
	if [[ $filename =~ "Library/Formula/" ]]; then
		brew audit --strict ./$filename
	fi
done
