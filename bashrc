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
export EDITOR VISUAL SUDO_EDITOR PAGER MANPAGER BROWSER

# F   - exit if content fits on one screen
# R   - output ANSI colors
# X   - don't clear screen on exit
# j.5 - center search results
# q   - quiet, visual bell
LESS="FRXj.5q"
LESSHISTFILE="$HOME/.history/less"
export LESS LESSHISTFILE

export NODE_REPL_HISTORY="$HOME/.history/node_repl"

CLICOLOR=1
LSCOLORS=ExGxFxdxCxfxDxxbadacad
LS_COLORS="di=1;34:ln=1;36:so=1;35:pi=33:ex=1;32:bd=35:cd=1;33:su=0;41:sg=30;43:tw=30;42:ow=30;43"
export CLICOLOR LSCOLORS LS_COLORS


[ -d "$HOME/.history" ] || mkdir "$HOME/.history"


cd () {
  builtin cd "$@" >/dev/null
}

if [ -f "/usr/local/etc/bash_completion.d/git-prompt.sh" ]; then
  . "/usr/local/etc/bash_completion.d/git-prompt.sh"
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWSTASHSTATE=1
  GIT_PS1_SHOWCOLORHINTS=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWUPSTREAM=auto
  GIT_PS1_DESCRIBE_STYLE=branch
  __set_ps1 () { __git_ps1 "$@"; }
else
  __set_ps1 () { PS1="$1$2"; }
fi

__prompt_command () {
  local exit=$?
  local green="\[\e[0;32m\]"
  local yellow="\[\e[0;33m\]"
  local blue="\[\e[0;34m\]"
  local reset="\[\e[0m\]"
  local ps1pre="${blue}\W${reset}"
  local ps1post=" ${yellow}»${reset} "

  __set_ps1 "$ps1pre" "$ps1post" " :: ${green}(${reset}%s${green})${reset}"
  PS2=" $ps1post"

  return $exit
}
PROMPT_COMMAND=__prompt_command

if [ "${BASH_VERSINFO[0]}${BASH_VERSINFO[1]}" -gt 40 -a -f "/usr/local/share/bash-completion/bash_completion" ]; then
  . "/usr/local/share/bash-completion/bash_completion" 2>/dev/null
elif [ -f "/usr/local/etc/bash_completion" ]; then
  . "/usr/local/etc/bash_completion" 2>/dev/null
fi

if [ -f "$HOME/.nvm/nvm.sh" ]; then
  . "$HOME/.nvm/nvm.sh" 2>/dev/null

  _load_nvm_bash_completion () {
    . "$HOME/.nvm/bash_completion" 2>/dev/null &&
      compopt +o nospace nvm &&
      return 124
  }

  complete -F _load_nvm_bash_completion nvm
fi
