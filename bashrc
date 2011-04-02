#
# ~/.bashrc
#

# if not running interactively, don't do anything
[ -z "$PS1" ] && return


# fancy prompt
source ~/.bash_prompt


# set en_US locale w/ utf-8 encodings
LANG="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_ALL="en_US.UTF-8"
export LANG LC_CTYPE LC_ALL


# path
PATH="/usr/bin:/bin:/usr/sbin:/sbin"
PATH="/usr/local/bin:/usr/local/sbin:$PATH"

if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

MANPATH="/usr/share/man:/usr/local/share/man"

CDPATH=".:$HOME"

export PATH MANPATH


# editor/pager
EDITOR="mate -w"
PAGER="less -iRSw"
MANPAGER="less -iRSw"
LESSHISTFILE="-"
export EDITOR PAGER MANPAGER LESSHISTFILE


# colors
CLICOLOR=1
# CLICOLOR_FORCE=1 # this breaks things when using pipes
LSCOLORS=ExFxCxDxBxegedabagacad
GREP_OPTIONS='--color=auto'
GREP_COLOR='1;31'
export CLICOLOR LSCOLORS GREP_OPTIONS GREP_COLOR


# files
FIGNORE="~:.pyc:.swp:.swa:" # suffixes to ignore during tab completion
COPYFILE_DISABLE=true #no ._ files in archives
export FIGNORE COPYFILE_DISABLE


# history control
HISTSIZE=10000
SAVEHIST=10000
HISTFILESIZE=10000
HISTCONTROL=ignoreboth:erasedups


# Bash shell options
shopt -s autocd cdspell dirspell
shopt -s dotglob extglob globstar
shopt -s cmdhist histappend
shopt -s no_empty_cmd_completion
shopt -s checkjobs
shopt -s checkwinsize


# Bash completion
for comp in \
    /usr/local/etc/bash_completion \
    /usr/local/etc/bash_completion.d/git-completion.bash \
    /usr/local/Library/Contributions/brew_bash_completion.sh
do
    [[ -e $comp ]] && source $comp
done
