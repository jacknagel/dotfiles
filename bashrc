### ~/.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export EDITOR='mate -w'
export GIT_EDITOR='mate -wl1'

## File suffixes to ignore during tab completion
export FIGNORE="~:.pyc:.swp:.swa:"

## History control
export HISTCONTROL=ignoreboth:erasedups

## Bash shell options
shopt -s autocd cdspell dirspell
shopt -s dotglob extglob globstar
shopt -s cmdhist histappend
shopt -s no_empty_cmd_completion
shopt -s checkjobs

## Automatically adapt $LINES and $COLUMNS after every command
shopt -s checkwinsize 

## PATH
# Put /usr/local/{bin,sbin} first
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# bin folders from ~, shit, and Homebrew-built installations
for another_bin in \
    $HOME/bin \
    /usr/local/shit/bin
do
    [[ -e $another_bin ]] && export PATH=$PATH:$another_bin
done

if [[ -n `which brew` ]]; then
  # Find a Homebrew-built Python
  python_bin=$(brew --cellar python)/*/bin
  python_bin=`echo $python_bin`
  [[ -e $python_bin ]] && export PATH=$PATH:$python_bin

  # Find a Homebrew-built Python 3
  python3_bin=$(brew --cellar python3)/*/bin
  python3_bin=`echo $python3_bin`
  [[ -e $python3_bin ]] && export PATH=$PATH:$python3_bin

  # Find a Homebrew-built Ruby
  ruby_bin=$(brew --cellar ruby)/*/bin
  ruby_bin=`echo $ruby_bin`
  [[ -e $ruby_bin ]] && export PATH=$PATH:$ruby_bin
  
  # Add MySQL bin (usually /usr/local/mysql/bin)
  mysql_bin=/usr/local/mysql/bin
  mysql_bin=`echo $mysql_bin`
  [[ -e $mysql_bin ]] && export PATH=$PATH:$mysql_bin
fi

for comp in \
    /usr/local/etc/bash_completion \
    /usr/local/etc/bash_completion.d/git-completion.bash \
	/usr/local/Library/Contributions/brew_bash_completion.sh
do
    [[ -e $comp ]] && source $comp
done

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
alias reload='. ~/.bash_profile'
alias weather='python3 ~/bin/pyweather 58102'
alias gmail='python3 ~/dev/py/pygmail/gmail-unread.py'

# show/hide hidden files in Finder
# I don't really need these, but they might be useful at some point
alias shf='defaults write com.apple.Finder AppleShowAllFiles YES'
alias hhf='defaults write com.apple.Finder AppleShowAllFiles NO'


## Functions
# Open a manpage in Preview, which can be saved to PDF
pdfman() {
   man -t "${1}" | open -f -a /Applications/Preview.app
}