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

if [[ -d "$HOME/bin" ]]; then
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
LESS="FiRSwX"
EDITOR="vim"
PAGER="less"
MANPAGER="less -+$LESS -iRSw"
LESSHISTFILE="-"
export LESS EDITOR PAGER MANPAGER LESSHISTFILE


# colors
CLICOLOR=1
LSCOLORS=ExGxFxdxCxDaDahbadacec
GREP_OPTIONS='--color=auto'
GREP_COLOR='1;32'
export CLICOLOR LSCOLORS GREP_OPTIONS GREP_COLOR


# files
FIGNORE="~:.pyc:.swp:.swa:.git" # things to ignore during tab completion
COPYFILE_DISABLE=true #no ._ files in archives
export FIGNORE COPYFILE_DISABLE


# history control
if [[ ! -d ~/.history ]]; then
    mkdir ~/.history
fi

HISTSIZE=100000
HISTFILESIZE=100000
HISTFILE="$HOME/.history/bash"
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="ls:cd:cd ..:..*:[ ]*"


# bash shell options
shopt -s autocd cdspell dirspell
shopt -s dotglob extglob globstar
shopt -s cmdhist histappend
shopt -s no_empty_cmd_completion
shopt -s checkjobs
shopt -s checkwinsize


# bash completion
for comp in \
    /usr/local/etc/bash_completion \
    /usr/local/etc/bash_completion.d/git-completion.bash \
    /usr/local/Library/Contributions/brew_bash_completion.sh
do
    [[ -e $comp ]] && source $comp
done


# __git_ps1 configuration
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM=auto # "auto verbose"
export GIT_PS1_SHOWDIRTYSTATE GIT_PS1_SHOWSTASHSTATE
export GIT_PS1_SHOWUNTRACKEDFILES GIT_PS1_SHOWUPSTREAM


# PS1 with git status
PROMPT_GIT='$(__git_ps1 "\[\e[1;30m\]:\[\e[0;32m\]%s\[\e[1;30m\]")'
PROMPT_PRE="\[\e[1;30m\][\u@\h \[\e[1;34m\]\W"
PROMPT_SUF="\[\e[1;30m\]]\$\[\e[0m\] "
PS1="${PROMPT_PRE}${PROMPT_SUF}"
export PS1


# make gpg2/pinentry behave sanely
GPG_TTY=`tty`
export GPG_TTY
