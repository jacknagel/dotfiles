# ~/.bashrc: bash(1) configuration

# if not running interactively, don't do anything
[ -z "$PS1" ] && return

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
LESS="FiqRSwX"
EDITOR="vim"
PAGER="less"
MANPAGER="less -+$LESS -iRSw"
LESSHISTFILE="-"
export LESS EDITOR PAGER MANPAGER LESSHISTFILE


# colors
CLICOLOR=1
LSCOLORS=ExGxFxdxCxDaDahbadacec
GREP_OPTIONS="--color=auto"
GREP_COLOR="1;32"
export CLICOLOR LSCOLORS GREP_OPTIONS GREP_COLOR


# files
FIGNORE="~:.pyc:.swp:.swa:.git" # things to ignore during tab completion
COPYFILE_DISABLE=true #no ._ (OS X resource fork) files in archives
export FIGNORE COPYFILE_DISABLE


# history control
[[ -d $HOME/.history ]] || mkdir $HOME/.history

HISTSIZE=100000
HISTFILESIZE=1000000
HISTFILE="$HOME/.history/bash"
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="ls:cd:cd ..:..*:[bf]g:exit:ssh*"


# bash shell options
shopt -s autocd cdspell dirspell
shopt -s dotglob extglob globstar
shopt -s cmdhist histappend
shopt -s no_empty_cmd_completion
shopt -s checkjobs
shopt -s checkwinsize


# tab completion
for file in \
	/usr/local/share/bash-completion/bash_completion \
	$HOME/src/git/contrib/completion/git-completion.bash
do
	[[ -e $file ]] && . $file
done


# PS1
# includes git status and Homebrew debug status
# PS1='[\u@\h \W$(__git_ps1 " (%s)")$(__brew_ps1 " (%s)")]\$ '
__brew_ps1 ()
{
	[[ -z $HOMEBREW_DEBUG_INSTALL ]] ||
		printf "${1:- (%s)}" "$HOMEBREW_DEBUG_INSTALL|DEBUG"
}

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWDIRTYSTATE GIT_PS1_SHOWSTASHSTATE
export GIT_PS1_SHOWUNTRACKEDFILES GIT_PS1_SHOWUPSTREAM

PROMPT_GIT='$(__git_ps1 " \[\033[1;32m\](%s)")'
PROMPT_BRW='$(__brew_ps1 " \[\033[1;36m\](%s)")'
PROMPT_PRE="\[\033[1;30m\][\u@\h \[\033[1;34m\]\W"
PROMPT_SUF="\[\033[1;30m\]]\$\[\033[0m\] "
PS1="${PROMPT_PRE}${PROMPT_GIT}${PROMPT_BRW}${PROMPT_SUF}"
export PS1


# gpg-agent
agentfile="$HOME/.gnupg/agent.env"

if test -f "$agentfile" && kill -0 $(grep -e "GPG_AGENT_INFO" "$agentfile" | cut -d: -f 2) 2>/dev/null
then
	eval "$(cat "$agentfile")"
else
	eval "$(gpg-agent --daemon --write-env-file="$agentfile")"
fi

GPG_TTY=$(tty)
export GPG_TTY GPG_AGENT_INFO
export HOMEBREW_KEEP_INFO=1
