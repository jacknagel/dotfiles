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
# M   - show line numbers in prompt
# R   - output ANSI colors
# X   - don't clear screen on exit
# j.5 - center search results
# q   - quiet, visual bell
LESS="FMRXj.5q"
LESSHISTFILE=-
export LESS LESSHISTFILE

export NODE_REPL_HISTORY="$XDG_DATA_HOME/node/repl_history"

LSCOLORS=ExGxFxdxCxfxDxxbadacad
LS_COLORS="di=1;34:ln=1;36:so=1;35:pi=33:ex=1;32:bd=35:cd=1;33:su=0;41:sg=30;43:tw=30;42:ow=30;43"
export LSCOLORS LS_COLORS

export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/rg/config"

export KUBECTL_EXTERNAL_DIFF=kubectl-diff-helper

export GOPRIVATE=github.com/jacknagel

if [ -r "$NIX_PROFILE/etc/profile.d/bash_completion.sh" ]; then
  # shellcheck disable=2034
  BASH_COMPLETION_COMPAT_DIR=$NIX_PROFILE/etc/bash_completion.d
  . "$NIX_PROFILE/etc/profile.d/bash_completion.sh"
fi

if [ -r "$NIX_PROFILE/share/bash-completion/completions/git-prompt.sh" ]; then
  . "$NIX_PROFILE/share/bash-completion/completions/git-prompt.sh"
elif [ -r /etc/bash_completion.d/git-prompt ]; then
  . /etc/bash_completion.d/git-prompt
else
  git_prompt_path=$(xcode-select -print-path 2>/dev/null)/usr/share/git-core/git-prompt.sh
  if [ -r "$git_prompt_path" ]; then
    . "$git_prompt_path"
  fi
fi

# shellcheck disable=SC2034
{
  GIT_PS1_DESCRIBE_STYLE=branch
  GIT_PS1_SHOWCOLORHINTS=1
  GIT_PS1_SHOWCONFLICTSTATE=1
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
  local template='_set_ps1 "{{ title "\\w" }}{{ user | suffix " " }}{{ aws | parens | suffix " " }}{{ kubeconfig | parens | suffix " " }}{{ nixshell | parens | suffix " "}}{{ pwd }}" " {{ promptchar }} " " {{ parens "%s" }}"'
  eval "$(prompt-template "$template" 2>/dev/null)"

  history -a
}
PROMPT_COMMAND=_prompt_command

_load_completion () {
  case "$1" in
    docker) . <(docker completion bash) ;;
    op) . <(op completion bash) ;;
  esac

  return 124
}

if command -v docker >/dev/null 2>&1; then
  complete -F _load_completion -o bashdefault -o default docker docker-compose
fi

if command -v op >/dev/null 2>&1; then
  complete -F _load_completion -o bashdefault -o default op
fi

if [ -r "$NIX_PROFILE/bin/complete_alias" ]; then
  . "$NIX_PROFILE/bin/complete_alias" 2>/dev/null
  complete -F _complete_alias "${!BASH_ALIASES[@]}" 2>/dev/null
fi
