#
# ~/.bash_aliases
#

# silence cdspell corrections and $CDPATH echo
function cd () {
    builtin cd "$@" &>/dev/null
}

alias fl='ls -lFrtah | less -R'
alias edit='vim'
alias vi='vim'
alias sizes='du -h -d1'
alias weather='python3 ~/bin/pyweather 58102'
alias ip='ipconfig getifaddr en0'
alias ifip='ifconfig | grep inet'
alias killws="perl -pe \'s/[\t ]+$//g\'"

# show/hide hidden files in Finder
alias shf='defaults write com.apple.Finder AppleShowAllFiles YES | killall Finder'
alias hhf='defaults write com.apple.Finder AppleShowAllFiles NO | killall Finder'
