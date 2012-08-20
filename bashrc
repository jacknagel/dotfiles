# ~/.bashrc: bash(1) configuration

# if not running interactively, don't do anything
[ -z "$PS1" ] && return

[ -f ~/.bash_aliases ] && . ~/.bash_aliases

unset MAILCHECK

# locale
LANG="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_ALL="en_US.UTF-8"
export LANG LC_CTYPE LC_ALL


# path
PATH="/usr/bin:/bin:/usr/sbin:/sbin"
PATH="/usr/local/bin:/usr/local/sbin:$PATH"
PATH="$PATH:/usr/local/texbin"
PATH="/usr/local/share/python:$PATH"
PATH="$HOME/bin:$PATH"

MANPATH="/usr/local/share/man:/usr/share/man:/usr/X11/share/man"
INFOPATH="/usr/local/share/info:/usr/share/info"
export PATH MANPATH INFOPATH


# editor/pager
EDITOR="vim"
PAGER="less"
MANPAGER="less"
LESS="FiqRSw"
LESSHISTFILE="-"
export EDITOR PAGER MANPAGER LESS LESSHISTFILE


# colors
CLICOLOR=1
LSCOLORS=ExGxFxdxCxDaDahbadacec
GREP_OPTIONS="--color=auto"
GREP_COLORS="mt=01;31:sl=:cx=:fn=:ln=:bn=:se=00;36"
export CLICOLOR LSCOLORS GREP_OPTIONS GREP_COLORS


# files
FIGNORE="~:.pyc:.swp:.swa:.git" # things to ignore during tab completion
COPYFILE_DISABLE=true #no ._ (OS X resource fork) files in archives
export FIGNORE COPYFILE_DISABLE


# history control
[[ -d "$HOME/.history" ]] || mkdir "$HOME/.history"

HISTSIZE=10000
HISTFILESIZE=10000
HISTFILE="$HOME/.history/bash"
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE=$(tr '\n' ':' < "$HOME/.history/histignore")


# bash shell options
shopt -s cdspell dirspell
shopt -s dotglob extglob globstar
shopt -s cmdhist histappend
shopt -s no_empty_cmd_completion
shopt -s checkjobs
shopt -s checkwinsize


# tab completion
for file in \
	/usr/local/share/bash-completion/bash_completion \
	$HOME/src/git/contrib/completion/git-prompt.sh
do
	[[ -e $file ]] && . $file
done


# prompt
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

PROMPT_GIT='$(__git_ps1 " '${GREEN}'(%s)'${RESET}'")'
PROMPT_BRW='$(__brew_ps1 " '${CYAN}'(%s)'${RESET}'")'
PROMPT_PRE="${BOLD}[${RESET}\u@\h ${BLUE}\W${RESET}"
PROMPT_SUF="${BOLD}]\$${RESET} "
PS1="${PROMPT_PRE}${PROMPT_GIT}${PROMPT_BRW}${PROMPT_SUF}"
PS2="${BOLD}..>${RESET} "


# miscellaneous setup
setup_gpg_session
export HOMEBREW_KEEP_INFO=1
