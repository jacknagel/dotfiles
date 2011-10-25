#!/bin/sh

git diff-index --cached --name-only --diff-filter=AM HEAD | while read file
do
	if [[ $file =~ "Library/Formula/" ]]
	then
		brew audit --strict ./$file
	fi
done
