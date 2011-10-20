#!/bin/bash
# This is dumb, and also helpful.

echo "Parent shell:"
echo "\$BASH_SUBSHELL = $BASH_SUBSHELL"
echo "\$SHLVL = 1"
echo

echo "Script execution (not a subshell):"
echo "\$\$ = $$"
echo "\$BASHPID = $BASHPID"
echo "\$BASH_SUBSHELL = $BASH_SUBSHELL"
echo "\$SHLVL = $SHLVL"
echo

( echo "Inside of subshell:"
  echo "\$\$ = $$"
  echo "\$BASHPID = $BASHPID"
  echo "\$BASH_SUBSHELL = $BASH_SUBSHELL"
  echo "\$SHLVL = $SHLVL" 
  echo

  ( echo "Inside of subshell of subshell:"
    echo "\$\$ = $$"
    echo "\$BASHPID = $BASHPID"
    echo "\$BASH_SUBSHELL = $BASH_SUBSHELL"
    echo "\$SHLVL = $SHLVL"
  )
)
