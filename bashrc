# shellcheck shell=bash disable=SC1090,SC1117

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
  # shellcheck disable=2164
  builtin cd "$@" >/dev/null
}

if [ "${BASH_VERSINFO[0]}${BASH_VERSINFO[1]}" -ge 41 ] && [ -f "${PKG_PREFIX}/share/bash-completion/bash_completion" ]; then
  . "${PKG_PREFIX}/share/bash-completion/bash_completion"
elif [ -f "${PKG_PREFIX}/etc/bash_completion" ]; then
  . "${PKG_PREFIX}/etc/bash_completion"
else
  for file in "${PKG_PREFIX}"/etc/bash_completion.d/*; do
    [ -f "$file" ] && . "$file"
  done
  unset file
fi

_set_ps1_strings () {
  local bold red yellow blue cyan reset title

  bold=$(tput bold)
  red=$(tput setaf 1)
  yellow=$(tput setaf 3)
  blue=$(tput setaf 4)
  cyan=$(tput setaf 6)
  reset=$(tput sgr0)
  title=""

  _ps1_prefix=""
  _ps1_suffix=" ${yellow}»${reset} "

  if [ "$EUID" -eq 0 ]; then
    title="\u"
    _ps1_prefix="${bold}${red}\u${reset}"
    _ps1_suffix=" ${bold}${red}#${reset} "
  fi

  if [ -n "$SSH_TTY" ]; then
    title="\u@\h"
    _ps1_prefix="${_ps1_prefix:-${bold}${cyan}\u${reset}}${bold}${cyan}@\h${reset}"
  fi

  title="\[\033]0;${title} \w\007\]"
  _ps1_prefix="${title}${_ps1_prefix:+$_ps1_prefix }${blue}\W${reset}"
}
_set_ps1_strings

if declare -F __git_ps1 >/dev/null; then
  # shellcheck disable=SC2034
  _set_ps1 () {
    local GIT_PS1_SHOWDIRTYSTATE=1
    local GIT_PS1_SHOWSTASHSTATE=1
    local GIT_PS1_SHOWCOLORHINTS=1
    local GIT_PS1_SHOWUNTRACKEDFILES=1
    local GIT_PS1_SHOWUPSTREAM=auto
    local GIT_PS1_DESCRIBE_STYLE=branch
    __git_ps1 "$@"
  }
else
  _set_ps1 () { PS1="$1$2"; }
fi

_prompt_command () {
  local exit=$?

  _set_ps1 "$_ps1_prefix" "$_ps1_suffix"
  PS2=" $_ps1_suffix"

  history -a

  case "$(history 1)" in
    *install*) hash -r ;;
  esac

  return $exit
}
PROMPT_COMMAND=_prompt_command

_source_completion () {
  local aliases
  aliases=$(alias)
  unalias -a
  . "$1" >/dev/null 2>&1 || return 1
  eval "$aliases"
  return 124
}

_load_completion () {
  case "$1" in
    nvm) _source_completion ~/.nvm/bash_completion ;;
    npm) _source_completion <(npm completion) ;;
    docker) _source_completion /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion ;;
    docker-compose) _source_completion /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion ;;
  esac
}

NVM_DIR=~/.nvm
if [ -f "$NVM_DIR/nvm.sh" ]; then
  if [ -d "$NVM_DIR/versions/node" ] && type -t mapfile >/dev/null; then
    mapfile -t NODE_GLOBALS < <(find "$NVM_DIR/versions/node" -maxdepth 3 \( -type l -o -type f \) -wholename '*/bin/*' -exec basename -a {} + | sort -u)
  fi

  _nvm_shim () {
    local cmd=$1
    shift
    unset -f "${NODE_GLOBALS[@]}"
    declare -F nvm >/dev/null 2>&1 || [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    "$cmd" "${@}"
  }

  _setup_nvm_shims () {
    local cmd
    for cmd in "${NODE_GLOBALS[@]}" nvm; do
      if ! command -v "$cmd" >/dev/null 2>&1; then
        eval "${cmd} () { _nvm_shim \"$cmd\" \"\$@\"; }"
      fi
    done
  }

  _setup_nvm_shims
  complete -F _load_completion -o bashdefault -o default nvm npm
fi

if [ -d "/Applications/Docker.app" ]; then
  complete -F _load_completion -o bashdefault -o default docker docker-compose
fi

if command -v terraform >/dev/null 2>&1; then
  complete -C "$PKG_PREFIX"/bin/terraform terraform
fi
