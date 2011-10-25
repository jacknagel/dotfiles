#!/bin/sh

if [[ $GIT_PR_ID ]]
then
	closes="Closes #${GIT_PR_ID}."
	sob="Signed-off-by: $(git config --get user.name) <$(git config --get user.email)>"
	grep -Eqs "^${closes}$" $1 || sed -Ei" " "s/^(${sob})$/${closes}\\
\\
\1/" $1
fi
