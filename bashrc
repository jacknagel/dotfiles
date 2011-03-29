#
# ~/.bashrc
#


# If not running interactively, don't do anything
[ -z "$PS1" ] && return


#
# some environment variables
#
export EDITOR='mate -w'
export GIT_EDITOR='mate -wl1'
# export CLICOLOR_FORCE=1 # don't use this -- it breaks a lot of stuff
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export GREP_OPTIONS='--color=auto'
export FIGNORE="~:.pyc:.swp:.swa:" # file suffixes to ignore during tab completion
export COPYFILE_DISABLE=true # no ._ files in archives


#
# History control
#
export HISTCONTROL=ignoreboth:erasedups


#
# Bash shell options
#
shopt -s autocd cdspell dirspell
shopt -s dotglob extglob globstar
shopt -s cmdhist histappend
shopt -s no_empty_cmd_completion
shopt -s checkjobs
shopt -s checkwinsize 


#
# PATH
#
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# add home directory 
for dir in \
    $HOME/bin
do
    [[ -e $dir ]] && export PATH=$PATH:$dir
done

# Add Homebrew-installed bins to $PATH
# see https://github.com/mxcl/homebrew/wiki/Homebrew-and-Python
if [[ -n `which brew` ]]; then
    # Homebrew Python
    python_bin=$(brew --cellar python)/*/bin
    python_bin=`echo $python_bin`
    [[ -e $python_bin ]] && export PATH=$PATH:$python_bin

    [[ -e /usr/local/share/python ]] && export PATH=/usr/local/share/python:$PATH

    # Homebrew Python 3
    python3_bin=$(brew --cellar python3)/*/bin
    python3_bin=`echo $python3_bin`
    [[ -e $python3_bin ]] && export PATH=$PATH:$python3_bin

    # Homebrew Ruby
    ruby_bin=$(brew --cellar ruby)/*/bin
    ruby_bin=`echo $ruby_bin`
    [[ -e $ruby_bin ]] && export PATH=$PATH:$ruby_bin

    # Homebrew MySQL
    mysql_bin=$(brew --cellar mysql)/*/bin
    mysql_bin=`echo $mysql_bin`
    [[ -e $mysql_bin ]] && export PATH=$PATH:$mysql_bin
fi

# Bash completion
for comp in \
    /usr/local/etc/bash_completion \
    /usr/local/etc/bash_completion.d/git-completion.bash \
    /usr/local/Library/Contributions/brew_bash_completion.sh
do
    [[ -e $comp ]] && source $comp
done


#
# Pager
#
export PAGER="less -iSw"
export MANPAGER="less -iSw"


#
# Aliases
#
alias fl='ls -lFrtah | less -R'
alias edit='vim'
alias vi='vim'
alias sizes='du -h -d1'
alias weather='python3 ~/bin/pyweather 58102'
alias gmail='python3 ~/dev/py/pygmail/gmail-unread.py'
alias ip='ipconfig getifaddr en0'
alias ifip='ifconfig | grep inet'
alias killws="perl -pe \'s/[\t ]+$//g\'"

# show/hide hidden files in Finder
alias shf='defaults write com.apple.Finder AppleShowAllFiles YES | killall Finder'
alias hhf='defaults write com.apple.Finder AppleShowAllFiles NO | killall Finder'
