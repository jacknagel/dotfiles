# shellcheck shell=bash disable=SC1090

# shellcheck source=shrc
[ -r "$HOME/.shrc" ] && . "$HOME/.shrc"

[ -z "$PS1" ] && return

shopt -s cdspell
shopt -s checkhash
shopt -s checkjobs 2>/dev/null
shopt -s direxpand 2>/dev/null && shopt -s dirspell
shopt -s dotglob
shopt -s extglob
shopt -s globstar 2>/dev/null
shopt -s histappend
shopt -s no_empty_cmd_completion

unset MAILCHECK

HISTSIZE=10000
HISTFILESIZE=100000
HISTFILE="$XDG_DATA_HOME/bash/history"
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE=" *:%[0-9]:&:[bf]g:cd:cd ..:cd [-~]:clear:exit:ls:pwd"
[ -d "${HISTFILE%/*}" ] || mkdir -p "${HISTFILE%/*}"

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
LESSHISTFILE=-
export LESS LESSHISTFILE

export NODE_REPL_HISTORY="$XDG_DATA_HOME/node/repl_history"

LSCOLORS=ExGxFxdxCxfxDxxbadacad
LS_COLORS="di=1;34:ln=1;36:so=1;35:pi=33:ex=1;32:bd=35:cd=1;33:su=0;41:sg=30;43:tw=30;42:ow=30;43"
export LSCOLORS LS_COLORS

export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/rg/config"

export KUBECTL_EXTERNAL_DIFF=kubectl-diff-helper

export GO111MODULE=on
export GOPRIVATE=github.com/jacknagel

if [ -r "$NIX_PROFILE/etc/profile.d/bash_completion.sh" ]; then
  # shellcheck disable=2034
  BASH_COMPLETION_COMPAT_DIR=$NIX_PROFILE/etc/bash_completion.d
  . "$NIX_PROFILE/etc/profile.d/bash_completion.sh"
fi

if [ -r "$NIX_PROFILE/bin/complete_alias" ]; then
  . "$NIX_PROFILE/bin/complete_alias"
fi

if [ -r "$NIX_PROFILE/share/bash-completion/completions/git-prompt.sh" ]; then
  . "$NIX_PROFILE/share/bash-completion/completions/git-prompt.sh"
fi

# shellcheck disable=SC2034
{
  GIT_PS1_DESCRIBE_STYLE=branch
  GIT_PS1_SHOWCOLORHINTS=1
  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWSTASHSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWUPSTREAM=auto
}

if declare -F __git_ps1 >/dev/null; then
  _set_ps1 () {
    __git_ps1 "$@"
  }
else
  _set_ps1 () { PS1="$1$2"; }
fi

_prompt_command () {
  local title="\[\033]0;\w\007\]"
  local template='_set_ps1 "'"$title"'{{ user | suffix " " }}{{ aws | parens | suffix " " }}{{ kubeconfig | parens | suffix " " }}{{ nixshell | parens | suffix " "}}{{ pwd }}" " {{ promptchar }} "'
  eval "$(prompt-template "$template" 2>/dev/null)"

  history -a
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
    node) _source_completion <(node --completion-bash) ;;
    docker) _source_completion /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion ;;
    docker-compose) _source_completion /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion ;;
    aws-vault) _source_completion <(aws-vault --completion-script-bash) ;;
  esac
}

if [ -d "/Applications/Docker.app" ]; then
  complete -F _load_completion -o bashdefault -o default docker docker-compose
fi

if command -v node >/dev/null 2>&1; then
  complete -F _load_completion -o bashdefault -o default node
fi

if command -v aws-vault >/dev/null 2>&1; then
  complete -F _load_completion -o bashdefault -o default aws-vault
fi

if command -v terraform >/dev/null 2>&1; then
  complete -C terraform terraform
fi

complete -F _complete_alias "${!BASH_ALIASES[@]}"
