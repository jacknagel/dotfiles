# vim:set ft=sh et sw=2:
# shellcheck shell=bash disable=SC1090,SC1091

export ENV="$HOME/.shrc"
. "$ENV"
[ -z "$PS1" ] && return

shopt -s cdspell
shopt -s checkhash
shopt -s checkjobs 2>/dev/null
shopt -s checkwinsize
shopt -s cmdhist
shopt -s direxpand 2>/dev/null && shopt -s dirspell
shopt -s dotglob
shopt -s extglob
shopt -s globstar 2>/dev/null
shopt -s histappend
shopt -s no_empty_cmd_completion

unset MAILCHECK

HISTSIZE=10000
HISTFILESIZE=100000
HISTFILE="$HOME/.history/bash"
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE=" *:%[0-9]:&:[bf]g:cd:cd ..:cd [-~]:clear:exit:ls:pwd"
[ -d "$HOME/.history" ] || mkdir "$HOME/.history"

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

LSCOLORS=ExGxFxdxCxfxDxxbadacad
LS_COLORS="di=1;34:ln=1;36:so=1;35:pi=33:ex=1;32:bd=35:cd=1;33:su=0;41:sg=30;43:tw=30;42:ow=30;43"
export LSCOLORS LS_COLORS

cd () {
  builtin cd "$@" >/dev/null
}

if [ "${BASH_VERSINFO[0]}${BASH_VERSINFO[1]}" -gt 40 ] && [ -f "/usr/local/share/bash-completion/bash_completion" ]; then
  . "/usr/local/share/bash-completion/bash_completion"
elif [ -f "/usr/local/etc/bash_completion" ]; then
  . "/usr/local/etc/bash_completion"
else
  for file in /usr/local/etc/bash_completion.d/*; do
    [ -f "$file" ] && . "$file"
  done
fi

if declare -F __git_ps1 >/dev/null; then
  # shellcheck disable=SC2034
  __set_ps1 () {
    local GIT_PS1_SHOWDIRTYSTATE=1
    local GIT_PS1_SHOWSTASHSTATE=1
    local GIT_PS1_SHOWCOLORHINTS=1
    local GIT_PS1_SHOWUNTRACKEDFILES=1
    local GIT_PS1_SHOWUPSTREAM=auto
    local GIT_PS1_DESCRIBE_STYLE=branch
    __git_ps1 "$@";
  }
else
  __set_ps1 () { PS1="$1$2"; }
fi

__prompt_command () {
  local exit=$?
  local boldred="\[\e[1;31m\]"
  local green="\[\e[0;32m\]"
  local yellow="\[\e[0;33m\]"
  local blue="\[\e[0;34m\]"
  local reset="\[\e[0m\]"
  local ps1pre="${blue}\W${reset}"
  local ps1post=" ${yellow}»${reset} "

  if [ -n "$SSH_CLIENT" ]; then
    ps1pre="${green}\u@\h${reset}:${ps1pre}"
  fi

  if [ "$EUID" -eq 0 ]; then
    ps1post=" ${boldred}#${reset} "
  fi

  __set_ps1 "$ps1pre" "$ps1post" " :: ${green}(${reset}%s${green})${reset}"
  PS2=" $ps1post"

  history -a

  case "$(history 1)" in
    *install*) hash -r ;;
  esac

  return $exit
}
PROMPT_COMMAND=__prompt_command

if [ -f "$HOME/.nvm/nvm.sh" ]; then
  . "$HOME/.nvm/nvm.sh"

  _load_nvm_bash_completion () {
    . "$HOME/.nvm/bash_completion" && return 124
  }

  _load_npm_bash_completion () {
    type npm >/dev/null 2>&1 && . <(npm completion) && return 124
  }

  complete -F _load_nvm_bash_completion nvm
  complete -F _load_npm_bash_completion npm
fi
