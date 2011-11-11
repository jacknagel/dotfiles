# ~/.bashrc: bash(1) configuration

# if not running interactively, don't do anything
[ -z "$PS1" ] && return


# set en_US locale with utf-8 encodings
LANG="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_ALL="en_US.UTF-8"
export LANG LC_CTYPE LC_ALL


# path
PATH="/usr/bin:/bin:/usr/sbin:/sbin"
PATH="/usr/local/bin:/usr/local/sbin:$PATH"
PATH="$PATH:/usr/local/texbin"

if [[ -d "$HOME/bin" ]]
then
	PATH="$HOME/bin:$PATH"
fi

MANPATH="/usr/local/share/man:/usr/share/man"
export PATH MANPATH


# mail
unset MAIL
MAILCHECK=600
MAILPATH="$HOME/mail/inbox:/tmp/alpine.info?You have mail in alpine"

for mbox in ~/mail/f/[^.]*
do
	MAILPATH="$MAILPATH:$mbox"
done


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
if [[ ! -d ~/.history ]]
then
	mkdir ~/.history
fi

HISTSIZE=100000
HISTFILESIZE=100000
HISTFILE="$HOME/.history/bash"
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="ls:cd:cd ..:..*:[bf]g:exit"


# bash shell options
shopt -s autocd cdspell dirspell
shopt -s dotglob extglob globstar
shopt -s cmdhist histappend
shopt -s no_empty_cmd_completion
shopt -s checkjobs
shopt -s checkwinsize


# bash completion
if [[ -e /usr/local/share/bash-completion/bash_completion ]]
then
	source /usr/local/share/bash-completion/bash_completion
fi


# __git_ps1 configuration
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWDIRTYSTATE GIT_PS1_SHOWSTASHSTATE
export GIT_PS1_SHOWUNTRACKEDFILES GIT_PS1_SHOWUPSTREAM


# PS1 with git status
# PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
PROMPT_GIT='$(__git_ps1 " \[\033[1;32m\](%s)")'
PROMPT_PRE="\[\033[1;30m\][\u@\h \[\033[1;34m\]\W"
PROMPT_SUF="\[\033[1;30m\]]\$\[\033[0m\] "
PS1="${PROMPT_PRE}${PROMPT_GIT}${PROMPT_SUF}"
export PS1


export GPG_TTY=$(tty) # make gpg/pinentry behave sanely
