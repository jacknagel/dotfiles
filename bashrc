# vim:set ft=sh et sw=2:

export ENV="$HOME/.shrc"
. "$ENV"
[ -z "$PS1" ] && return

[ -f ~/.bash_aliases ] && . ~/.bash_aliases

unset MAILCHECK

LANG="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_ALL="en_US.UTF-8"
export LANG LC_CTYPE LC_ALL


MANPATH="/usr/local/share/man:/usr/share/man"
INFOPATH="/usr/local/share/info:/usr/share/info"
export MANPATH INFOPATH


EDITOR="vim"
VISUAL="vim"
PAGER="less"
MANPAGER="less"
BROWSER="open"
LESS="FRSXiq"
LESSHISTFILE="-"
export EDITOR VISUAL PAGER MANPAGER BROWSER LESS LESSHISTFILE


CLICOLOR=1
LSCOLORS=ExGxFxdxCxDaDahbadacec
GREP_OPTIONS="--color=auto"
GREP_COLORS="mt=01;31:sl=:cx=:fn=:ln=:bn=:se=00;36"
export CLICOLOR LSCOLORS GREP_OPTIONS GREP_COLORS


FIGNORE=".swp"
COPYFILE_DISABLE=1 #no ._ (OS X resource fork) files in archives
export FIGNORE COPYFILE_DISABLE


[ -d "$HOME/.history" ] || mkdir "$HOME/.history"

HISTSIZE=10000
HISTFILESIZE=10000
HISTFILE="$HOME/.history/bash"
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE=$(tr '\n' ':' <"$HOME/.history/histignore")


shopt -s cdspell dirspell
shopt -s dotglob extglob globstar
shopt -s cmdhist histappend
shopt -s no_empty_cmd_completion
shopt -s checkjobs
shopt -s checkwinsize


for file in \
  /usr/local/share/bash-completion/bash_completion \
  $HOME/src/git/contrib/completion/git-prompt.sh
do
  [ -e $file ] && . $file
done


BOLD="\[\033[1m\]"
BLUE="\[\033[0;34m\]"
CYAN="\[\033[0;36m\]"
GREEN="\[\033[0;32m\]"
RESET="\[\033[0m\]"

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWDIRTYSTATE GIT_PS1_SHOWSTASHSTATE
export GIT_PS1_SHOWUNTRACKEDFILES GIT_PS1_SHOWUPSTREAM

PROMPT_GIT='$(__git_ps1 "'${GREEN}'(%s)'${RESET}'")'
PROMPT_PRE="\u@\h${BLUE}:\W${RESET}"
PROMPT_SUF="${BOLD} \$${RESET} "
PS1="${PROMPT_PRE}${PROMPT_GIT}${PROMPT_SUF}"
PS2="${BOLD}..>${RESET} "


cd () {
  builtin cd "$@" >/dev/null
}

export HOMEBREW_KEEP_INFO=1
export HOMEBREW_DEVELOPER=1
