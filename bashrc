# vim:set ft=sh et sw=2:

export ENV="$HOME/.shrc"
. "$ENV"
[ -z "$PS1" ] && return

shopt -s cdspell
shopt -s direxpand 2>/dev/null && shopt -s dirspell
shopt -s dotglob
shopt -s extglob
shopt -s globstar 2>/dev/null
shopt -s cmdhist
shopt -s histappend
shopt -s no_empty_cmd_completion
shopt -s checkjobs 2>/dev/null
shopt -s checkwinsize

unset MAILCHECK

FIGNORE=".swp"
HISTSIZE=10000
HISTFILESIZE=100000
HISTFILE="$HOME/.history/bash"
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE=$(tr '\n' ':' <"$HOME/.histignore")


LANG="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_ALL="en_US.UTF-8"
export LANG LC_CTYPE LC_ALL


EDITOR="vim"
VISUAL="vim"
SUDO_EDITOR="vim -n -i NONE"
PAGER="less"
MANPAGER="less"
BROWSER="open"
LESS="FRXiq"
LESSHISTFILE="$HOME/.history/less"
export EDITOR VISUAL SUDO_EDITOR PAGER MANPAGER BROWSER LESS LESSHISTFILE


CLICOLOR=1
LSCOLORS=ExGxFxdxCxDaDahbadacec
GREP_COLORS="mt=01;31:sl=:cx=:fn=:ln=:bn=:se=00;36"
export CLICOLOR LSCOLORS GREP_COLORS


[ -d "$HOME/.history" ] || mkdir "$HOME/.history"


cd () {
  builtin cd "$@" >/dev/null
}

bold="\[\033[1m\]"
blue="\[\033[0;34m\]"
reset="\[\033[0m\]"

PS1="\u@\h${blue}:\W${reset} ${bold}\$${reset} "
PS2="${bold}..>${reset} "

if [ -f "/usr/local/etc/bash_completion.d/git-prompt.sh" ]; then
  . "/usr/local/etc/bash_completion.d/git-prompt.sh"
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWSTASHSTATE=1
  GIT_PS1_SHOWCOLORHINTS=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWUPSTREAM=auto
  GIT_PS1_DESCRIBE_STYLE=branch
  PROMPT_COMMAND="__git_ps1 '\u@\h${blue}:\W${reset}' ' ${bold}\\$ ${reset}' '(%s)'"
fi

if [ "${BASH_VERSINFO[0]}${BASH_VERSINFO[1]}" -gt 40 -a -f "/usr/local/share/bash-completion/bash_completion" ]; then
  . "/usr/local/share/bash-completion/bash_completion" 2>/dev/null
elif [ -f "/usr/local/etc/bash_completion" ]; then
  . "/usr/local/etc/bash_completion" 2>/dev/null
fi
