# vim:set ft=sh et sw=2:

export ENV="$HOME/.shrc"
. "$ENV"
[ -z "$PS1" ] && return

unset MAILCHECK

LANG="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_ALL="en_US.UTF-8"
export LANG LC_CTYPE LC_ALL


EDITOR="vim"
VISUAL="vim"
PAGER="less"
MANPAGER="less"
BROWSER="open"
LESS="FRXiq"
LESSHISTFILE="$HOME/.history/less"
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


shopt -s cdspell
shopt -s dirspell 2>/dev/null
shopt -s dotglob
shopt -s extglob
shopt -s globstar 2>/dev/null
shopt -s cmdhist
shopt -s histappend
shopt -s no_empty_cmd_completion
shopt -s checkjobs 2>/dev/null
shopt -s checkwinsize

cd () {
  builtin cd "$@" >/dev/null
}


completion="/usr/local/share/bash-completion/bash_completion"
if [ "${BASH_VERSINFO[0]}" -ge "4" -a "${BASH_VERSINFO[1]}" -ge "1" -a -f "$completion" ]; then
  . /usr/local/share/bash-completion/bash_completion
fi
unset completion


if [ -d "/usr/local/opt/chruby" ]; then
  . "/usr/local/opt/chruby/share/chruby/chruby.sh"
  . "/usr/local/opt/chruby/share/chruby/auto.sh"
  chruby 2.0.0-p247 &>/dev/null
fi
