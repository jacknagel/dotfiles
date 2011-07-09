#
# ~/.bash_aliases
#

# silence cdspell and $CDPATH echo
function cd () {
    builtin cd "$@" 1> /dev/null
}

alias ..='cd ..'
alias ...='cd ../../'
alias fl='ls -lFrtah | less -R'
alias edit='em'
alias uemacs='em'
alias vi='vim'
alias sizes='du -h -d1'
alias weather='python3 ~/bin/pyweather 58102'
alias ip='ipconfig getifaddr en0'
alias ifip='ifconfig | grep inet'
alias killws="perl -pe \'s/[\t ]+$//g\'"
alias su='su -l' # -l: discard current environment
alias indent='gindent'
alias pine='alpine'
alias gpg='gpg2'

# show/hide hidden files in Finder
alias showhf='defaults write com.apple.Finder AppleShowAllFiles YES | killall Finder'
alias hidehf='defaults write com.apple.Finder AppleShowAllFiles NO | killall Finder'
