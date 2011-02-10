### ~/.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


export EDITOR='mate -w'
export GIT_EDITOR='mate -wl1'


## History control
export HISTCONTROL=ignoreboth
shopt -s histappend


## PATH
# Put /usr/local/{sbin,bin} first
export PATH=/usr/local/bin:/usr/local/shit/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH

# Add local bin to PATH
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi

## Tab completions
set completion-ignore-case On

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi


## Custom prompt
if [ "$PS1" ]; then

	PS1='\u:\w\[\e[1m\]$\[\e[m\] '
	# PS1='\u@\$ '
	# PS1='\u@\h:\W\$ '
fi

## Colors and ls
export LSCOLORS=hxfxcxdxbxegedabagHxHx

## List aliases
# -G = enable colors
# alias ls="ls -G"
alias ll='ls -l -h'
alias la="ls -a"
alias l="ls"
alias lla="ls -l -a"
alias fl='ls -lFrta | less'


## Aliases
alias cls='clear'
alias edit='mate'
alias vi='vim'
alias sizes='du -h -d1'

# show/hide hidden files in Finder
alias shd='defaults write com.apple.Finder AppleShowAllFiles YES'
alias hhd='defaults write com.apple.Finder AppleShowAllFiles NO'


## Functions
# Open a manpage in Preview, which can be saved to PDF
function pman {
   man -t "${1}" | open -f -a /Applications/Preview.app
}